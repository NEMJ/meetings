import 'package:flutter/material.dart';
import './meeting_detail_page.dart';
import '../models/meeting_model.dart';
import '../services/firebase_meeting_service.dart';
import '../widgets/meeting_listTile_widget.dart';

class MeetingPage extends StatefulWidget {
  const MeetingPage({super.key});

  @override
  State<MeetingPage> createState() => _MeetingPageState();
}

class _MeetingPageState extends State<MeetingPage> {

  late Stream<List<MeetingModel>> meetings;

  Future<void> listMeetings() async {
    meetings = FirebaseServiceMeeting.instance.listMeetings();
    setState(() => meetings);
  }

  navigationToMeetingPage(MeetingModel meeting) {
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