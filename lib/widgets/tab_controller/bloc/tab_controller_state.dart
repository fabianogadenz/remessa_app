import 'package:meta/meta.dart';

class TabControllerState {
  final bool success;
  final String errorMessage;
  final bool isLoading;
  final int currentTabIndex;

  TabControllerState({
    this.success = false,
    this.errorMessage,
    this.isLoading = false,
    @required this.currentTabIndex,
  }) : assert(currentTabIndex != null);
}
