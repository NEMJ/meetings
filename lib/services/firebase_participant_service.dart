import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/participant_model.dart';

class FirebaseParticipantService {
  FirebaseParticipantService._();
  static final FirebaseParticipantService _instance = FirebaseParticipantService._();
  static FirebaseParticipantService get instance => _instance;
  final _collection = FirebaseFirestore.instance.collection('participantes');

  Future<void> saveParticipant(ParticipantModel participant) async {
    await _collection.doc(participant.id).set(participant.toMap());
  }

  Stream<List<ParticipantModel>> listParticipants() async* {
    await for (QuerySnapshot query in _collection.snapshots()) {
      List<ParticipantModel> participants = query.docs.map(
        (doc) => ParticipantModel.fromDocument(doc)
      ).toList();

      List<ParticipantModel> orderedParticipants =
        participants..sort((a, b) => a.nome.compareTo(b.nome));
      
      yield orderedParticipants;
    }
  }

  Future<void> updateParticipant(ParticipantModel participant) async {
    await _collection.doc(participant.id).update(participant.toMap());
  }

  Future<void> deleteParticipant(String participantId) async {
    await _collection.doc(participantId).delete();
  }
}