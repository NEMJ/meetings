import 'dart:io';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:image_picker/image_picker.dart';
import '../services/firebase_participant_service.dart';
import '../services/firebase_meeting_service.dart';
import '../models/participant_model.dart';
import '../models/checkbox_model.dart';
import '../widgets/dropdown_button_form_field_widget.dart';
import '../widgets/text_form_field_widget.dart';
import '../widgets/checkbox_widget.dart';
import '../widgets/user_image_widget.dart';

class ParticipantDetailPage extends StatefulWidget {
  final ParticipantModel? participant;

  const ParticipantDetailPage({
    this.participant,
    super.key,
  });

  @override
  State<ParticipantDetailPage> createState() => _ParticipantDetailPageState();
}

class _ParticipantDetailPageState extends State<ParticipantDetailPage> {

  String refImage = '';
  List<dynamic> reunioes = [];
  List<CheckboxModel> checkboxMeetingsList = [];
  String? uf;
  List<String> ufsList = const [
    '', 'AC', 'AL', 'AM', 'AP', 'BA', 'CE', 'DF', 'ES', 'GO', 'MA', 'MG', 'MS',
    'MT', 'PA','PB', 'PE', 'PI',  'PR', 'RJ', 'RN', 'RO', 'RR', 'RS', 'SC',
    'SE', 'SP', 'TO',
  ];

  final firebaseParticipantService = FirebaseParticipantService.instance;
  final firebaseMeetingService = FirebaseMeetingService.instance;

  final _formKey = GlobalKey<FormState>();

  final _tipoParticipanteController = TextEditingController();
  final _nomeController = TextEditingController();
  final _apelidoController = TextEditingController();
  final _dataNascimentoController = TextEditingController();
  final _ruaController = TextEditingController();
  final _bairroController = TextEditingController();
  final _cidadeController = TextEditingController();
  final _contatoController = TextEditingController();
  final _telFixoController = TextEditingController();
  final _profissaoController = TextEditingController();
  final _formProfController = TextEditingController();
  final _localTrabalhoController = TextEditingController();

  XFile? userPhoto;
  ImageProvider accountPhoto = Image.asset(
    "images/user_account.png",
    fit: BoxFit.cover,
  ).image;

  ParticipantModel buildParticipant() {
    final participantID = (widget.participant != null)
      ? widget.participant!.id : const Uuid().v1();

    final participantType = _tipoParticipanteController.text.isNotEmpty
      ? _tipoParticipanteController.text
      : 'Participante';

    return ParticipantModel(
      id: participantID,
      refImage: refImage,
      tipoParticipante: participantType,
      reunioes: getMeetingsChecked(),
      nome: _nomeController.text,
      apelido: _apelidoController.text,
      rua: _ruaController.text,
      bairro: _bairroController.text,
      cidade: _cidadeController.text,
      uf: uf ?? '',
      contato: _contatoController.text,
      telFixo: _telFixoController.text,
      profissao: _profissaoController.text,
      formProf: _formProfController.text,
      localTrabalho: _localTrabalhoController.text,
      dataNascimento: _dataNascimentoController.text,
    );
  }

