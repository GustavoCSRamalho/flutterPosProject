class StudentHistory {
  String? id;
  String studentId;
  String mass;

  StudentHistory(this.studentId, this.mass);

  StudentHistory.withId(this.id, this.studentId, this.mass);

  StudentHistory.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        studentId = json['studentId'],
        mass = json['mass'];

  Map<String, dynamic> toJson() => {
        'studentId': studentId,
        'mass': mass,
      };

  static List<StudentHistory> listFromJson(Map<String, dynamic> json) {
    List<StudentHistory> studentsHistory = [];
    json.forEach((key, value) {
      Map<String, dynamic> item = {'id': key, ...value};
      studentsHistory.add(StudentHistory.fromJson(item));
    });
    return studentsHistory;
  }
}
