import 'package:flutter/material.dart';
import 'package:gerenciador_de_massa/components/drawer_navigation.dart';
import 'package:gerenciador_de_massa/components/students/form_add_student%20history.dart';
import 'package:gerenciador_de_massa/models/student_history.dart';
import 'package:gerenciador_de_massa/models/student_history_arguments.dart';
import 'package:gerenciador_de_massa/providers/student/student_provider.dart';
import 'package:gerenciador_de_massa/providers/student/students_history_provider.dart';
import 'package:provider/provider.dart';

class StudentHistorytInsertScreen extends StatefulWidget {
  StudentHistorytInsertScreen({super.key});

  @override
  State<StudentHistorytInsertScreen> createState() =>
      _StudentHistorytInsertScreenState();
}

class _StudentHistorytInsertScreenState
    extends State<StudentHistorytInsertScreen> {
  @override
  Widget build(BuildContext context) {
    StudentHistoryArguments _studentHistoryArguments =
        ModalRoute.of(context)?.settings.arguments as StudentHistoryArguments;

    StudentsProvider studentsProvider = Provider.of<StudentsProvider>(context);
    StudentsHistoryProvider studentsHistoryP =
        Provider.of<StudentsHistoryProvider>(context);

    void onSubmit(StudentHistory studentHistory) {
      if (_studentHistoryArguments.studentHistoryId != null) {
        studentsHistoryP
            .update(_studentHistoryArguments.studentHistoryId!, studentHistory)
            .then((value) => Navigator.of(context).pop());
      } else {
        studentsHistoryP
            .create(studentHistory)
            .then((value) => Navigator.of(context).pop());
        _studentHistoryArguments.action!();
      }
    }

    Widget progressIndicator() => const Center(
          child: CircularProgressIndicator(),
        );

    Widget centeredText(String text) => Center(
          child: Text('Error: $text'),
        );

    Widget showStudentForm(
        void Function(StudentHistory) onSubmit, StudentHistory studentHistory) {
      return FormAddStudentHistory(
          onSubmit, _studentHistoryArguments.student.cpf,
          studentHistory: studentHistory);
    }

    return Scaffold(
      drawer: DrawerNavigation(),
      appBar: AppBar(
        title: Text(_studentHistoryArguments.studentHistoryId == null
            ? 'Novo Massa'
            : 'Edicao de Massa'),
      ),
      body: _studentHistoryArguments.studentHistoryId == null
          ? FormAddStudentHistory(
              onSubmit, _studentHistoryArguments.student.cpf)
          : FutureBuilder<StudentHistory>(
              future: studentsHistoryP
                  .read(_studentHistoryArguments.studentHistoryId!),
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
