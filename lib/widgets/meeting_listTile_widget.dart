import 'package:flutter/material.dart';
import '../models/meeting_model.dart';

class MeetingListTileWidget extends StatelessWidget {
  final MeetingModel meeting;
  final Function()? onTap;

  const MeetingListTileWidget({
    required this.meeting,
    this.onTap,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 4.0),
      tileColor: const Color.fromARGB(255, 249, 245, 255),
      // leading: const Icon(Icons.business_rounded, size: 40),
      leading: const CircleAvatar(child: Icon(Icons.business_rounded),),
      trailing: Icon(Icons.remove_circle_outlined, color: Colors.red.shade300),
      minLeadingWidth: 45,
      title: Text(
        meeting.descricao,
        style: const TextStyle(
          color: Colors.black87,
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),
      // titleTextStyle: const TextStyle(color: Colors.black87, fontSize: 18, fontWeight: FontWeight.w600),
      subtitle: Text('${meeting.diaSemana} - ${meeting.horarioInicio} as ${meeting.horarioTermino}'),
      onTap: onTap,
    );
  }
}