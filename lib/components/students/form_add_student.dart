import 'package:flutter/material.dart';
import 'package:gerenciador_de_massa/models/student.dart';

class FormAddStudent extends StatefulWidget {
  FormAddStudent(this.onSubmit, {this.student, super.key});

  final void Function(Student student) onSubmit;
  final Student? student;

  @override
  State<FormAddStudent> createState() => _FormAddStudentState();
}

class _FormAddStudentState extends State<FormAddStudent> {
  @override
  void initState() {
    super.initState();

    if (widget.student != null) {
      _nameController.text = widget.student!.name;
      _cpfController.text = widget.student!.cpf;
      _descriptionController.text = widget.student!.description;
    }
  }

  final _nameController = TextEditingController();

  final _cpfController = TextEditingController();

  final _descriptionController = TextEditingController();

  Widget createInput(String label, TextEditingController tController,
      [TextInputType type = TextInputType.text]) {
    return TextField(
      controller: tController,
      decoration: InputDecoration(labelText: label),
      keyboardType: type,
    );
  }

  void submitForm() {
    String name = _nameController.text;
    String cpf = _cpfController.text;
    String description = _descriptionController.text;

    Student student = Student(name, cpf, description);
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
              createInput('Nome', _nameController),
              createInput('CPF', _cpfController, TextInputType.number),
              TextField(
                controller: _descriptionController,
                maxLines: null,
                decoration: const InputDecoration(labelText: 'Descricao'),
              ),
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
