import 'package:gerenciador_de_massa/models/student.dart';
import 'package:flutter/material.dart';

class StudentDetails extends StatelessWidget {
  final Student student;
  const StudentDetails(this.student, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Text(
              'Descricao do estudante ${student.name}',
              style:
                  const TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
            ),
          ),
        ),
        SizedBox(
          width: double.maxFinite,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              student.description,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20.0),
            ),
          ),
        )
      ],
    );
  }
}