  validadeRequiredFields() {
    bool validated = _formKey.currentState!.validate();

    if (!validated) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Preencha os campos obrigatórios'),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } else {
      done();
    }
  }

  done() {
    ParticipantModel participantModel = buildParticipant();

    if (widget.participant == null) {
      saveParticipant(participantModel);
    } else {
      updateParticipant(participantModel);
    }
  }

  saveParticipant(ParticipantModel participant) async {
    if (userPhoto != null) {
      await uploadUserPhoto(userPhoto!.path, participant.id);
    }

    firebaseParticipantService.saveParticipant(participant)
      .then((value) => ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Participante ${_nomeController.text} salvo com sucesso'),
        ),
      ));
    
    Navigator.of(context).pop();
  }

  updateParticipant(ParticipantModel participant) async {
    if (userPhoto != null) {
      await uploadUserPhoto(userPhoto!.path, participant.id);
    }

    firebaseParticipantService.updateParticipant(participant)
      .then((value) => ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Participante ${_nomeController.text} atualizado com sucesso'),
        ),
      ));
    
    Navigator.of(context).pop();
  }

  getCheckboxModelListMeetings() async {
    // Pega todas as reuniões cadastradas até o momento de entrar na página de detalhes do participante
    reunioes = await firebaseMeetingService.listMeetings().first;
    // Lista auxiliar para manipulação das reuniões marcadas
    List<String> aux = [];

    // A lista aux é povoada se for um participante já cadastrado.
    if(widget.participant != null) {
      widget.participant!.reunioes.forEach((reuniao) => aux.add(reuniao['id']));
    }
    
    // Percorre a lista de todas as reuniões
    reunioes.forEach((reuniao) {
      // variável para controlar a marcação das reuniões que já vem do participante
      bool value = false;

      // se o id da reunião da vez estiver na lista que veio do particiapnte,
      // esta reunião é marcada na listagem final de apresentação visual ao usuário.
      if(aux.contains(reuniao.id)) {
        value = true;
      }

      // a lista de objetos CheckBox é marcada com as informações processadas para cada elemento
      checkboxMeetingsList.add(
        CheckboxModel(id: reuniao.id, title: reuniao.descricao, value: value),
      );
    });
  }

  List<Map<String, dynamic>> getMeetingsChecked() {
    List<Map<String, dynamic>> reunioesMarcadas = [];

    checkboxMeetingsList.forEach((reuniao) {
      if (reuniao.value == true) {
        reunioesMarcadas.add(reuniao.toMap());
      }
    });

    return reunioesMarcadas;
  }

  showListMeetings() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        scrollable: true,
        title: const Text('Lista de Reuniões'),
        content: Column(
          children: [
            for(CheckboxModel reuniao in checkboxMeetingsList)
              CheckboxWidget(
                meetingCheckbox: reuniao,
              ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ]
        ),
      ),
    );
  }

  editPhoto() async {
    final ImagePicker picker = ImagePicker();

    try {
      userPhoto = await picker.pickImage(source: ImageSource.gallery);
      if(userPhoto != null) setState(() => accountPhoto = FileImage(File(userPhoto!.path)));
    } catch(e) {
      print(e);
    }
  }

  uploadUserPhoto(String photoPath, String photoName) async {
    await firebaseParticipantService.uploadUserPhoto(photoPath, photoName);
  }

  @override
  void initState() {
    if(widget.participant != null) {
      _tipoParticipanteController.text = widget.participant!.tipoParticipante;
      _nomeController.text = widget.participant!.nome;
      _apelidoController.text = widget.participant!.apelido;
      _dataNascimentoController.text = widget.participant!.dataNascimento;
      _ruaController.text = widget.participant!.rua;
      _bairroController.text = widget.participant!.bairro;
      _cidadeController.text = widget.participant!.cidade;
      _contatoController.text = widget.participant!.contato;
      _telFixoController.text = widget.participant!.telFixo;
      _profissaoController.text = widget.participant!.profissao;
      _formProfController.text = widget.participant!.formProf;
      _localTrabalhoController.text = widget.participant!.localTrabalho;

      refImage = widget.participant!.refImage;
      uf = widget.participant!.uf;
    }

    getCheckboxModelListMeetings();
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: (widget.participant != null)
          ? Text(widget.participant!.nome)
          : const Text('Novo Participante'),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                onTap: validadeRequiredFields,
                child: const ListTile(
                  title: Text('Salvar Alterações'),
                  leading: Icon(
                    Icons.save_rounded,
                    color: Color.fromARGB(255, 92, 78, 158)
                  ),
                ),
              ),
              PopupMenuItem(
                onTap: showListMeetings,
                child: const ListTile(
                  title: Text('Selecionar Reuniões'),
                  leading: Icon(
                    Icons.business_rounded,
                    color: Color.fromARGB(255, 92, 78, 158),
                  ),
                ),
              ),
            ]
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 16, 12, 0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                UserImageWidget(
                  image: accountPhoto,
                  editPhoto: editPhoto,
                ),
                const SizedBox(height: 18),
                TextFormFieldWidget(
                  label: 'Nome', controller: _nomeController, validator: true,
                ),
                TextFormFieldWidget(
                  label: 'Apelido', controller: _apelidoController,
                ),
                Row(
                  children: [
                    Flexible(
                      child: TextFormFieldWidget(
                        label: 'Contato',
                        controller: _contatoController,
                        validator: true,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Flexible(
                      child: TextFormFieldWidget(
                        label: 'Telefone',
                        controller: _telFixoController,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Flexible(
                      child: TextFormFieldWidget(
                        label: 'Data Nascimento',
                        controller: _dataNascimentoController,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Flexible(
                      child: DropdownButtonFormFieldWidget(
                        value: widget.participant?.tipoParticipante ?? 'Participante',
                        label: 'Tipo Participante',
                        listItems: const ['Dirigente', 'Entidade', 'Participante'],
                        onChanged: (option) => _tipoParticipanteController.text = option!,
                      )
                    ),
                  ]
                ),
                Row(
                  children: [
                    Flexible(
                      child: DropdownButtonFormFieldWidget(
                        value: widget.participant?.uf,
                        label: 'UF',
                        listItems: ufsList,
                        onChanged: (option) => setState(() => uf = option),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Flexible(
                      flex: 3,
                      child: TextFormFieldWidget(
                        label: 'Cidade',
                        controller: _cidadeController,
                      ),
                    ),
                  ],
                ),
                TextFormFieldWidget(
                  label: 'Rua', controller: _ruaController,
                ),
                TextFormFieldWidget(
                  label: 'Bairro', controller: _bairroController,
                ),
                TextFormFieldWidget(
                  label: 'Profissão', controller: _profissaoController,
                ),
                TextFormFieldWidget(
                  label: 'Formação Profissional', controller: _formProfController,
                ),
                TextFormFieldWidget(
                  label: 'Local de Trabalho', controller: _localTrabalhoController,
                ),
              ]
            ),
          ),
        ),
      ),
    );
  }
}