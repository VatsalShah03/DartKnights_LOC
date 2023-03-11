import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dart_knights/controllers/home_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class maps extends StatefulWidget {
  const maps({Key? key}) : super(key: key);

  @override
  State<maps> createState() => _mapsState();
}

class _mapsState extends State<maps> {
  Position? _currentPosition;
  late GoogleMapController _mapController;
  final Set<Marker> _markers = <Marker>{};
  late Stream<List<Users>> stream;
  late List<Users> list;
  var user = FirebaseAuth.instance.currentUser;
  HomeController homeController = Get.put(HomeController());

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homeController.getCurrentUserLocation();
  }

  @override
  Widget build(BuildContext context) {
    homeController.getCurrentUserLocation();
    return SafeArea(
        child: Scaffold(
      body: StreamBuilder(
          stream: _readEmplyersLocation(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            }

            _markers.add(Marker(
              markerId: MarkerId(user!.uid),
              position: LatLng(homeController.position!.latitude,
                  homeController.position!.longitude),
            ));

            for (int i = 0; i < snapshot.data!.length; i++) {
              print(snapshot.data![i].latitude!);
              if (snapshot.data![i].isEmployer == true) {
                _markers.add(Marker(
                    markerId: MarkerId(snapshot.data![i].id!),
                    position: LatLng(snapshot.data![i].latitude!,
                        snapshot.data![i].longitude!)));
              } else if (snapshot.data![i].id! == user!.uid) {
                _markers.add(Marker(
                    markerId: MarkerId(snapshot.data![i].id!),
                    position: LatLng(snapshot.data![i].latitude!,
                        snapshot.data![i].longitude!),
                    icon: BitmapDescriptor.defaultMarkerWithHue(210)));
              }
            }
            return Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                    target: LatLng(homeController.position!.latitude,
                        homeController.position!.longitude),
                    zoom: 14),
                onMapCreated: _onMapCreated,
                markers: _markers,
                circles: {
                  Circle(
                    circleId: CircleId(user!.uid),
                    center: LatLng(homeController.position!.latitude,
                        homeController.position!.longitude),
                    radius: 750,
                    fillColor: Colors.green.withOpacity(0.5),
                    strokeColor: Colors.green.withOpacity(0.5),
                    strokeWidth: 1
                  )
                },
              ),
            );
          }),
    ));
  }

  Stream<List<Users>>? _readEmplyersLocation() {
    try {
      //print(position);
      return FirebaseFirestore.instance.collection("Users").snapshots().map(
          (snapshot) =>
              snapshot.docs.map((doc) => Users.fromJson(doc.data())).toList());
    } catch (err) {
      print(err.toString());
    }
    return null;
  }

  Stream<List<Users>> readEmployers() {
    return FirebaseFirestore.instance.collection("Users").snapshots().map(
        (snapshot) =>
            snapshot.docs.map((doc) => Users.fromJson(doc.data())).toList());
  }

  Future getData() async {}
}

class Users {
  final String? id;
  final String Email;
  final double? latitude;
  final double? longitude;
  final String Name;
  final bool isEmployer;
  final String? orgName;
  final String? aadhaarNo;

  Users(
      {this.id,
      this.longitude,
      this.latitude,
      required this.Name,
      this.aadhaarNo,
      this.orgName,
      required this.isEmployer,
      required this.Email});

  Map<String, dynamic> toJson() => {
        'marker id': id,
        'latitude': latitude,
        'longitude': longitude,
        'Name': Name,
        'Org Name': orgName,
        'Aadhaar Number': aadhaarNo,
        'Email': Email,
        'is Employer': isEmployer
      };

  static Users fromJson(Map<String, dynamic> json) => Users(
      id: json["marker id"],
      isEmployer: json["is Employer"],
      aadhaarNo: json["Aadhaar Number"],
      Email: json["Email"],
      Name: json["Name"],
      latitude: json['latitude'],
      longitude: json['longitude'],
      orgName: json["Org Name"]);
}
