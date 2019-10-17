// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ptax_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PtaxModel _$PtaxModelFromJson(Map<String, dynamic> json) {
  return PtaxModel(
    values: (json['value'] as List)
        ?.map((e) => (e as Map<String, dynamic>)?.map(
              (k, e) => MapEntry(k, (e as num)?.toDouble()),
            ))
        ?.toList(),
  );
}

Map<String, dynamic> _$PtaxModelToJson(PtaxModel instance) => <String, dynamic>{
      'value': instance.values,
    };
