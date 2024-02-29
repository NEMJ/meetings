import 'package:cloud_firestore/cloud_firestore.dart';

class ParticipantModel {
  final String id;
  final String refImage;
  final String tipoParticipante;
  final List<dynamic> reunioes;
  final String nome;
  final String apelido;
  final String rua;
  final String bairro;
  final String cidade;
  final String uf;
  final String contato;
  final String telFixo;
  final String profissao;
  final String formProf;
  final String localTrabalho;
  final String dataNascimento;

  const ParticipantModel({
    required this.id,
    required this.refImage,
    required this.tipoParticipante,
    required this.reunioes,
    required this.nome,
    required this.apelido,
    required this.rua,
    required this.bairro,
    required this.cidade,
    required this.uf,
    required this.contato,
    required this.telFixo,
    required this.profissao,
    required this.formProf,
    required this.localTrabalho,
    required this.dataNascimento,
  });

  ParticipantModel.fromDocument(DocumentSnapshot doc) :
   id = doc.id,
   refImage = doc['refImage'],
   tipoParticipante = doc['tipoParticipante'],
   reunioes = doc['reunioes'],
   nome = doc['nome'],
   apelido = doc['apelido'],
   rua = doc['rua'],
   bairro = doc['bairro'],
   cidade = doc['cidade'],
   uf = doc['uf'],
   contato = doc['contato'],
   telFixo = doc['telFixo'],
   profissao = doc['profissao'],
   formProf = doc['formProf'],
   localTrabalho = doc['localTrabalho'],
   dataNascimento = doc['dataNascimento'];

  Map<String, dynamic> toMap() {
    return {
      'id' : id,
      'refImage' : refImage,
      'tipoParticipante' : tipoParticipante,
      'reunioes' : reunioes,
      'nome' : nome,
      'apelido' : apelido,
      'rua' : rua,
      'bairro' : bairro,
      'cidade' : cidade,
      'uf' : uf,
      'contato' : contato,
      'telFixo' : telFixo,
      'profissao' : profissao,
      'formProf' : formProf,
      'localTrabalho' : localTrabalho,
      'dataNascimento' : dataNascimento,
    };
  }
}