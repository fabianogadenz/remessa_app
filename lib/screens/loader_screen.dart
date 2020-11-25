import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:screens/screens.dart';

class LoaderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetIt.I<Screens>().widget(
      isStatic: true,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
