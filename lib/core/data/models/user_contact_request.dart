import 'package:json_annotation/json_annotation.dart';

part 'user_contact_request.g.dart';

@JsonSerializable(explicitToJson: true)
class UserContactRequest {
  @JsonKey(name: 'user_id')
  final int userId;

  @JsonKey(name: 'type_request')
  final int typeRequest;

  @JsonKey(name: 'type_question')
  final int typeQuestion;

  final String message;

  /// List of imgs (base64 + ext)
  final List<AssistanceImage> images;

  UserContactRequest({
    required this.userId,
    required this.typeRequest,
    required this.typeQuestion,
    required this.message,
    List<AssistanceImage>? images,
  }) : images = images ?? [];

  
  factory UserContactRequest.fromJson(Map<String, dynamic> json) =>
      _$UserContactRequestFromJson(json);

  /// To convert in JSON 
  Map<String, dynamic> toJson() => _$UserContactRequestToJson(this);
}

@JsonSerializable()
class AssistanceImage {
  final String img;

  /// ext -> .png
  final String ext;

  AssistanceImage({
    required this.img,
    required this.ext,
  });

  factory AssistanceImage.fromJson(Map<String, dynamic> json) =>
      _$AssistanceImageFromJson(json);

  Map<String, dynamic> toJson() => _$AssistanceImageToJson(this);
}
