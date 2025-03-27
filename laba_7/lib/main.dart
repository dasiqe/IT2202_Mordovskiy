import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (BuildContext context) => const MainScreen(),
        '/second': (BuildContext context) => const SecondScreen(),
      },
    ),
  );
}

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  void _openSecondScreen(BuildContext context) {
    Navigator.pushNamed(context, '/second').then((result) {
      if (result != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('$result'),
            backgroundColor: Colors.black,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Возвращение значения')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _openSecondScreen(context),
          child: const Text('Приступить к выбору...'),
        ),
      ),
    );
  }
}

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
