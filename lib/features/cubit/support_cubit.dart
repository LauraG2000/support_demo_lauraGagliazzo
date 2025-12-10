import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:joyflo_project/core/data/models/user_contact_request.dart';
import 'package:joyflo_project/core/data/models/user_contact_response.dart';
import 'package:joyflo_project/core/domains/usecases/get_domains_usecase.dart';
import 'package:joyflo_project/core/domains/usecases/user_contact_usecase.dart';
import 'package:joyflo_project/features/cubit/state/support_state.dart';
import 'package:path_provider/path_provider.dart';

//  UseCases for the page
class SupportCubit extends Cubit<SupportState> {
  final GetDomainsUseCase getDomainsUseCase;
  final UserContactUseCase userContactUseCase;

  SupportCubit({required this.getDomainsUseCase, required this.userContactUseCase}) : super(SupportState(images: []));

  // Send request (for the page)
  Future<UserContactResponse> sendAssistanceRequest(UserContactRequest request) async {
    return await userContactUseCase.sendAssistanceRequest(request);
  }

  // Picking image
  Future<String> pickImageFromCamera(BuildContext context) async {
    if (state.images.length >= 5) {
      return "Troppe immagini allegate";
    }

    try {
      final XFile? photo = await ImagePicker().pickImage(source: ImageSource.camera, preferredCameraDevice: CameraDevice.rear);

      if (photo == null) return "";

      // Step 1: convertion to PNG
      final File pngFile = await _convertToPng(File(photo.path));

      // Step 2: reduce under 700 KB
      final File resized = await _compressBelow700KB(pngFile);

      // Step 3: convertion to base64
      final bytes = await resized.readAsBytes();
      final base64Str = base64Encode(bytes);

      // !!! A Server could request this prefix !!!
      //final completeb64Str = "data:image/png;base64," +base64Str;
      final updated = List<AssistanceImage>.from(state.images)..add(AssistanceImage(img: base64Str, ext: ".png"));

      emit(
        state.copyWith(
          images: updated,
          canAddImage: updated.length < 5, // disabilit ADD if >= 5
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Si è verificato un errore: $e")));
    }
    return "";
  }

  // png conversion
  Future<File> _convertToPng(File original, {int maxWidth = 400}) async {
    final outPath = "${original.path}.png";

    final result = await FlutterImageCompress.compressAndGetFile(
      original.path,
      outPath,
      format: CompressFormat.png,
      quality: 100,
      minWidth: maxWidth,
      minHeight: (maxWidth * 16 / 9).toInt(), // keep proportion
    );

    return File(result!.path);
  }

  // Img compression
  Future<File> _compressBelow700KB(File file) async {
    const int maxSize = 700 * 1024; // 700 KB
    int quality = 90;
    File result = file;

    while (true) {
      final compressed = await FlutterImageCompress.compressWithFile(file.path, format: CompressFormat.png, quality: quality);

      if (compressed == null) break;

      if (compressed.length < maxSize || quality < 10) {
        final dir = await getTemporaryDirectory();
        final outFile = File("${dir.path}/img_${DateTime.now().millisecondsSinceEpoch}.png");
        await outFile.writeAsBytes(compressed);
        return outFile;
      }

      quality -= 10; // gradual reduction
    }
    return result;
  }

  // Remove Img
  void removeImage(AssistanceImage img) {
    final updated = List<AssistanceImage>.from(state.images)..remove(img);
    emit(state.copyWith(images: updated, canAddImage: updated.length < 5)); // if < 5 -> abilit adding
  }
}
