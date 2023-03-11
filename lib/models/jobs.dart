// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Jobs {
  String Description;
  String Name;
  String city;
  String experience;
  String range;
  String role;
  String uid;
  Jobs({
    required this.Description,
    required this.Name,
    required this.city,
    required this.experience,
    required this.range,
    required this.role,
    required this.uid,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'Description': Description,
      'Name': Name,
      'city': city,
      'experience': experience,
      'range': range,
      'role': role,
      'uid': uid,
    };
  }

  factory Jobs.fromMap(Map<String, dynamic> map) {
    return Jobs(
      Description: map['Description'] as String,
      Name: map['Name'] as String,
      city: map['city'] as String,
      experience: map['experience'] as String,
      range: map['range'] as String,
      role: map['role'] as String,
      uid: map['uid'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Jobs.fromJson(String source) =>
      Jobs.fromMap(json.decode(source) as Map<String, dynamic>);
}
