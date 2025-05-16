import 'package:flutter/material.dart';
import '../../machine.dart';
import '../widgets/resource_display_card.dart';
import '../widgets/resource_input_widget.dart';

class ResourcePage extends StatefulWidget {
  final Machine machine;
  final VoidCallback onMachineStateChanged;

  const ResourcePage({
    super.key,
    required this.machine,
    required this.onMachineStateChanged,
  });

  @override
  State<ResourcePage> createState() => _ResourcePageState();
}

class _ResourcePageState extends State<ResourcePage> {
  final TextEditingController _beansController = TextEditingController();
  final TextEditingController _milkController = TextEditingController();
  final TextEditingController _waterController = TextEditingController();
  final TextEditingController _cashController = TextEditingController();

  @override
  void dispose() {
    _beansController.dispose();
    _milkController.dispose();
    _waterController.dispose();
    _cashController.dispose();
    super.dispose();
  }

  void _addResources() {
    final int beansToAdd = int.tryParse(_beansController.text) ?? 0;
    final int milkToAdd = int.tryParse(_milkController.text) ?? 0;
    final int waterToAdd = int.tryParse(_waterController.text) ?? 0;
    final int cashToAdd = int.tryParse(_cashController.text) ?? 0;

    if (beansToAdd > 0 || milkToAdd > 0 || waterToAdd > 0 || cashToAdd > 0) {
      widget.machine.fillResources(
        beans: beansToAdd,
        milk: milkToAdd,
        water: waterToAdd,
        cash: cashToAdd,
      );

      widget.onMachineStateChanged();

      _beansController.clear();
      _milkController.clear();
      _waterController.clear();
      _cashController.clear();

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Ресурсы добавлены.")));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Введите количество ресурсов для добавления."),
        ),
      );
    }
  }

  void _collectCash() {
    if (widget.machine.resources.cash > 0) {
      int collected = widget.machine.resources.cash;
      widget.machine.resources.cash = 0;
      widget.onMachineStateChanged();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Инкассация завершена. Собрано $collected ₽.")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Нет денег для инкассации.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ResourceDisplayCard(machine: widget.machine),
          const SizedBox(height: 20),

          const Text(
            'Изменить ресурсы:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          ResourceInputWidget(label: 'Кофе (г):', controller: _beansController),
          ResourceInputWidget(
            label: 'Молоко (мл):',
            controller: _milkController,
          ),
          ResourceInputWidget(
            label: 'Вода (мл):',
            controller: _waterController,
          ),
          ResourceInputWidget(
            label: 'Деньги (₽):',
            controller: _cashController,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _addResources,
            child: const Text('Добавить Ресурсы'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: _collectCash,
            child: const Text('Инкассация'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurple,
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
