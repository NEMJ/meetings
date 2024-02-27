import 'package:flutter/material.dart';

class ConfirmDeletionDialogWidget extends StatelessWidget {
  const ConfirmDeletionDialogWidget({
    required this.title,
    required this.onDelete,
    super.key,
  });

  final String title;
  final Function() onDelete;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      actionsAlignment: MainAxisAlignment.spaceEvenly,
      actionsPadding: const EdgeInsets.fromLTRB(8, 14, 8, 16),
      actions: [
        SizedBox(
          width: 100,
          height: 40,
          child: TextButton(
            onPressed: () => Navigator.of(context).pop(),
            style: TextButton.styleFrom(
              backgroundColor: Colors.red.shade100,
              foregroundColor: Colors.red.shade700,
            ),
            child: const Text('Cancelar'),
          ),
        ),
        SizedBox(
          width: 100,
          height: 40,
          child: FilledButton(
            onPressed: () {
              onDelete();
              Navigator.of(context).pop();
            },
            child: const Text('Excluir'),
          ),
        )
      ]
    );
  }
}