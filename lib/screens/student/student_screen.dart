import 'package:flutter/material.dart';
import 'package:gerenciador_de_massa/components/alert_dialog_box.dart';
import 'package:gerenciador_de_massa/components/drawer_navigation.dart';
import 'package:gerenciador_de_massa/components/students/student_history_list.dart';
import 'package:gerenciador_de_massa/models/student.dart';
import 'package:gerenciador_de_massa/models/student_history_arguments.dart';
import 'package:gerenciador_de_massa/providers/student/student_provider.dart';
import 'package:gerenciador_de_massa/providers/student/students_history_provider.dart';
import 'package:gerenciador_de_massa/routes/route_paths.dart';
import 'package:gerenciador_de_massa/screens/student/student_details.dart';
import 'package:provider/provider.dart';

class StudentScreen extends StatefulWidget {
  const StudentScreen({super.key});

  @override
  State<StudentScreen> createState() => _StudentScreenState();
}

class _StudentScreenState extends State<StudentScreen> {
  @override
  Widget build(BuildContext context) {
    Student _student = ModalRoute.of(context)!.settings.arguments as Student;

    final _studentHistoryArguments = StudentHistoryArguments(_student, () {
      setState(() {
        return;
      });
    });

    StudentsProvider studentsProvider = Provider.of<StudentsProvider>(context);

    void showSnackBar(String msg) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(msg),
        duration: const Duration(seconds: 2),
      ));
    }

    Future<bool?> showConfirmationDialog(BuildContext context) {
      return showDialog<bool>(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return const AlertDialogBox(
              title: 'Excluir', message: 'Deseja realmente excluir?');
        },
      );
    }

    Future<void> deleteItem(String id) async {
      bool confirmed = (await showConfirmationDialog(context)) ?? false;
      if (confirmed) {
        studentsProvider.delete(id).then((isDeleted) {
          showSnackBar('Item excluido da lista.');
          Navigator.of(context).pop();
        });
      }
    }

    void _updateScreen() {
      setState(() {
        return;
      });
    }

    Widget progressIndicator() => const Center(
          child: CircularProgressIndicator(),
        );

    Widget centeredText(String text) => Center(
          child: Text('Error: $text'),
        );

    Widget showStudent(Student student) {
      // studentId = student.cpf;
      return TabBarView(children: [
        StudentDetails(student),
        ChangeNotifierProvider(
          create: (context) => StudentsHistoryProvider(),
          child: StudentHistoryList(_studentHistoryArguments),
        )
      ]);
    }

    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
              actions: [
                IconButton(
                    onPressed: () {
                      deleteItem(_student.id ?? '0');
                    },
                    icon: const Icon(Icons.delete)),
                IconButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(
                          RoutePaths.StudentInsertScreen,
                          arguments: _student.id);
                    },
                    icon: const Icon(Icons.edit))
              ],
              title: const Text('Estudante'),
              bottom: const TabBar(
                tabs: [
                  Tab(
                    text: 'Detalhes',
                  ),
                  Tab(
                    text: 'Historico',
                  )
                ],
              )),
          body: FutureBuilder<Student>(
            future: studentsProvider.read(_student.id ?? '0'),
            builder: (context, snapshot) {
              final connState = snapshot.connectionState;
              const connWaiting = ConnectionState.waiting;
              if (connState == connWaiting) {
                return progressIndicator();
              } else if (snapshot.hasError) {
                return centeredText('${snapshot.error}');
              } else if (snapshot.hasData) {
                return showStudent(snapshot.data!);
              } else {
                return centeredText('No data available!');
              }
            },
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => Navigator.of(context).pushNamed(
                RoutePaths.StudentHistoryInsertScreen,
                arguments: _studentHistoryArguments),
            child: const Icon(Icons.add),
          ),
          drawer: DrawerNavigation(),
        ));
  }
}
