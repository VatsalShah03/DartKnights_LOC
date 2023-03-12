import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dart_knights/constants.dart';
import 'package:dart_knights/controllers/home_controller.dart';
import 'package:dart_knights/views/home/Notification_Page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:image_picker/image_picker.dart';

import '../auth/notification_api.dart';
import '../auth/notification_api.dart';

class EmployerPost extends StatefulWidget {
  const EmployerPost({Key? key}) : super(key: key);

  @override
  State<EmployerPost> createState() => _EmployerPostState();
}

class _EmployerPostState extends State<EmployerPost> {
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _roleController = TextEditingController();
  TextEditingController _rangeController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _experienceController = TextEditingController();
  HomeController homeController = Get.put(HomeController());
  String range = "";
  String city = "";
  String experience = "";
  String description = "";
  String role = "";

  @override
  void initState() {
    super.initState();

    NotificationApi.init();
    listnerNotifications();
  }

  void listnerNotifications() =>
      NotificationApi.onNotifications.stream.listen(onClickedNotification);

  void onClickedNotification(String? payload)=>
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context)=> NotificationPage(),
      ));

  @override
  void dispose() {
    _descriptionController.dispose();
    _roleController.dispose();
    _rangeController.dispose();
    _cityController.dispose();
    _experienceController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelStyle: TextStyle(color: Colors.black),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                            color: ResourceColors.primaryColor, width: 2)),
                    hintText: "Please enter the Description.",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    // prefixIcon: Icon(Icons.person,color: ResourceColors.black,),
                  ),
                  keyboardType: TextInputType.multiline,
                  maxLines: 5,
                  controller: _descriptionController,
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return 'Password cannot be empty';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    description = value!;
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelStyle: TextStyle(color: Colors.black),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                            color: ResourceColors.primaryColor, width: 2)),
                    hintText: "Please enter the role.",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    // prefixIcon: Icon(Icons.person,color: ResourceColors.black,),
                  ),
                  keyboardType: TextInputType.multiline,
                  maxLines: 2,
                  controller: _roleController,
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return 'Password cannot be empty';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    role = value!;
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelStyle: TextStyle(color: Colors.black),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                            color: ResourceColors.primaryColor, width: 2)),
                    hintText: "Please enter the range.",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    // prefixIcon: Icon(Icons.person,color: ResourceColors.black,),
                  ),
                  keyboardType: TextInputType.multiline,
                  maxLines: 2,
                  controller: _rangeController,
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return 'Password cannot be empty';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    range = value!;
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelStyle: TextStyle(color: Colors.black),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                            color: ResourceColors.primaryColor, width: 2)),
                    hintText: "Please enter the city.",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    // prefixIcon: Icon(Icons.person,color: ResourceColors.black,),
                  ),
                  keyboardType: TextInputType.multiline,
                  maxLines: 2,
                  controller: _cityController,
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return 'Password cannot be empty';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    city = value!;
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelStyle: TextStyle(color: Colors.black),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                            color: ResourceColors.primaryColor, width: 2)),
                    hintText: "Please enter the experience.",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    // prefixIcon: Icon(Icons.person,color: ResourceColors.black,),
                  ),
                  keyboardType: TextInputType.multiline,
                  maxLines: 2,
                  controller: _experienceController,
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return 'Password cannot be empty';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    experience = value!;
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),

              Container(
                child: Center(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: ListTile(
                          onTap: () async {
                            Map<String, dynamic> data = {
                              "Description": _descriptionController.text.trim(),
                              "role": _roleController.text.trim(),
                              "uid": FirebaseAuth.instance.currentUser!.uid,
                              "range": _rangeController.text.trim(),
                              "city": _cityController.text.trim(),
                              "experience": _experienceController.text.trim(),
                              "Name": homeController.name,
                            };
                            await FirebaseFirestore.instance
                                .collection("Jobs")
                                .doc()
                                .set(data);

                            NotificationApi.showNotification(
                              title: homeController.name,
                              body: _descriptionController.text.trim(),
                              payload: "payload"
                            );

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  "Successfully added!",
                                  style: TextStyle(
                                    color: Colors.black,
                                      letterSpacing: 1.5,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 21
                                  ),
                                ),
                                behavior: SnackBarBehavior.floating,
                                backgroundColor: Colors.white,
                              ),
                            );
    },
                          title: Center(
                            child: Text(
                              "EmployerPost",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 15,
                                  letterSpacing: 2),
                            ),
                          ),
                          tileColor: ResourceColors.tertiaryColor,
                          shape: RoundedRectangleBorder(
                              side: BorderSide(width: 2),
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

}
