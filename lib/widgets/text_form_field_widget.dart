import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatelessWidget {
  final String label;
  final TextEditingController controller;

  const TextFormFieldWidget({
    required this.label,
    required this.controller,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.always,
          labelText: label,
          labelStyle: const TextStyle(
            color: Colors.deepPurple,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
          border: const OutlineInputBorder(),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade300, width: 2),
          ),
        ),
      ),
    );
  }
}