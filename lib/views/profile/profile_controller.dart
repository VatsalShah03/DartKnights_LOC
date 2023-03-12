import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  final user = FirebaseAuth.instance.currentUser!;
  final userCollection = FirebaseFirestore.instance.collection('Users');
  String? name;
  String? email;
  bool? isEmployer;
  String? education;
  String? projects;
  String? address;

  getUserDetails(String uid) async {
    DocumentSnapshot ds = await userCollection.doc(uid).get();
    name = ds.get("Name");
    email = ds.get("Email");
    isEmployer = ds.get("is Employer");
    education = ds.get("education");
    projects = ds.get("projects");
    address = ds.get("address");
    return [name, email, isEmployer];
  }

  getUserEducation(String uid) async {
    DocumentSnapshot ds = await userCollection.doc(uid).get();
    education = ds.get("education");
    projects = ds.get("projects");
    address = ds.get("address");
  }
}
