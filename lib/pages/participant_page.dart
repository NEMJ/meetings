import 'package:flutter/material.dart';
import '../services/firebase_participant_service.dart';
import '../models/participant_model.dart';
import '../widgets/participant_list_tile_widget.dart';
import '../pages/participant_detail_page.dart';

class ParticipantPage extends StatefulWidget {
  const ParticipantPage({super.key});

  @override
  State<ParticipantPage> createState() => _ParticipantPageState();
}

class _ParticipantPageState extends State<ParticipantPage> {

  late Stream<List<ParticipantModel>> participants;
  final firebaseParticipantService = FirebaseParticipantService.instance;

  Future<void> listParticipants() async {
    participants = firebaseParticipantService.listParticipants();
    setState(() => participants);
  }

  navigationToParticipantDetailPage(ParticipantModel? participant) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ParticipantDetailPage(participant: participant),
      ),
    );
  }

  @override
  void initState() {
    listParticipants();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Participantes'),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.person_add_alt_rounded,
              color: Color.fromARGB(255, 92, 78, 158),
            ),
            onPressed: () => navigationToParticipantDetailPage(null),
          ),
        ]
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder<List<ParticipantModel>>(
                stream: participants,
                builder: (context, snapshot) {
                  if(!snapshot.hasData) {
                    return const Center(child: Text('Não há participantes cadastrados'));
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return ParticipantListTileWidget(
                        participant: snapshot.data![index],
                        onTap: () => navigationToParticipantDetailPage(snapshot.data![index]),
                        onPressedIcon: () {},
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}