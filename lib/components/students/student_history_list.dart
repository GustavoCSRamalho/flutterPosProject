import 'package:flutter/material.dart';
import 'package:gerenciador_de_massa/models/student_history.dart';
import 'package:gerenciador_de_massa/models/student_history_arguments.dart';
import 'package:gerenciador_de_massa/providers/student/students_history_provider.dart';
import 'package:provider/provider.dart';

class StudentHistoryList extends StatefulWidget {
  const StudentHistoryList(this.studentHistoryArguments, {super.key});

  final StudentHistoryArguments studentHistoryArguments;

  @override
  State<StudentHistoryList> createState() => _StudentHistoryListState();
}

class _StudentHistoryListState extends State<StudentHistoryList> {
  List<StudentHistory> _studentHistory = [];

  @override
  void initState() {
    super.initState();
  }

  void showSnackBar(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
      duration: const Duration(seconds: 2),
    ));
  }

  Widget centeredText(String text) => Center(
        child: Text('$text'),
      );

  @override
  Widget build(BuildContext context) {
    StudentsHistoryProvider _studentsHistoryProvider =
        Provider.of<StudentsHistoryProvider>(context);
    _studentHistory = _studentsHistoryProvider
        .getStudentHistory(widget.studentHistoryArguments.student.cpf);
    return Column(
      children: [
        const SizedBox(
          height: 12.0,
        ),
        const Text('Historico de ganho de massa do estudante:'),
        const SizedBox(
          height: 12.0,
        ),
        Expanded(
            child: _studentHistory.isNotEmpty
                ? ListView.builder(
                    itemBuilder: (context, index) {
                      StudentHistory studentH = _studentHistory[index];

                      return Dismissible(
                        key: Key(studentH.id.toString()),
                        onDismissed: (direction) {
                          setState(() {
                            _studentsHistoryProvider
                                .delete(studentH.id ?? '')
                                .then((isDeleted) => {
                                      if (isDeleted)
                                        {showSnackBar('Deletado com sucesso!')}
                                      else
                                        {showSnackBar('Erro ao deletar!')}
                                    });
                          });
                        },
                        child: ListTile(
                          title: const Text('Massa :'),
                          subtitle: Text('${studentH.mass} kg'),
                        ),
                      );
                    },
                    itemCount: _studentHistory.length,
                  )
                : centeredText('Nenhum historico cadastrado!'))
      ],
    );
  }
}
