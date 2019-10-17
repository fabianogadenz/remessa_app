import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:remessa_app/helpers/serializable.dart';

part 'ptax_model.g.dart';

@JsonSerializable()
class PtaxModel extends Equatable implements Serializable {
  PtaxModel({this.values});

  @JsonKey(name: 'value')
  final List<Map<String, double>> values;

  double get dollarValue => values[0]['cotacaoCompra'];

  @override
  List<Object> get props => [values];

  factory PtaxModel.fromJson(Map json) => _$PtaxModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$PtaxModelToJson(this);
}
