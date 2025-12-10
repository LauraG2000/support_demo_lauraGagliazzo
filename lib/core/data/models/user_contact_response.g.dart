// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_contact_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserContactResponse _$UserContactResponseFromJson(Map<String, dynamic> json) =>
    UserContactResponse(
      environment: json['environment'] as String,
      success: json['success'] as bool,
      code: (json['code'] as num).toInt(),
      message: json['message'] as String,
    );

Map<String, dynamic> _$UserContactResponseToJson(
  UserContactResponse instance,
) => <String, dynamic>{
  'environment': instance.environment,
  'success': instance.success,
  'code': instance.code,
  'message': instance.message,
};
