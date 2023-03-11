import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dart_knights/constants.dart';
import 'package:dart_knights/controllers/home_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class Post extends StatefulWidget {
  const Post({Key? key}) : super(key: key);

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
  TextEditingController _descriptionController = TextEditingController();
  HomeController homeController = Get.put(HomeController());
  late PickedFile imageFile;
  final ImagePicker _picker = ImagePicker();
  String description = "";
  String title = "";
  File? image;
  String? name;

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
        backgroundColor: ResourceColors.primaryColor,
      ),
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
                    hintText: "Let Others Know Your Experience!",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    // prefixIcon: Icon(Icons.person,color: ResourceColors.black,),
                  ),
                  keyboardType: TextInputType.multiline,
                  maxLines: 7,
                  controller: _descriptionController,
                  onSaved: (value) {
                    description = value!;
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: Column(
                  children: [
                    image != null
                        ? Image.file(
                            image!,
                            width: 160,
                            height: 160,
                            fit: BoxFit.cover,
                          )
                        : Image.network(
                            'https://cdn.icon-icons.com/icons2/564/PNG/512/Add_Image_icon-icons.com_54218.png',
                            scale: 3,
                          )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Divider(
                color: Colors.black,
                height: 25,
                thickness: 1,
                indent: 25,
                endIndent: 25,
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
                          onTap: () {
                            pickImage(ImageSource.gallery);
                          },
                          leading: Icon(
                            Icons.photo_size_select_actual_outlined,
                            size: 25,
                          ),
                          title: Text(
                            "Choose image from Gallery",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 15,
                                letterSpacing: 2),
                          ),
                          shape: RoundedRectangleBorder(
                              side: BorderSide(width: 2),
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: ListTile(
                          onTap: () async {
                            Map<String, dynamic> data = {
                              "Description": _descriptionController.text.trim(),
                              "url": await uploadFile(),
                              "uid": FirebaseAuth.instance.currentUser!.uid,
                              "UserName": homeController.name,
                            };
                            await FirebaseFirestore.instance
                                .collection("Users")
                                .doc()
                                .set(data);
                          },
                          title: Center(
                            child: Text(
                              "Post",
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

  Future pickImage(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    try {
      if (image == null) return;
      final imageTemporary = File(image.path);
      setState(() {
        this.image = imageTemporary;
      });
    } on PlatformException catch (e) {
      print('Failed to pick image:$e');
    }
  }

  // Future<File> saveImagePermanently(String path) async {
  //   final directory = await getApplicationDocumentsDirectory();
  //   final name = basename(path);
  //   final image = File('${directory.path}/$name');
  //   return File(path).copy(image.path);
  // }
  Future uploadFile() async {
    final path = 'images/$name';
    final ref = FirebaseStorage.instance.ref().child(path);
    var uploadTask = ref.putFile(image!);
    final snapshot = await uploadTask.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();
    print('Dowload link:$urlDownload');
    return urlDownload;
  }
}
