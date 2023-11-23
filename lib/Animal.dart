class Animal {
  late int? id;
  late String name;

  Animal({required this.name, this.id});

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name};
  }

  Animal.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
  }
}
