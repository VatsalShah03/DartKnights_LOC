import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool signUpAsAnEmployer = false;
  bool isValidEmail(String input) {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(input);
  }

  final _formKey = GlobalKey<FormState>();

  TextEditingController _fNameController = TextEditingController();
  TextEditingController _lNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passController = TextEditingController();
  TextEditingController _confirmPassController = TextEditingController();
  TextEditingController aadharCardController = TextEditingController();
  TextEditingController orgController = TextEditingController();
  Map<String, dynamic> data = {};

  Future signUp() async {
    data["Name"] =
        _fNameController.text.trim() + " " + _lNameController.text.trim();
    data["Email"] = _emailController.text.trim();
    data["isPremium"] = false;
    if (signUpAsAnEmployer) {
      data["Aadhaar Number"] = aadharCardController.text.trim();
      data["Org Name"] = orgController.text.trim();
      data["is Employer"] = true;
    } else {
      data["is Employer"] = false;
    }
    showDialog(
        context: context,
        builder: (context) {
          return Center(child: CircularProgressIndicator());
        });
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passController.text.trim());
    var User = await FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(User?.uid)
        .set(data);
    Navigator.of(context).pop();
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _fNameController.dispose();
    _lNameController.dispose();
    _emailController.dispose();
    _passController.dispose();
    _confirmPassController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
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
          AppBar(
            backgroundColor: Colors.transparent,
          ),
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Card(
                    color: Colors.grey[200],
                    margin: EdgeInsets.symmetric(horizontal: 30),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 30,
                              left: 20,
                            ),
                            child: Text(
                              "Register! ",
                              style: TextStyle(
                                fontSize: screenWidth * 0.15,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 60,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: screenWidth * 0.3,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Card(
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: TextFormField(
                                        controller: _fNameController,
                                        keyboardType: TextInputType.text,
                                        style: TextStyle(color: Colors.black),
                                        validator: (text) {
                                          if (text == null || text.isEmpty) {
                                            return 'First Name cannot be empty';
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                            hintText: "Name",
                                            hintStyle:
                                                TextStyle(color: Colors.black),
                                            border: InputBorder.none),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: screenWidth * 0.3,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Card(
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: TextFormField(
                                        controller: _lNameController,
                                        keyboardType: TextInputType.text,
                                        style: TextStyle(color: Colors.black),
                                        validator: (text) {
                                          if (text == null || text.isEmpty) {
                                            return 'Last Name cannot be empty';
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                            hintText: "Last Name",
                                            hintStyle:
                                                TextStyle(color: Colors.black),
                                            border: InputBorder.none),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 15.0),
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
                              margin: EdgeInsets.symmetric(vertical: 20),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 15.0),
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
                              margin: EdgeInsets.only(bottom: 20),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 15.0),
                                child: TextFormField(
                                  controller: _confirmPassController,
                                  obscureText: true,
                                  style: TextStyle(color: Colors.black),
                                  validator: (text) {
                                    if (text == null || text.isEmpty) {
                                      return 'Confirm Password cannot be empty';
                                    }
                                    if (_passController.text.trim() !=
                                        _confirmPassController.text.trim()) {
                                      return 'Passwords don\'t match';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      hintText: "Confirm Password",
                                      hintStyle: TextStyle(color: Colors.black),
                                      border: InputBorder.none),
                                ),
                              ),
                              margin: EdgeInsets.only(bottom: 20),
                            ),
                          ),
                          signUpAsAnEmployer
                              ? Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Card(
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(left: 15.0),
                                      child: TextFormField(
                                        controller: aadharCardController,
                                        style: TextStyle(color: Colors.black),
                                        validator: (text) {
                                          if (text == null || text.isEmpty) {
                                            return 'Aadhar Card cannot be empty';
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                            hintText: "Aadhar Card Number",
                                            hintStyle:
                                                TextStyle(color: Colors.black),
                                            border: InputBorder.none),
                                      ),
                                    ),
                                    margin: EdgeInsets.only(bottom: 20),
                                  ),
                                )
                              : Container(),
                          signUpAsAnEmployer
                              ? Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Card(
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(left: 15.0),
                                      child: TextFormField(
                                        controller: orgController,
                                        style: TextStyle(color: Colors.black),
                                        validator: (text) {
                                          if (text == null || text.isEmpty) {
                                            return 'Org name cannot be empty';
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                            hintText: "Organization",
                                            hintStyle:
                                                TextStyle(color: Colors.black),
                                            border: InputBorder.none),
                                      ),
                                    ),
                                    margin: EdgeInsets.only(bottom: 20),
                                  ),
                                )
                              : Container(),
                          Padding(
                            padding: EdgeInsets.only(bottom: 8),
                            child: ListTile(
                              title: Text("Sign Up as an Employer"),
                              leading: Checkbox(
                                value: signUpAsAnEmployer,
                                onChanged: (value) {
                                  setState(() {
                                    signUpAsAnEmployer = value!;
                                  });
                                },
                              ),
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, bottom: 20, right: 20),
                              child: InkWell(
                                onTap: () {
                                  if (_formKey.currentState!.validate()) {
                                    signUp();
                                  }
                                },
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 12),
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: Card(
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Center(
                                            child: Text(
                                          "Sign Up",
                                          style: TextStyle(color: Colors.white),
                                        )),
                                      ),
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                ),
                              )),
                        ],
                      ),
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
