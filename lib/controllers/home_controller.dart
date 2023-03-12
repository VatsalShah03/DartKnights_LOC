import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeController extends GetxController {
  final user = FirebaseAuth.instance.currentUser!;
  final userCollection = FirebaseFirestore.instance.collection('Users');
  String? name;
  String? email;
  bool? isEmployer, isPremium;
  Position? position;

  getUserDetails() async {
    DocumentSnapshot ds = await userCollection.doc(user.uid).get();
    name = ds.get("Name");
    email = ds.get("Email");
    isEmployer = ds.get("is Employer");
    isPremium = ds.get("isPremium");
    return [name, email, isEmployer, isPremium];
  }

  getCurrentUserLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    await FirebaseFirestore.instance.collection('Users').doc(user.uid).update({
      'marker id': user.uid,
      'latitude': position!.latitude,
      'longitude': position!.longitude
    });
  }
}
