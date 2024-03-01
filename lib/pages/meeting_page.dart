import 'package:flutter/material.dart';
import '../widgets/confirm_deletion_dialog_widget.dart';
import './meeting_detail_page.dart';
import '../models/meeting_model.dart';
import '../services/firebase_meeting_service.dart';
import '../widgets/meeting_list_tile_widget.dart';

class MeetingPage extends StatefulWidget {
  const MeetingPage({super.key});

  @override
  State<MeetingPage> createState() => _MeetingPageState();
}

class _MeetingPageState extends State<MeetingPage> {

  late Stream<List<MeetingModel>> meetings;
  final firebaseMeetingService = FirebaseMeetingService.instance;

  Future<void> listMeetings() async {
    meetings = firebaseMeetingService.listMeetings();
    setState(() => meetings);
  }

  navigationToMeetingPage(MeetingModel? meeting) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MeetingDetailPage(meeting: meeting)
      ),
    );
  }

  @override
  void initState() {
    listMeetings();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Reuniões'),
        actions: [
          IconButton(
            icon: Icon(
              Icons.domain_add_rounded,
              color: Colors.deepPurple.shade900,
            ),
            onPressed: () => navigationToMeetingPage(null),
          ),
        ]
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder<List<MeetingModel>>(
                stream: meetings,
                builder: (context, snapshot) {
                  if(!snapshot.hasData) {
                    return const Center(child: Text('Não há reuniões cadastradas'));
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: MeetingListTileWidget(
                          meeting: snapshot.data![index],
                          onTap: () => navigationToMeetingPage(snapshot.data![index]),
                          onPressedIcon: () => showDialog(
                            context: context,
                            builder: (_) => ConfirmDeletionDialogWidget(
                              title: 'Deseja realmente excluir a reunião ${snapshot.data![index].descricao}?',
                              onDelete: () => firebaseMeetingService.deleteMeeting(snapshot.data![index].id),
                            ),
                          ),
                        ),
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