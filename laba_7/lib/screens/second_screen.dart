import 'package:flutter/material.dart';

class SecondScreen extends StatelessWidget {
  const SecondScreen({Key? key}) : super(key: key);

  void _selectOption(BuildContext context, String option) {
    Navigator.pop(context, option);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Выберите любой вариант')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () => _selectOption(context, 'Да!'),
              child: const Text('Да!'),
            ),
            ElevatedButton(
              onPressed: () => _selectOption(context, 'Нет.'),
              child: const Text('Нет.'),
            ),
          ],
        ),
      ),
    );
  }
}