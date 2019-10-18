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
