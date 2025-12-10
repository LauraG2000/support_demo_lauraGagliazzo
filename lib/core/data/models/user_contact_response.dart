import 'package:json_annotation/json_annotation.dart';

part 'user_contact_response.g.dart';

@JsonSerializable()
class UserContactResponse {
  final String environment;
  final bool success;
  final int code;
  final String message;

  UserContactResponse({
    required this.environment,
    required this.success,
    required this.code,
    required this.message,
  });

  factory UserContactResponse.fromJson(Map<String, dynamic> json) =>
      _$UserContactResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserContactResponseToJson(this);
}
