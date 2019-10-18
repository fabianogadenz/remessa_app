import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class TabControllerBloc extends Bloc<TabControllerEvent, TabControllerState> {
  @override
  TabControllerState get initialState => TabControllerState(
        currentTabIndex: 0,
      );

  Stream<TabControllerState> _mapChangeTabToState(ChangeTabEvent event) async* {
    yield TabControllerState(
      currentTabIndex: event.index,
    );
  }

  @override
  Stream<TabControllerState> mapEventToState(
    TabControllerEvent event,
  ) async* {
    if (event is ChangeTabEvent) {
      yield* _mapChangeTabToState(event);
    }
  }
}
