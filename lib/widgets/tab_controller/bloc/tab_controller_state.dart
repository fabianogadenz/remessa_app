import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class TabControllerState extends Equatable {
  final int currentTabIndex;

  TabControllerState({
    @required this.currentTabIndex,
  }) : assert(currentTabIndex != null);

  @override
  List<Object> get props => [currentTabIndex];
}
