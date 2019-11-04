abstract class CalculatorState {
  const CalculatorState();
}

class InitialCalculatorState extends CalculatorState {}

class PtaxDollarState extends CalculatorState {
  final double dollarValue;

  PtaxDollarState({this.dollarValue});
}
