import 'package:equatable/equatable.dart';

abstract class CalculatorEvent extends Equatable {
  const CalculatorEvent();
}

class LoadPtaxDollar extends CalculatorEvent {
  final DateTime dateTime;

  LoadPtaxDollar({this.dateTime});

  @override
  List<Object> get props => [dateTime];
}
