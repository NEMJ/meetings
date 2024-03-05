import 'package:flutter/material.dart';
import '../widgets/text_form_field_widget.dart';

class ParticipantDetailPage extends StatefulWidget {
  const ParticipantDetailPage({super.key});

  @override
  State<ParticipantDetailPage> createState() => _ParticipantDetailPageState();
}

class _ParticipantDetailPageState extends State<ParticipantDetailPage> {
  
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _dataNascimentoController = TextEditingController();

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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormFieldWidget(label: 'Nome', controller: _nomeController),
              TextFormFieldWidget(label: 'Data Nascimento', controller: _dataNascimentoController)
            ]
          ),
        ),
      ),
    );
  }
}