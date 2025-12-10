// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_contact_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserContactRequest _$UserContactRequestFromJson(Map<String, dynamic> json) =>
    UserContactRequest(
      userId: (json['user_id'] as num).toInt(),
      typeRequest: (json['type_request'] as num).toInt(),
      typeQuestion: (json['type_question'] as num).toInt(),
      message: json['message'] as String,
      images: (json['images'] as List<dynamic>?)
          ?.map((e) => AssistanceImage.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UserContactRequestToJson(UserContactRequest instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'type_request': instance.typeRequest,
      'type_question': instance.typeQuestion,
      'message': instance.message,
      'images': instance.images.map((e) => e.toJson()).toList(),
    };

AssistanceImage _$AssistanceImageFromJson(Map<String, dynamic> json) =>
    AssistanceImage(img: json['img'] as String, ext: json['ext'] as String);

Map<String, dynamic> _$AssistanceImageToJson(AssistanceImage instance) =>
    <String, dynamic>{'img': instance.img, 'ext': instance.ext};
