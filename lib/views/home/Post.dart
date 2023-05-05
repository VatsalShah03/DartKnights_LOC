import 'dart:io';
import 'package:path/path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dart_knights/constants.dart';
import 'package:dart_knights/controllers/home_controller.dart';
import 'package:dart_knights/views/auth/notification_api.dart';
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
                  maxLines: 14,
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
                height: 40,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                height: 160,
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.black),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Center(
                  child: GestureDetector(
                    onTap: () {
                      pickImage(ImageSource.gallery);
                    },
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
                          scale: 4,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                child: Center(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 25,
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: ListTile(
                          onTap: () async {
                            showDialog(context: context, builder: (context)=>Center(child: CircularProgressIndicator(),));
                            Map<String, dynamic> data = {
                              "Description": _descriptionController.text.trim(),
                              "url": await uploadFile(),
                              "uid": FirebaseAuth.instance.currentUser!.uid,
                              "UserName": homeController.name,
                            };
                            NotificationApi.showNotification(
                                title: homeController.name,
                                body: _descriptionController.text.trim(),
                                payload: "payload");

                            await FirebaseFirestore.instance
                                .collection("Posts")
                                .doc()
                                .set(data);
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  "Successfully added!",
                                  style: TextStyle(
                                      color: Colors.black,
                                      letterSpacing: 1.5,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 21),
                                ),
                                behavior: SnackBarBehavior.floating,
                                backgroundColor: Colors.white,
                              ),
                            );
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
        name = basename(imageTemporary.path);
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
    print('Download link:$urlDownload');
    return urlDownload;
  }
}