import 'package:flutter/material.dart';
import '../models/checkbox_model.dart';

class CheckboxWidget extends StatefulWidget {
  const CheckboxWidget({
    required this.meetingCheckbox,
    super.key,
  });

  final CheckboxModel meetingCheckbox;

  @override
  State<CheckboxWidget> createState() => _CheckboxWidgetState();
}

class _CheckboxWidgetState extends State<CheckboxWidget> {
  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(widget.meetingCheckbox.title),
      value: widget.meetingCheckbox.value,
      onChanged: (value) {
        setState(() => widget.meetingCheckbox.value = value ?? false);
      }
    );
  }
}