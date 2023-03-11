// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class PreviousJobs {
  String companyName;
  String companyLogo;
  String position;
  String description;
  PreviousJobs({
    required this.companyName,
    required this.companyLogo,
    required this.position,
    required this.description,
  });

  PreviousJobs copyWith({
    String? companyName,
    String? companyLogo,
    String? position,
    String? description,
  }) {
    return PreviousJobs(
      companyName: companyName ?? this.companyName,
      companyLogo: companyLogo ?? this.companyLogo,
      position: position ?? this.position,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'companyName': companyName,
      'companyLogo': companyLogo,
      'position': position,
      'description': description,
    };
  }

  factory PreviousJobs.fromMap(Map<String, dynamic> map) {
    return PreviousJobs(
      companyName: map['companyName'] as String,
      companyLogo: map['companyLogo'] as String,
      position: map['position'] as String,
      description: map['description'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory PreviousJobs.fromJson(String source) =>
      PreviousJobs.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PreviousJobs(companyName: $companyName, companyLogo: $companyLogo, position: $position, description: $description)';
  }

  @override
  bool operator ==(covariant PreviousJobs other) {
    if (identical(this, other)) return true;

    return other.companyName == companyName &&
        other.companyLogo == companyLogo &&
        other.position == position &&
        other.description == description;
  }

  @override
  int get hashCode {
    return companyName.hashCode ^
        companyLogo.hashCode ^
        position.hashCode ^
        description.hashCode;
  }
}
