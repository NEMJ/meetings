import 'package:flutter/material.dart';
import '../services/firebase_meeting_service.dart';
import '../models/meeting_model.dart';
import '../widgets/text_form_field_widget.dart';
// import '../services/firebase_meeting_service.dart';

class MeetingDetailPage extends StatefulWidget {
  final MeetingModel? meeting;

  const MeetingDetailPage({
    this.meeting,
    super.key
  });

  @override
  State<MeetingDetailPage> createState() => _MeetingDetailPageState();
}

class _MeetingDetailPageState extends State<MeetingDetailPage> {
  final _formKey = GlobalKey<FormState>();

  final firebaseServiceMeeting = FirebaseServiceMeeting.instance;

  final _descricaoController = TextEditingController();
  final _entidadeController = TextEditingController();
  final _diaSemanaController = TextEditingController();
  final _horarioInicioController = TextEditingController();
  final _horarioTerminoController = TextEditingController();

  initControllers() {
    if(widget.meeting != null) {
      _descricaoController.text = widget.meeting!.descricao;
      _entidadeController.text = widget.meeting!.entidade;
      _diaSemanaController.text = widget.meeting!.diaSemana;
      _horarioInicioController.text = widget.meeting!.horarioInicio;
      _horarioTerminoController.text = widget.meeting!.horarioTermino;
    }
  }

  @override
  void initState() {
    initControllers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: (widget.meeting != null)
          ? Text(widget.meeting!.descricao)
          : const Text('Nova Reunião'),
        actions: [
          IconButton(
            icon: Icon(
              Icons.save_rounded,
              color: Colors.deepPurple.shade900
            ),
            onPressed: () => firebaseServiceMeeting.updateMeeting(
              MeetingModel(
                id: widget.meeting!.id,
                descricao: widget.meeting!.descricao,
                entidade: widget.meeting!.entidade,
                diaSemana: widget.meeting!.diaSemana,
                horarioInicio: widget.meeting!.horarioInicio,
                horarioTermino: widget.meeting!.horarioTermino,
              ),
            ),
          ),
        ],
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
                controller: _descricaoController,
              ),
              TextFormFieldWidget(
                label: 'Entidade',
                controller: _entidadeController,
              ),
              TextFormFieldWidget(
                label: 'Dia da Semana',
                controller: _diaSemanaController,
              ),
              TextFormFieldWidget(
                label: 'Horário de Início',
                controller: _horarioInicioController,
              ),
              TextFormFieldWidget(
                label: 'Horário de Término',
                controller: _horarioTerminoController,
              ),
            ],
          ),
        ),
      ),
    );
  }
}