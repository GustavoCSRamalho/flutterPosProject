import 'dart:convert';

import 'package:gerenciador_de_massa/models/student_history.dart';
import 'package:gerenciador_de_massa/repositories/student_history_repository.dart';
import 'package:http/http.dart';

class StudentsHistoryService {
  final StudentHistoryRepository _studentsRepository =
      StudentHistoryRepository();

  Future<List<StudentHistory>> list() async {
    try {
      Response response = await _studentsRepository.list();
      String body = response.body;
      Map<String, dynamic> json = jsonDecode(body);
      return StudentHistory.listFromJson(json);
    } catch (err) {
      return [];
      // throw Exception('Problemas ao consultar dados.');
    }
  }

  Future<String> insert(StudentHistory studentHistory) async {
    try {
      String json = jsonEncode(studentHistory.toJson());
      Response response = await _studentsRepository.insert(json);
      String body = response.body;
      String name = jsonDecode(body)['name'];
      return name;
      // return jsonDecode(body) as String;
    } catch (err) {
      throw Exception('Problemas ao inserir dados.');
    }
  }

  Future<StudentHistory> show(String id) async {
    try {
      Response response = await _studentsRepository.show(id);
      String body = response.body;
      Map<String, dynamic> json = jsonDecode(body);
      return StudentHistory.fromJson(json);
    } catch (err) {
      throw Exception('Problemas ao consultar dados.');
    }
  }

  Future<StudentHistory> update(
      String id, StudentHistory studentHistory) async {
    try {
      String studentHistoryJson = jsonEncode(studentHistory.toJson());
      Response response =
          await _studentsRepository.update(id, studentHistoryJson);
      String body = response.body;
      Map<String, dynamic> updateStudent = jsonDecode(body);
      return StudentHistory.fromJson(updateStudent);
    } catch (err) {
      throw Exception('Problemas ao atualizar dados.');
    }
  }

  Future<bool> delete(String id) async {
    try {
      Response response = await _studentsRepository.delete(id);
      return response.statusCode == 200;
    } catch (err) {
      throw Exception('Problemas ao excluir dados.');
    }
  }
}
