class Student {
  String? id;
  String name;
  String cpf;
  String description;

  Student(this.name, this.cpf, this.description);

  Student.withId(this.id, this.name, this.cpf, this.description);

  Student.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        cpf = json['cpf'],
        description = json['description'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'cpf': cpf,
        'description': description,
      };

  static List<Student> listFromJson(Map<String, dynamic> json) {
    List<Student> products = [];
    json.forEach((key, value) {
      Map<String, dynamic> item = {'id': key, ...value};
      products.add(Student.fromJson(item));
    });
    return products;
  }
}
