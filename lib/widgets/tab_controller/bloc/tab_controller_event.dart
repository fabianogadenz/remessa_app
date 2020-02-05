import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class TabControllerEvent extends Equatable {
  const TabControllerEvent();
}

class ChangeTabEvent extends TabControllerEvent {
  final int index;

  ChangeTabEvent({@required this.index}) : assert(index != null);

  @override
  List<Object> get props => [index];
}

class LoadingTabEvent extends TabControllerEvent {
  final bool isLoading;

  LoadingTabEvent({@required this.isLoading}) : assert(isLoading != null);

  @override
  List<Object> get props => [isLoading];
}

class ErrorTabEvent extends TabControllerEvent {
  final String errorMessage;

  ErrorTabEvent({@required this.errorMessage}) : assert(errorMessage != null);

  @override
  List<Object> get props => [errorMessage];
}
