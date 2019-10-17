import 'package:remessa_app/screens/calculator/calculator_screen.dart';
import 'package:flutter/material.dart';

import 'package:remessa_app/theme.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora de compra internacional',
      debugShowCheckedModeBanner: false,
      theme: AppTheme().theme,
      home: CalculatorScreen(),
    );
  }
}
