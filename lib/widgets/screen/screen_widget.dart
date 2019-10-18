import 'package:flutter/material.dart';

class ScreenWidget extends StatelessWidget {
  final Widget child;

  const ScreenWidget({
    Key key,
    @required this.child,
  })  : assert(child != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: child,
      ),
    );
  }
}
