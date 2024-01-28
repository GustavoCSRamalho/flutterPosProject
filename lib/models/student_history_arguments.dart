import 'package:gerenciador_de_massa/models/student.dart';

class StudentHistoryArguments {
  String? studentHistoryId;
  Student student;
  Function? action;

  StudentHistoryArguments(this.student, this.action);

  StudentHistoryArguments.withId(
      this.studentHistoryId, this.student, this.action);
}
