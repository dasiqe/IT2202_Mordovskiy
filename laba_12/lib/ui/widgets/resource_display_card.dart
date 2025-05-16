import 'package:flutter/material.dart';
import '../../machine.dart';

class ResourceDisplayCard extends StatelessWidget {
  final Machine machine;

  const ResourceDisplayCard({super.key, required this.machine});

  @override
  Widget build(BuildContext context) {
    final resources = machine.resources;

    return Card(
      elevation: 3,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Ресурсы',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8, width: double.infinity),
            Text('Кофе: ${resources.coffeeBeans} г'),
            Text('Молоко: ${resources.milk} мл'),
            Text('Вода: ${resources.water} мл'),
            Text('Баланс: ${resources.cash} ₽'),
          ],
        ),
      ),
    );
  }
}
