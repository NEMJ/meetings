import 'package:flutter/material.dart';

class DropdownButtonFormFieldWidget extends StatelessWidget {
  const DropdownButtonFormFieldWidget({
    required this.label,
    this.value,
    required this.listItems,
    required this.onChanged,
    super.key,
  });
  
  final String label;
  final String? value;
  final Function(String?) onChanged;
  final List<String> listItems;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: DropdownButtonFormField(
        value: value,
        items: listItems.map(
          (item) => DropdownMenuItem(
            value: item,
            child: Text(
              item,
              style: const TextStyle(fontWeight: FontWeight.normal),
            ),
          ),
        ).toList(),
        onChanged: onChanged,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(18),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          labelText: label,
          labelStyle: const TextStyle(
            color: Colors.deepPurple,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
          border: const OutlineInputBorder(),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey.shade300,
              width: 2,
            ),
          ),
        ),
      ),
    );
  }
}