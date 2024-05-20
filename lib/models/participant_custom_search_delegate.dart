import 'package:flutter/material.dart';
import 'package:meetings/models/participant_model.dart';

class ParticipantCustomSearchDelegate extends SearchDelegate {
  ParticipantCustomSearchDelegate({
    required this.context,
    required this.participants,
    super.searchFieldLabel = 'Pesquisar'
  });

  BuildContext context;
  List<ParticipantModel> participants;

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back_rounded),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];

    for (var participant in participants) {
      if (participant.nome.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(participant.nome);
      }
    }

    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];

    for (var participant in participants) {
      if (participant.nome.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(participant.nome);
      }
    }

    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
        );
      },
    );
  }
}