import 'package:flutter/material.dart';
import 'package:gerenciador_de_massa/components/students/student_tile.dart';
import 'package:gerenciador_de_massa/models/student.dart';

class ListStudents extends StatelessWidget {
  const ListStudents(this.students, {super.key});

  final List<Student> students;

  Widget _generateStudentTile(context, index) {
    Student student = students[index];
    return StudentTile(student: student);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: _generateStudentTile,
      itemCount: students.length,
    );
  }
}
