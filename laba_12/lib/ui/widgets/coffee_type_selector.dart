import 'package:flutter/material.dart';
import '../../enums.dart';

extension StringExtension on String {
  String capitalize() {
    if (isEmpty) return this;
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}

class CoffeeTypeSelector extends StatefulWidget {
  final CoffeeType? selectedType;
  final ValueChanged<CoffeeType?> onTypeChanged;

  const CoffeeTypeSelector({
    Key? key,
    required this.selectedType,
    required this.onTypeChanged,
  }) : super(key: key);

  @override
  _CoffeeTypeSelectorState createState() => _CoffeeTypeSelectorState();
}

class _CoffeeTypeSelectorState extends State<CoffeeTypeSelector> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
          CoffeeType.values.map((type) {
            return ListTile(
              title: Text(type.toString().split('.').last.capitalize()),
              leading: Radio<CoffeeType>(
                value: type,
                groupValue: widget.selectedType,
                onChanged: widget.onTypeChanged,
              ),
              dense: true,
            );
          }).toList(),
    );
  }
}
