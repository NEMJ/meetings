import 'package:flutter/material.dart';

class TimeListTileWidget extends StatefulWidget {
  const TimeListTileWidget({
    required this.controller,
    this.label,
    super.key,
  });

  final TextEditingController controller;
  final String? label;

  @override
  State<TimeListTileWidget> createState() => _TimeListTileWidgetState();
}

class _TimeListTileWidgetState extends State<TimeListTileWidget> {

  late TimeOfDay selectedTime;

  @override
  void initState() {
    // Se o controller vier vazio quer dizer que é um novo cadastro
    selectedTime = (widget.controller.text == '')
      ? TimeOfDay.now() // Hora mostrada pelo TimePicker será a atual para novos cadastros
      : TimeOfDay(
        hour: int.parse(widget.controller.text.split(':')[0]),
        minute: int.parse(widget.controller.text.split(':')[1]), 
      );
    super.initState();
  }
  

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: ListTile(
          onTap: () async {
            final TimeOfDay? timeOfDay = await showTimePicker(
              context: context,
              initialTime: selectedTime,
              initialEntryMode: TimePickerEntryMode.dial,
            );
            if(timeOfDay != null) {
              setState(() => selectedTime = timeOfDay);
              widget.controller.text = "${timeOfDay.hour.toString().padLeft(2, '0')}:${timeOfDay.minute.toString().padLeft(2, '0')}";
            }
          },
          tileColor: Colors.deepPurple.shade50,
          title: Text(
            "${widget.label}${widget.controller.text}",
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.deepPurple,
              fontWeight: FontWeight.w500,
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          trailing: const Icon(Icons.edit, size: 20, color: Colors.deepPurple),
        ),
      ),
    );
  }
}