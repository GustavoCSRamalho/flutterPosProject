import 'package:flutter/material.dart';
import 'package:gerenciador_de_massa/models/student.dart';
import 'package:gerenciador_de_massa/services/students_service.dart';

class StudentsProvider with ChangeNotifier {
  final StudentsService _studentsService = StudentsService();
  List<Student> _students = [];

  Future<List<Student>> list() async {
    if (_students.isEmpty) {
      _students = await _studentsService.list();
    }
    return _students;
  }

  Future<void> create(Student student) {
    Future<String> future = _studentsService.insert(student);
    return future.then((id) {
      student.id = id;
      _students.add(student);
      notifyListeners();
    });
  }

  Future<Student> read(String id) => _studentsService.show(id);

  Future<void> update(String id, Student student) {
    Future<Student> future = _studentsService.update(id, student);
    return future.then((newProduct) {
      Iterable<Student> filteredStudent =
          _students.where((prod) => prod.id == id);
      Student oldStudent = filteredStudent.first;
      oldStudent = newProduct;
      notifyListeners();
    });
  }

  Future<void> delete(String id) {
    Future<bool> future = _studentsService.delete(id);
    return future.then((isDeleted) {
      if (isDeleted) {
        Iterable<Student> filteredProduct =
            _students.where((prod) => prod.id == id);
        Student student = filteredProduct.first;
        _students.remove(student);
        notifyListeners();
      }
      return Future.value(isDeleted);
    });
  }
}
