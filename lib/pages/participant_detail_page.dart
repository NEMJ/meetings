import 'package:flutter/material.dart';
import '../widgets/dropdown_button_form_field_widget.dart';
import '../widgets/text_form_field_widget.dart';

class ParticipantDetailPage extends StatefulWidget {
  const ParticipantDetailPage({super.key});

  @override
  State<ParticipantDetailPage> createState() => _ParticipantDetailPageState();
}

class _ParticipantDetailPageState extends State<ParticipantDetailPage> {

  String refImage = '';
  List<Object> reunioes = [];
  String? uf;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Novo Participante'),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.save_rounded,
              color: Colors.deepPurple
            ),
            onPressed: () {},
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 16, 12, 0),
          child: Column(
            children: [
              TextFormFieldWidget(label: 'Nome', controller: _nomeController),
              TextFormFieldWidget(label: 'Apelido', controller: _apelidoController),
              Row(
                children: [
                  Flexible(
                    child: TextFormFieldWidget(
                      label: 'Contato',
                      controller: _contatoController,
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
                      label: 'UF',
                      listItems: const [
                        'AC', 'AL', 'AM', 'AP', 'BA', 'CE', 'DF', 'ES', 'GO',
                        'MA', 'MG', 'MS', 'MT', 'PA','PB', 'PE', 'PI',  'PR',
                        'RJ', 'RN', 'RO', 'RR', 'RS', 'SC', 'SE', 'SP', 'TO'
                      ],
                      onChanged: (option) {},
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
              TextFormFieldWidget(label: 'Rua', controller: _ruaController),
              TextFormFieldWidget(label: 'Bairro', controller: _bairroController),
              TextFormFieldWidget(label: 'Profissão', controller: _profissaoController),
              TextFormFieldWidget(label: 'Formação Profissional', controller: _formProfController),
              TextFormFieldWidget(label: 'Local de Trabalho', controller: _localTrabalhoController),
            ]
          ),
        ),
      ),
    );
  }
}