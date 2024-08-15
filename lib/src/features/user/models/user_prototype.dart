class UserPrototype {
  final String name;
  final String email;
  final String plainPassword;
  final bool active;
  final String surname;
  final String? note;

  UserPrototype({
    required this.name,
    required this.email,
    required this.plainPassword,
    required this.active,
    required this.surname,
    required this.note,
  });

  factory UserPrototype.fromJson(Map<String, dynamic> json) {
    return UserPrototype(
      name: json['name'],
      email: json['email'],
      plainPassword: json['plainPassword'],
      active: json['active'],
      surname: json['surname'],
      note: json['note'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'plainPassword': plainPassword,
      'active': active,
      'surname': surname,
      'note': note,
    };
  }
}
