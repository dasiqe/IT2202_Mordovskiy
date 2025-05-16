import 'package:flutter/material.dart';
import '../../machine.dart';
import '../../enums.dart';
import '../../coffee_types.dart';
import '../../i_coffee.dart';
import '../widgets/resource_display_card.dart';
import '../widgets/coffee_type_selector.dart';

class CoffeePage extends StatefulWidget {
  final Machine machine;
  final VoidCallback onMachineStateChanged;

  const CoffeePage({
    super.key,
    required this.machine,
    required this.onMachineStateChanged,
  });

  @override
  State<CoffeePage> createState() => _CoffeePageState();
}

class _CoffeePageState extends State<CoffeePage> {
  CoffeeType? _selectedCoffeeType;
  bool _isMakingCoffee = false;
  final TextEditingController _moneyController = TextEditingController();

  final Map<CoffeeType, int> _coffeePrices = {};

  @override
  void initState() {
    super.initState();
    for (var type in CoffeeType.values) {
      ICoffee? coffee = getCoffeeInstance(type);
      if (coffee != null) {
        _coffeePrices[type] = coffee.cash();
      }
    }
  }

  @override
  void dispose() {
    _moneyController.dispose();
    super.dispose();
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: const Duration(seconds: 2)),
    );
  }

  Future<void> _makeCoffee() async {
    if (_selectedCoffeeType == null || _isMakingCoffee) {
      _showSnackBar(
        _selectedCoffeeType == null ? 'Выберите тип кофе!' : 'Уже готовим...',
      );
      return;
    }

    final int enteredAmount = int.tryParse(_moneyController.text) ?? 0;
    final int requiredAmount = _coffeePrices[_selectedCoffeeType!] ?? 0;

    if (enteredAmount < requiredAmount) {
      _showSnackBar('Недостаточно средств! Нужно $requiredAmount ₽');
      return;
    }

    ICoffee? coffee = getCoffeeInstance(_selectedCoffeeType!);
    if (coffee == null || !widget.machine.isAvailableResources(coffee)) {
      _showSnackBar('Недостаточно ингредиентов!');
      return;
    }

    setState(() {
      _isMakingCoffee = true;
    });

    widget.machine.fillResources(cash: requiredAmount);
    widget.onMachineStateChanged();

    int change = enteredAmount - requiredAmount;

    _moneyController.clear();

    _showSnackBar(
      '${_selectedCoffeeType.toString().split('.').last.capitalize()} готовится...',
    );

    try {
      await widget.machine.makeCoffeeByType(_selectedCoffeeType!);

      widget.onMachineStateChanged();

      _showSnackBar(
        '${_selectedCoffeeType.toString().split('.').last.capitalize()} готов!',
      );

      if (change > 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Ваша сдача: $change ₽'),
            duration: const Duration(seconds: 3),
            backgroundColor: Colors.blueGrey,
          ),
        );
      }
    } catch (e) {
      widget.onMachineStateChanged();
      _showSnackBar('Ошибка при приготовлении: $e');
    }

    setState(() {
      _isMakingCoffee = false;
    });
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
            'Кофемашина',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),

          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CoffeeTypeSelector(
                selectedType: _selectedCoffeeType,
                onTypeChanged: (type) {
                  setState(() {
                    _selectedCoffeeType = type;
                  });
                },
              ),
            ),
          ),
          const SizedBox(height: 20),

          const Text(
            'Оплата:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _moneyController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: 'Введите сумму',
              border: OutlineInputBorder(),
              isDense: true,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 12,
              ),
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: _isMakingCoffee ? null : _makeCoffee,
            icon:
                _isMakingCoffee
                    ? SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 3,
                        color: Colors.white,
                      ),
                    )
                    : const Icon(Icons.play_arrow),
            label: Text(
              _isMakingCoffee
                  ? 'Готовим...'
                  : 'Приготовить ${_selectedCoffeeType?.toString().split('.').last.capitalize() ?? "кофе"} (${_coffeePrices[_selectedCoffeeType] ?? 0} ₽)',
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 12),
              textStyle: const TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}
