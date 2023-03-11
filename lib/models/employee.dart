// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Employee {
  String name;
  String email;
  bool isPremium;
  Employee({
    required this.name,
    required this.email,
    required this.isPremium,
  });

  Employee copyWith({
    String? name,
    String? email,
    bool? isPremium,
  }) {
    return Employee(
      name: name ?? this.name,
      email: email ?? this.email,
      isPremium: isPremium ?? this.isPremium,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'isPremium': isPremium,
    };
  }

  factory Employee.fromMap(Map<String, dynamic> map) {
    return Employee(
      name: map['name'] as String,
      email: map['email'] as String,
      isPremium: map['isPremium'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory Employee.fromJson(String source) =>
      Employee.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'Employee(name: $name, email: $email, isPremium: $isPremium)';

  @override
  bool operator ==(covariant Employee other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.email == email &&
        other.isPremium == isPremium;
  }

  @override
  int get hashCode => name.hashCode ^ email.hashCode ^ isPremium.hashCode;
}
