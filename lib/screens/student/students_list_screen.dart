import 'package:flutter/material.dart';
import 'package:gerenciador_de_massa/components/drawer_navigation.dart';
import 'package:gerenciador_de_massa/components/students/list_students.dart';
import 'package:gerenciador_de_massa/models/student.dart';
import 'package:gerenciador_de_massa/providers/student/student_provider.dart';
import 'package:gerenciador_de_massa/routes/route_paths.dart';
import 'package:provider/provider.dart';

class StudentsListScreen extends StatefulWidget {
  const StudentsListScreen({super.key, required this.students});

  final List<Student> students;

  @override
  State<StudentsListScreen> createState() => _StudentsListScreenState();
}

class _StudentsListScreenState extends State<StudentsListScreen> {
  _addStudent(String name, String cpf, String description) {
    String lastId = widget.students.last.id!;
    String nextId = (int.parse(lastId) + 1).toString();

    Student student = Student.withId(nextId, name, cpf, description);

    setState(() {
      widget.students.add(student);
    });
    Navigator.of(context).pop();
  }

  Widget progressIndicator() =>
      const Center(child: CircularProgressIndicator());

  Widget centeredText(String text) => Center(
        child: Text('$text'),
      );

  Widget listOfMessage(List<Student> list) => list.isNotEmpty
      ? ListStudents(list)
      : centeredText('Nenhum estudante cadastrado!');

  @override
  Widget build(BuildContext context) {
    StudentsProvider products = Provider.of<StudentsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Controle de massa'),
      ),
      body: FutureBuilder<List<Student>>(
        future: products.list(),
        builder: (context, snapshot) {
          final connState = snapshot.connectionState;
          const connWaiting = ConnectionState.waiting;
          if (connState == connWaiting) {
            return progressIndicator();
          } else if (snapshot.hasError) {
            return centeredText('${snapshot.error}');
          } else if (snapshot.hasData) {
            return listOfMessage(snapshot.data!);
          } else {
            return centeredText('No data available!');
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            Navigator.of(context).pushNamed(RoutePaths.StudentInsertScreen),
        child: const Icon(Icons.add),
      ),
      drawer: DrawerNavigation(),
    );
  }
}
