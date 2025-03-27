import 'package:flutter/material.dart';

void main() => runApp(
  MaterialApp(
    theme: ThemeData(
      primarySwatch: Colors.blue,
      scaffoldBackgroundColor: Colors.white,
    ),
    home: AreaCalculator(),
  ),
);

class AreaCalculator extends StatefulWidget {
  const AreaCalculator({Key? key}) : super(key: key);

  @override
  _AreaCalculatorState createState() => _AreaCalculatorState();
}

class _AreaCalculatorState extends State<AreaCalculator> {
  final _formKey = GlobalKey<FormState>();
  final _widthField = TextEditingController();
  final _heightField = TextEditingController();
  String _square = '';

  String formatValue(double value) {
    if (value % 1 == 0) {
      return value.toInt().toString();
    }
    return value.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Калькулятор площади')),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text('Ширина (мм):', style: TextStyle(fontSize: 20)),
                TextFormField(
                  controller: _widthField,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Задайте Ширину';
                    }
                    final n = num.tryParse(value);
                    if (n! <= 0) {
                      return 'Введите положительное число';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                const Text('Высота (мм):', style: TextStyle(fontSize: 20)),
                TextFormField(
                  controller: _heightField,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Задайте Высоту';
                    }
                    final n = num.tryParse(value);
                    if (n! <= 0) {
                      return 'Введите положительное число';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final width = double.parse(_widthField.text);
                        final height = double.parse(_heightField.text);
                        final area = width * height;
                        setState(() {
                          _square =
                              'S = ${formatValue(width)} * ${formatValue(height)} = ${formatValue(area)} (мм²)';
                        });
                      }
                    },
                    child: const Text('Вычислить'),
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: Text(
                    _square.isEmpty ? 'задайте параметры' : _square,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
