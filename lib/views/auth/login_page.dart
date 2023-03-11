import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dart_knights/controllers/auth_controller/g_sign_in.dart';
import 'package:dart_knights/controllers/home_controller.dart';
import 'package:dart_knights/views/auth/signup_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isValidEmail(String input) {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(input);
  }

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passController = TextEditingController();
  final _formKeyLogin = GlobalKey<FormState>();
  Position? position;
  var user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
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

      await FirebaseFirestore.instance
          .collection('Users')
          .doc(user!.uid)
          .update({
        'marker id': user!.uid,
        'latitude': position!.latitude,
        'longitude': position!.longitude
      });
    }

    Future<bool> checkIfDocExists(String docId) async {
      try {
        var collectionRef = FirebaseFirestore.instance.collection('Users');
        var doc = await collectionRef.doc(docId).get();
        print(doc.exists);
        print(doc.exists);
        return doc.exists;
      } catch (e) {
        throw e;
      }
    }

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    Future signIn() async {
      try {
        showDialog(
            context: context,
            builder: (context) {
              return Center(child: CircularProgressIndicator());
            });
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passController.text.trim());
        getCurrentUserLocation();
        Navigator.of(context).pop();
      } catch (e) {
        Navigator.of(context).pop();
        showDialog(
            context: context,
            builder: (context) {
              return Center(
                  child: Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white,
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(e.toString()),
                          ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                "OK",
                                style: TextStyle(color: Colors.white),
                              ))
                        ],
                      )));
            });
      }
    }

    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            "assets/login.jpg",
            width: screenWidth,
            height: screenHeight,
            fit: BoxFit.fill,
          ),
          BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: Container(
                width: screenWidth,
                height: screenHeight,
                decoration:
                    BoxDecoration(color: Colors.grey.shade400.withOpacity(0.1)),
              )),
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKeyLogin,
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    color: Colors.grey[200],
                    margin: EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 30, left: 15),
                          child: Text(
                            "Hello,",
                            style: TextStyle(
                              fontSize: 80,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Text(
                            "Login Now!",
                            style: TextStyle(fontSize: 30),
                          ),
                        ),
                        SizedBox(
                          height: 60,
                        ),
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 5),
                            child: TextFormField(
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              style: TextStyle(color: Colors.black),
                              validator: (text) => isValidEmail(text!)
                                  ? null
                                  : "Enter valid email",
                              decoration: InputDecoration(
                                  hintText: "Email",
                                  hintStyle: TextStyle(color: Colors.black),
                                  border: InputBorder.none),
                            ),
                          ),
                          margin: EdgeInsets.all(20),
                        ),
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 5),
                            child: TextFormField(
                              controller: _passController,
                              obscureText: true,
                              style: TextStyle(color: Colors.black),
                              validator: (text) {
                                if (text == null || text.isEmpty) {
                                  return 'Password cannot be empty';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                  hintText: "Password",
                                  hintStyle: TextStyle(color: Colors.black),
                                  border: InputBorder.none),
                            ),
                          ),
                          margin:
                              EdgeInsets.only(bottom: 20, left: 20, right: 20),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(
                                left: 20, bottom: 20, right: 20),
                            child: InkWell(
                              onTap: () async {
                                if (_formKeyLogin.currentState!.validate()) {
                                  signIn();
                                }
                              },
                              child: SizedBox(
                                width: double.infinity,
                                child: Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                        child: Text(
                                      "Sign In",
                                      style: TextStyle(color: Colors.white),
                                    )),
                                  ),
                                  color: Colors.grey[700],
                                ),
                              ),
                            )),
                        Padding(
                          padding: const EdgeInsets.only(left: 15, bottom: 20),
                          child: Row(
                            children: [
                              Text(
                                "Don't have an account?  ",
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SignupPage()));
                                },
                                child: Text(
                                  "Register Now",
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.blue),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Center(
                          child: Text("---OR---"),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              onTap: () async {
                                final provider =
                                    Provider.of<GoogleSignInProvider>(context,
                                        listen: false);
                                provider.googleLogin();
                                final firebaseUser =
                                    FirebaseAuth.instance.currentUser!;
                                bool docExists =
                                    await checkIfDocExists(firebaseUser.uid);
                                print(docExists);
                                if (docExists) {
                                } else {
                                  print(firebaseUser.uid);
                                  await FirebaseFirestore.instance
                                      .collection('Users')
                                      .doc(firebaseUser.uid)
                                      .set({
                                    "First Name": provider.user.displayName,
                                    "Email": provider.user.email,
                                  });
                                }
                              },
                              child: Card(
                                child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Image.asset(
                                    "assets/images.png",
                                    width: 30,
                                    height: 30,
                                  ),
                                ),
                              ),
                            ),
                            Card(
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Image.asset(
                                  "assets/f-logo.png",
                                  width: 30,
                                  height: 30,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
