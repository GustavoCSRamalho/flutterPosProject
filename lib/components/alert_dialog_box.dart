import 'package:flutter/material.dart';

class AlertDialogBox extends StatelessWidget {
  const AlertDialogBox({required this.title, required this.message, super.key});

  final String title;
  final String message;

  void navigateBack(BuildContext context, bool result) {
    Navigator.of(context).pop(result);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: <Widget>[
        TextButton(
            onPressed: () => navigateBack(context, false),
            child: const Text('Cancelar')),
        TextButton(
            onPressed: () => navigateBack(context, true),
            child: const Text('Confirmar'))
      ],
    );
  }
}
