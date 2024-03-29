import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/meeting_model.dart';

class FirebaseMeetingService {
  // Criando um construtor privado para padrão singleton
  FirebaseMeetingService._();
  // Criando uma instância estática
  static final FirebaseMeetingService _instance = FirebaseMeetingService._();
  // Criando um método para acessar a instância
  static FirebaseMeetingService get instance => _instance;

  final _collection = FirebaseFirestore.instance.collection('reunioes');

  Future<void> saveMeeting(MeetingModel meeting) async {
    // Adiciona um novo documento na coleção com o mapa do objeto
    await _collection.doc(meeting.id).set(meeting.toMap());
  }

  Stream<List<MeetingModel>> listMeetings() async* {
    // Obtendo todos os documentos da coleção
    await for (QuerySnapshot query in _collection.snapshots()) {
      // Convertendo os documentos em uma lista de objetos
      List<MeetingModel> meetings = query.docs.map(
        (doc) => MeetingModel.fromDocument(doc)
      ).toList();

      List<MeetingModel> orderedMeetings =
        meetings..sort((a, b) => a.descricao.compareTo(b.descricao));

      yield orderedMeetings;
    }
  }

  Future<void> updateMeeting(MeetingModel meeting) async {
    // Atualizando o documento na coleção com o id e o mapa do objeto
    await _collection.doc(meeting.id).update(meeting.toMap());
  }

  Future<void> deleteMeeting(String meetingId) async {
    // Deletando o documento na coleção com o ID do objeto
    await _collection.doc(meetingId).delete();
  }
}