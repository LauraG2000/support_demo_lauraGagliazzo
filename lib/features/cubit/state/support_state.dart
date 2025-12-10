import 'package:joyflo_project/core/data/models/user_contact_request.dart';

class SupportState {
  final List<AssistanceImage> images;

  SupportState({required this.images});

  SupportState copyWith({List<AssistanceImage>? images}) {
    return SupportState(
      images: images ?? this.images,
    );
  }
}
