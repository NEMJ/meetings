import 'package:cloud_firestore/cloud_firestore.dart';

class MeetingModel {
  final String id;
  final String descricao;
  final String entidade;
  final String diaSemana;
  final String horarioInicio;
  final String horarioTermino;
  
  const MeetingModel({
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