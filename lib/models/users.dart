class Users {
  final String? id;
  final String Email;
  final double? latitude;
  final double? longitude;
  final String Name;
  final bool isEmployer;
  final String? orgName;
  final String? aadhaarNo;
  final bool isPremium;

  Users(
      {this.id,
      this.longitude,
      this.latitude,
      required this.Name,
      this.aadhaarNo,
      this.orgName,
      required this.isEmployer,
      required this.Email,
      required this.isPremium});

  Map<String, dynamic> toJson() => {
        'marker id': id,
        'latitude': latitude,
        'longitude': longitude,
        'Name': Name,
        'Org Name': orgName,
        'Aadhaar Number': aadhaarNo,
        'Email': Email,
        'is Employer': isEmployer,
        'isPremium': isPremium
      };

  static Users fromJson(Map<String, dynamic> json) => Users(
      id: json["marker id"],
      isEmployer: json["is Employer"],
      aadhaarNo: json["Aadhaar Number"],
      Email: json["Email"],
      Name: json["Name"],
      latitude: json['latitude'],
      longitude: json['longitude'],
      isPremium: json['isPremium'],
      orgName: json["Org Name"]);
}
