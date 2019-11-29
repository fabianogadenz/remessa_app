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

  Stream<TabControllerState> _mapLoadingTabToState(
      LoadingTabEvent event) async* {
    yield TabControllerState(
      currentTabIndex: state.currentTabIndex,
      isLoading: event.isLoading,
    );
  }

  Stream<TabControllerState> _mapErrorTabToState(ErrorTabEvent event) async* {
    yield TabControllerState(
      currentTabIndex: state.currentTabIndex,
      errorMessage: event.errorMessage,
    );
  }

  @override
  Stream<TabControllerState> mapEventToState(
    TabControllerEvent event,
  ) async* {
    if (event is ChangeTabEvent) {
      yield* _mapChangeTabToState(event);
    }

    if (event is LoadingTabEvent) {
      yield* _mapLoadingTabToState(event);
    }

    if (event is ErrorTabEvent) {
      yield* _mapErrorTabToState(event);
    }
  }
}
