class User {
  final String id;
  final String name;
  final String email;
  final String surname;
  final bool active;
  final String? note;
  final String createdAt;
  final String updatedAt;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.surname,
    required this.active,
    this.note,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      surname: json['surname'],
      active: json['active'],
      note: json['note'] as String? ?? '',
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'surname': surname,
      'active': active,
      'note': note,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
