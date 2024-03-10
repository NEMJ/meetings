import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatefulWidget {
  const TextFormFieldWidget({
    required this.label,
    required this.controller,
    this.onTap,
    this.validator,
    super.key
  });

  final String label;
  final TextEditingController controller;
  final Function()? onTap;
  final bool? validator;

  @override
  State<TextFormFieldWidget> createState() => _TextFormFieldWidgetState();
}

class _TextFormFieldWidgetState extends State<TextFormFieldWidget> {
    
  String hintText = '';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        controller: widget.controller,
        onTap: widget.onTap,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(
            fontWeight: FontWeight.w400,
            color: Color.fromARGB(180, 211, 47, 47),
          ),
          errorStyle: const TextStyle(fontSize: 0, height: -8),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              width: 2.0,
              color: Color.fromARGB(180, 211, 47, 47),
            ),
          ),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          labelText: widget.label,
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
        validator: widget.validator == true
          ? (value) {
            if (value == null || value.isEmpty) {
              setState(() => hintText = 'campo obrigatório');
              return '';
            } else {
              setState(() => hintText = '');
              return null;
            }
          }
          : null,
      ),
    );
  }
}