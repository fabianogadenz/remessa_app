import 'package:flutter/foundation.dart';

class ScreenState<T> {
  final bool success;
  final String errorMessage;
  final bool isLoading;
  final T value;

  ScreenState({
    this.success = false,
    this.errorMessage,
    this.isLoading = false,
    @required this.value,
  }) : assert(value != null);
}
