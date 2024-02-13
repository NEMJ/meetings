import 'package:flutter/material.dart';
import 'package:meetings/models/meeting_model.dart';
import 'package:meetings/services/firebase_service_meeting.dart';

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
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<MeetingModel>>(
              stream: FirebaseServiceMeeting.instance.listMeetings(),
              builder: (context, snapshot) {
                if(!snapshot.hasData) {
                  return const Center(child: Text('Não há reuniões cadastradas'));
                }
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: ListTile(
                          title: Text(snapshot.data![index].descricao),
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
    );
  }
}