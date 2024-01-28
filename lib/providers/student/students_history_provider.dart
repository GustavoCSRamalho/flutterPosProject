import 'package:flutter/material.dart';
import 'package:gerenciador_de_massa/mock/mock_students_history.dart';
import 'package:gerenciador_de_massa/models/student_history.dart';
import 'package:gerenciador_de_massa/services/students_history_service.dart';

class StudentsHistoryProvider with ChangeNotifier {
  final List<StudentHistory> _studentHistory = MOCK_STUDENTS_HISTORY;

  final StudentsHistoryService _studentHistorySeervice =
      StudentsHistoryService();

  List<StudentHistory> getStudentHistory(String id) => _studentHistory
      .where((studentHistory) => studentHistory.studentId == id)
      .toList();

  Future<void> create(StudentHistory studentHistory) {
    Future<String> future = _studentHistorySeervice.insert(studentHistory);
    return future.then((id) {
      studentHistory.id = id;
      _studentHistory.add(studentHistory);
      notifyListeners();
    });
  }

  Future<StudentHistory> read(String id) => _studentHistorySeervice.show(id);

  Future<void> update(String id, StudentHistory studentHistory) {
    Future<StudentHistory> future =
        _studentHistorySeervice.update(id, studentHistory);
    return future.then((newProduct) {
      Iterable<StudentHistory> filteredStudent =
          _studentHistory.where((prod) => prod.id == id);
      StudentHistory oldStudent = filteredStudent.first;
      oldStudent = newProduct;
      notifyListeners();
    });
  }

  Future<bool> delete(String id) {
    Future<bool> future = _studentHistorySeervice.delete(id);
    return future.then((isDeleted) {
      if (isDeleted) {
        Iterable<StudentHistory> filteredProduct =
            _studentHistory.where((prod) => prod.id == id);
        StudentHistory student = filteredProduct.first;
        _studentHistory.remove(student);
        notifyListeners();
      }
      return Future.value(isDeleted);
    });
  }
}
