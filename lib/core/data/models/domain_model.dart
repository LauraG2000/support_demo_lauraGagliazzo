import 'package:json_annotation/json_annotation.dart';

part 'domain_model.g.dart';

@JsonSerializable()
class DomainResponse {
  final String environment;
  final bool success;
  final int code;
  final String message;
  
  // Key is String -> JSON = "0", "2", "4",
  final Map<String, DomainData> data;

  DomainResponse({
    required this.environment,
    required this.success,
    required this.code,
    required this.message,
    required this.data,
  });

  factory DomainResponse.fromJson(Map<String, dynamic> json) =>
      _$DomainResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DomainResponseToJson(this);
}

@JsonSerializable()
class DomainData {
  @JsonKey(name: 'id_domain')
  final int idDomain;

  @JsonKey(name: 'cod_lang')
  final String codLang;

  @JsonKey(name: 'type_card_id')
  final int typeCardId;

  @JsonKey(name: 'type_domain')
  final String typeDomain;

  @JsonKey(name: 'dom_title')
  final String? domTitle;

  @JsonKey(name: 'dom_value')
  final String? domValue;

  @JsonKey(name: 'dom_order')
  final int? domOrder;

  @JsonKey(name: 'is_confirmed')
  final int isConfirmed;

  @JsonKey(name: 'parent_id_domain')
  final int? parentIdDomain;

  @JsonKey(name: 'dom_description')
  final String? domDescription;

  @JsonKey(name: 'disable_copy')
  final int disableCopy;

  @JsonKey(name: 'name_group')
  final String? nameGroup;

  DomainData({
    required this.idDomain,
    required this.codLang,
    required this.typeCardId,
    required this.typeDomain,
    this.domTitle,
    required this.domValue,
    this.domOrder,
    required this.isConfirmed,
    this.parentIdDomain,
    this.domDescription,
    required this.disableCopy,
    this.nameGroup,
  });

  factory DomainData.fromJson(Map<String, dynamic> json) =>
      _$DomainDataFromJson(json);

  Map<String, dynamic> toJson() => _$DomainDataToJson(this);
}
