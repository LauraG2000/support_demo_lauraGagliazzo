import 'package:joyflo_project/core/data/models/user_contact_request.dart';

class SupportState {
  final List<AssistanceImage> images;
  final bool canAddImage;

  SupportState({
    required this.images,
    this.canAddImage = true,
    });

  SupportState copyWith({
    List<AssistanceImage>? images,
    bool? canAddImage,
    }) {
    return SupportState(
      images: images ?? this.images,
      canAddImage: canAddImage ?? this.canAddImage,
    );
  }
}
