import 'package:flutter/material.dart';
import 'screens/main_screen.dart';
import 'screens/second_screen.dart';

void main() {
  runApp(
    MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (BuildContext context) => const MainScreen(),
      '/second': (BuildContext context) => const SecondScreen(),
    },
  ));
}