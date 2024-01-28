import 'dart:convert';

import 'package:gerenciador_de_massa/models/student.dart';
import 'package:gerenciador_de_massa/repositories/student_repository.dart';
import 'package:http/http.dart';

class StudentsService {
  final StudentRepository _studentRepository = StudentRepository();

  Future<List<Student>> list() async {
    try {
      Response response = await _studentRepository.list();
      String body = response.body;
      Map<String, dynamic> json = jsonDecode(body);
      return Student.listFromJson(json);
    } catch (err) {
      return [];
    }
  }

  Future<String> insert(Student student) async {
    try {
      String json = jsonEncode(student.toJson());
      Response response = await _studentRepository.insert(json);
      String body = response.body;
      String name = jsonDecode(body)['name'];
      return name;
      // return jsonDecode(body) as String;
    } catch (err) {
      throw Exception('Problemas ao inserir dados.');
    }
  }

  Future<Student> show(String id) async {
    try {
      Response response = await _studentRepository.show(id);
      String body = response.body;
      Map<String, dynamic> json = jsonDecode(body);
      return Student.fromJson(json);
    } catch (err) {
      throw Exception('Problemas ao consultar dados.');
    }
  }

  Future<Student> update(String id, Student student) async {
    try {
      String productJson = jsonEncode(student.toJson());
      Response response = await _studentRepository.update(id, productJson);
      String body = response.body;
      Map<String, dynamic> updateStudent = jsonDecode(body);
      return Student.fromJson(updateStudent);
    } catch (err) {
      throw Exception('Problemas ao atualizar dados.');
    }
  }

  Future<bool> delete(String id) async {
    try {
      Response response = await _studentRepository.delete(id);
      return response.statusCode == 200;
    } catch (err) {
      throw Exception('Problemas ao excluir dados.');
    }
  }
}
