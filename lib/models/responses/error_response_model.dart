import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:remessa_app/helpers/serializable.dart';

part 'error_response_model.g.dart';

@JsonSerializable()
class ErrorResponseModel extends Equatable implements Serializable {
  ErrorResponseModel({
    this.field,
    this.message,
    this.code,
  });

  final String code;
  final String field;
  final String message;

  @override
  List<Object> get props => [code, field, message];

  factory ErrorResponseModel.fromJson(Map json) =>
      _$ErrorResponseModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ErrorResponseModelToJson(this);
}
