import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ResourceInputWidget extends StatefulWidget {
  final String label;
  final TextEditingController controller;

  const ResourceInputWidget({
    Key? key,
    required this.label,
    required this.controller,
  }) : super(key: key);

  @override
  _ResourceInputWidgetState createState() => _ResourceInputWidgetState();
}

class _ResourceInputWidgetState extends State<ResourceInputWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Expanded(flex: 2, child: Text(widget.label)),
          Expanded(
            flex: 3,
            child: TextField(
              controller: widget.controller,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                isDense: true,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 12,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
