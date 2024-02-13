import 'package:flutter/material.dart';
import '../models/meeting_model.dart';
// import '../services/firebase_meeting_service.dart';

class MeetingDetailPage extends StatefulWidget {
  final MeetingModel meeting;

  const MeetingDetailPage({
    required this.meeting,
    super.key
  });

  @override
  State<MeetingDetailPage> createState() => _MeetingDetailPageState();
}

class _MeetingDetailPageState extends State<MeetingDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meeting Detail Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Descrição: ${widget.meeting.descricao}"),
            Text("Entidade: ${widget.meeting.entidade}"),
            Text("Dia da Semana: ${widget.meeting.diaSemana}"),
            Text("Início: ${widget.meeting.horarioInicio}"),
            Text("Término: ${widget.meeting.horarioTermino}"),
          ],
        ),
      ),
    );
  }
}