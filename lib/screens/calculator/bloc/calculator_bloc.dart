import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:remessa_app/services/ptax_service.dart';
import './bloc.dart';

class CalculatorBloc extends Bloc<CalculatorEvent, CalculatorState> {
  @override
  CalculatorState get initialState => InitialCalculatorState();

  Stream<CalculatorState> _mapLoadPtaxDollarToState(
      LoadPtaxDollar event) async* {
    try {
      final ptaxDollarValue =
          await PtaxService().getDollarValue(event.dateTime);

      yield PtaxDollarState(dollarValue: ptaxDollarValue);
    } catch (_) {}
    yield PtaxDollarState(dollarValue: 2);
  }

  @override
  Stream<CalculatorState> mapEventToState(
    CalculatorEvent event,
  ) async* {
    if (event is LoadPtaxDollar) {
      yield* _mapLoadPtaxDollarToState(event);
    }
  }
}
