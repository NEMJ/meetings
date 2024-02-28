import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../services/firebase_meeting_service.dart';
import '../models/meeting_model.dart';
import '../widgets/text_form_field_widget.dart';
import '../widgets/dropdown_button_form_field_widget.dart';
import '../widgets/time_list_tile_widget.dart';

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

  MeetingModel getAtualMeeting() {
    final meetingID = (widget.meeting != null) ? widget.meeting!.id : const Uuid().v1();

    return MeetingModel(
      id: meetingID,
      descricao: _descricaoController.text,
      entidade: _entidadeController.text,
      diaSemana: _diaSemanaController.text,
      horarioInicio: _horarioInicioController.text,
      horarioTermino: _horarioTerminoController.text,
    );
  }

  // retorna false se qualquer controller estiver vazio
  validateFields() {
    return 
      _descricaoController.text.isEmpty ||
      _entidadeController.text.isEmpty ||
      _diaSemanaController.text.isEmpty ||
      _horarioInicioController.text.isEmpty ||
      _horarioTerminoController.text.isEmpty;
  }

  saveOrUpdateMeeting() {
    // verifica se existe algum campo vazio. Se for o caso aparece um aviso sobre.
    if (validateFields()) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Preencha todos os campos'),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ]
        ),
      );

      return;
    }

    // verifica se é uma atualização ou novo cadastro para invocar as funções corretas
    // e mostra um retorno visual ao usuário de que deu certo a operação feita
    if (widget.meeting != null) {
      firebaseServiceMeeting.updateMeeting(getAtualMeeting())
        .then((value) => ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Reunião "${_descricaoController.text}" atualizada com sucesso'),
          ),
        ));
      Navigator.of(context).pop();
      return;
    }

    firebaseServiceMeeting.saveMeeting(getAtualMeeting())
      .then((value) => ScaffoldMessenger.of(context).showSnackBar(
        SnackBar
          (content: Text('Reunião "${_descricaoController.text}" salva com sucesso'),
        ),
      ));

    Navigator.of(context).pop();
  }

  @override
  void initState() {
    if(widget.meeting != null) {
      _descricaoController.text = widget.meeting!.descricao;
      _entidadeController.text = widget.meeting!.entidade;
      _diaSemanaController.text = widget.meeting!.diaSemana;
      _horarioInicioController.text = widget.meeting!.horarioInicio;
      _horarioTerminoController.text = widget.meeting!.horarioTermino;
    }
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
            onPressed: saveOrUpdateMeeting,
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
              DropdownButtonFormFieldWidget(
                value: widget.meeting?.diaSemana, // Se o objeto for nulo ele envia null para esta propriedade
                label: 'Dia da Semana',
                listItems: const ['Segunda', 'Terça', 'Quarta', 'Quinta', 'Sexta', 'Sábado', 'Domingo'],
                onChanged: (option) => _diaSemanaController.text = option!,
              ),
              Row(
                children: [
                  TimeListTileWidget(label: 'Início: ', controller: _horarioInicioController),
                  const SizedBox(width: 16),
                  TimeListTileWidget(label: 'Final: ', controller: _horarioTerminoController),
                ]
              ),
            ],
          ),
        ),
      ),
    );
  }
}