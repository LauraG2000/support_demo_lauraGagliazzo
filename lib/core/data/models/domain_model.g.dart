// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'domain_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DomainResponse _$DomainResponseFromJson(Map<String, dynamic> json) =>
    DomainResponse(
      environment: json['environment'] as String,
      success: json['success'] as bool,
      code: (json['code'] as num).toInt(),
      message: json['message'] as String,
      data: (json['data'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, DomainData.fromJson(e as Map<String, dynamic>)),
      ),
    );

Map<String, dynamic> _$DomainResponseToJson(DomainResponse instance) =>
    <String, dynamic>{
      'environment': instance.environment,
      'success': instance.success,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };

DomainData _$DomainDataFromJson(Map<String, dynamic> json) => DomainData(
  idDomain: (json['id_domain'] as num).toInt(),
  codLang: json['cod_lang'] as String,
  typeCardId: (json['type_card_id'] as num).toInt(),
  typeDomain: json['type_domain'] as String,
  domTitle: json['dom_title'] as String?,
  domValue: json['dom_value'] as String?,
  domOrder: (json['dom_order'] as num?)?.toInt(),
  isConfirmed: (json['is_confirmed'] as num).toInt(),
  parentIdDomain: (json['parent_id_domain'] as num?)?.toInt(),
  domDescription: json['dom_description'] as String?,
  disableCopy: (json['disable_copy'] as num).toInt(),
  nameGroup: json['name_group'] as String?,
);

Map<String, dynamic> _$DomainDataToJson(DomainData instance) =>
    <String, dynamic>{
      'id_domain': instance.idDomain,
      'cod_lang': instance.codLang,
      'type_card_id': instance.typeCardId,
      'type_domain': instance.typeDomain,
      'dom_title': instance.domTitle,
      'dom_value': instance.domValue,
      'dom_order': instance.domOrder,
      'is_confirmed': instance.isConfirmed,
      'parent_id_domain': instance.parentIdDomain,
      'dom_description': instance.domDescription,
      'disable_copy': instance.disableCopy,
      'name_group': instance.nameGroup,
    };
