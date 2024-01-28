import 'package:gerenciador_de_massa/components/drawer_navigation.dart';
import 'package:gerenciador_de_massa/components/students/form_add_student.dart';
import 'package:gerenciador_de_massa/models/student.dart';
import 'package:gerenciador_de_massa/providers/student/student_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StudentInsertScreen extends StatelessWidget {
  const StudentInsertScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String? studentId = ModalRoute.of(context)?.settings.arguments as String?;
    StudentsProvider students = Provider.of<StudentsProvider>(context);

    void onSubmit(Student student) {
      if (studentId != null) {
        students
            .update(studentId, student)
            .then((value) => Navigator.of(context).pop());
      } else {
        students.create(student).then((value) => Navigator.of(context).pop());
      }
    }

    Widget progressIndicator() => const Center(
          child: CircularProgressIndicator(),
        );

    Widget centeredText(String text) => Center(
          child: Text('Error: $text'),
        );

    Widget showStudentForm(void Function(Student) onSubmit, Student student) {
      return FormAddStudent(onSubmit, student: student);
    }

    return Scaffold(
      drawer: DrawerNavigation(),
      appBar: AppBar(
        title: Text(studentId == null ? 'Novo Aluno' : 'Edicao de Aluno'),
      ),
      body: studentId == null
          ? FormAddStudent(onSubmit)
          : FutureBuilder<Student>(
              future: students.read(studentId),
              builder: (context, snapshot) {
                final connState = snapshot.connectionState;
                const connWaiting = ConnectionState.waiting;
                if (connState == connWaiting) {
                  return progressIndicator();
                } else if (snapshot.hasError) {
                  return centeredText('${snapshot.error}');
                } else if (snapshot.hasData) {
                  return showStudentForm(onSubmit, snapshot.data!);
                } else {
                  return centeredText('No data available');
                }
              },
            ),
    );
  }
}
