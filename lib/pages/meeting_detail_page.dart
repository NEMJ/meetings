import 'package:flutter/material.dart';
import '../models/meeting_model.dart';
import '../widgets/text_form_field_widget.dart';
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
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.meeting.descricao),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormFieldWidget(
                label: 'Descrição',
                initialValue: widget.meeting.descricao,
              ),
              TextFormFieldWidget(
                label: 'Entidade',
                initialValue: widget.meeting.entidade,
              ),
              TextFormFieldWidget(
                label: 'Dia da Semana',
                initialValue: widget.meeting.diaSemana,
              ),
              TextFormFieldWidget(
                label: 'Horário de Início',
                initialValue: widget.meeting.horarioInicio,
              ),
              TextFormFieldWidget(
                label: 'Horário de Término',
                initialValue: widget.meeting.horarioTermino,
              ),
            ],
          ),
        ),
      ),
    );
  }
}