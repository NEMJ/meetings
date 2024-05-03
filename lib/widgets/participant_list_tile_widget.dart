import 'package:flutter/material.dart';
import '../models/participant_model.dart';

class ParticipantListTileWidget extends StatelessWidget {
  const ParticipantListTileWidget({
    required this.participant,
    required this.onTap,
    required this.onPressedIcon,
    this.userPhoto,
    super.key
  });

  final ParticipantModel participant;
  final Function()? onTap;
  final Function() onPressedIcon;
  final ImageProvider? userPhoto;

  @override
  Widget build(BuildContext context) {
    
    Widget leading = const CircleAvatar(radius: 26, child: Icon(Icons.person_rounded));

    if(userPhoto != null) {
      leading = CircleAvatar(backgroundImage: userPhoto, radius: 26);
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 4.0),
        tileColor: const Color.fromARGB(255, 249, 245, 255),
        leading: leading,
        trailing: IconButton(
          icon: const Icon(Icons.remove_circle_outlined),
          color: Colors.red.shade300,
          onPressed: onPressedIcon,
        ),
        title: Text(
          participant.nome,
          style: const TextStyle(
            color: Colors.black87,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: Text(participant.tipoParticipante),
        onTap: onTap,
      ),
    );
  }
}