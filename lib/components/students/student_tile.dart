import 'package:flutter/material.dart';
import 'package:gerenciador_de_massa/models/student.dart';
import 'package:gerenciador_de_massa/routes/route_paths.dart';

class StudentTile extends StatelessWidget {
  const StudentTile({required this.student, super.key});

  final Student student;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.shopping_bag),
      title: Text(
        student.name,
        style: const TextStyle(fontSize: 20.0),
      ),
      subtitle: Text(student.description),
      trailing: Text('CPF: ${student.cpf}'),
      onTap: () => {
        Navigator.of(context)
            .pushNamed(RoutePaths.StudentScreen, arguments: student)
      },
    );
  }
}
