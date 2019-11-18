// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'error_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ErrorResponseModel _$ErrorResponseModelFromJson(Map<String, dynamic> json) {
  return ErrorResponseModel(
    field: json['field'] as String,
    message: json['message'] as String,
    code: json['code'] as String,
  );
}

Map<String, dynamic> _$ErrorResponseModelToJson(ErrorResponseModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'field': instance.field,
      'message': instance.message,
    };
