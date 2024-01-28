import 'package:flutter/material.dart';
import 'package:gerenciador_de_massa/models/student_history.dart';

class FormAddStudentHistory extends StatefulWidget {
  const FormAddStudentHistory(this.onSubmit, this.studentId,
      {this.studentHistory, super.key});

  final void Function(StudentHistory studentHistory) onSubmit;
  final StudentHistory? studentHistory;
  final String? studentId;

  @override
  State<FormAddStudentHistory> createState() => _FormAddStudenHistoryState();
}

class _FormAddStudenHistoryState extends State<FormAddStudentHistory> {
  @override
  void initState() {
    super.initState();

    if (widget.studentHistory != null) {
      _massController.text = widget.studentHistory!.mass;
    }
  }

  final _massController = TextEditingController();

  Widget createInput(String label, TextEditingController tController,
      [TextInputType type = TextInputType.text]) {
    return TextField(
      controller: tController,
      decoration: InputDecoration(labelText: label),
      keyboardType: type,
    );
  }

  void submitForm() {
    String mass = _massController.text;

    StudentHistory student = StudentHistory(widget.studentId!, mass);
    widget.onSubmit(student);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: SizedBox(
        width: double.infinity,
        height: 300,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const Text('Adicionar'),
              createInput('Massa', _massController),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: submitForm, child: const Text('Salvar')),
              )
            ],
          ),
        ),
      ),
    );
  }
}
