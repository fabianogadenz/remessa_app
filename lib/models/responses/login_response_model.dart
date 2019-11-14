import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:remessa_app/helpers/serializable.dart';

part 'login_response_model.g.dart';

@JsonSerializable()
class LoginResponseModel extends Equatable implements Serializable {
  LoginResponseModel({
    this.token,
    this.customerId,
  });

  final String token;
  final int customerId;

  @override
  List<Object> get props => [token, customerId];

  factory LoginResponseModel.fromJson(Map json) =>
      _$LoginResponseModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$LoginResponseModelToJson(this);
}
