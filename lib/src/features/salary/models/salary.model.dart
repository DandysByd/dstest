class Salary {
  final int money;
  final int year;
  final int month;
  final String id;
  final String createdAt;
  final String updatedAt;

  Salary({
    required this.money,
    required this.year,
    required this.month,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Salary.fromJson(Map<String, dynamic> json) {
    return Salary(
      money: json['money'],
      year: json['year'],
      month: json['month'],
      id: json['id'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'money': money,
      'year': year,
      'month': month,
      'id': id,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  Salary copyWith({
    int? money,
    int? year,
    int? month,
    String? id,
    String? createdAt,
    String? updatedAt,
  }) {
    return Salary(
      money: money ?? this.money,
      year: year ?? this.year,
      month: month ?? this.month,
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
