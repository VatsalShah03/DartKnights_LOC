// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Posts {
  String Description;
  String UserName;
  String uid;
  String url;
  Posts({
    required this.Description,
    required this.UserName,
    required this.uid,
    required this.url,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'Description': Description,
      'UserName': UserName,
      'uid': uid,
      'url': url,
    };
  }

  factory Posts.fromMap(Map<String, dynamic> map) {
    return Posts(
      Description: map['Description'] as String,
      UserName: map['UserName'] as String,
      uid: map['uid'] as String,
      url: map['url'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Posts.fromJson(String source) =>
      Posts.fromMap(json.decode(source) as Map<String, dynamic>);
}
