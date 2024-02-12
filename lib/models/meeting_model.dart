import 'package:cloud_firestore/cloud_firestore.dart';

class MeetingModel {
  String id;
  String descricao;
  String entidade;
  String diaSemana;
  String horarioInicio;
  String horarioTermino;
  
  MeetingModel({
    required this.id,
    required this.descricao,
    required this.entidade,
    required this.diaSemana,
    required this.horarioInicio,
    required this.horarioTermino,
  });

  MeetingModel.fromDocument(DocumentSnapshot doc) : 
    id = doc.id,
    descricao = doc['descricao'],
    entidade = doc['entidade'],
    diaSemana = doc['diaSemana'],
    horarioInicio = doc['horarioInicio'],
    horarioTermino = doc['horarioTermino'];
  
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'descricao': descricao,
      'entidade': entidade,
      'diaSemana': diaSemana,
      'horarioInicio': horarioInicio,
      'horarioTermino': horarioTermino
    };
  }
}