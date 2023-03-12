import 'package:dart_knights/constants.dart';
import 'package:dart_knights/controllers/home_controller.dart';
import 'package:dart_knights/views/profile/editProfile.dart';
import 'package:dart_knights/views/profile/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileInfoWidget extends StatefulWidget {
  const ProfileInfoWidget(
      {super.key, required this.name, required this.email, required this.uid});
  final String email;
  final String name;
  final String uid;

  @override
  State<ProfileInfoWidget> createState() => _ProfileInfoWidgetState();
}

class _ProfileInfoWidgetState extends State<ProfileInfoWidget> {
  HomeController homeController = Get.put(HomeController());
  String? education;
  ProfileController profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.grey,
                radius: width * 0.2,
              ),
              const Spacer(),
              Container(
                margin: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: ResourceColors.primaryColor,
                ),
                child: IconButton(
                  icon: const Icon(
                    Icons.edit,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditProfile(
                          userName: widget.name,
                          userEmail: widget.email,
                          uid: homeController.user.uid,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            widget.name,
            style: TextStyle(
              fontSize: height * 0.028,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            children: [
              const Icon(
                Icons.mail,
                size: 20,
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                widget.email,
                style: TextStyle(
                    fontSize: height * 0.016, fontWeight: FontWeight.w500),
              )
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          if (profileController.education != null)
            Row(
              children: [
                const Icon(
                  Icons.book,
                  size: 20,
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  profileController.education!,
                  style: TextStyle(
                      fontSize: height * 0.016, fontWeight: FontWeight.w500),
                )
              ],
            ),
          const SizedBox(
            height: 8,
          ),
          if (profileController.address != null)
            Row(
              children: [
                const Icon(
                  Icons.location_city,
                  size: 20,
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: Text(
                    profileController.address!,
                    style: TextStyle(
                        fontSize: height * 0.016, fontWeight: FontWeight.w500),
                  ),
                )
              ],
            ),
          const SizedBox(
            height: 8,
          ),
          Row(
            children: [
              InkWell(
                onTap: () {},
                child: const Icon(
                  Icons.link,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              const Text(
                "linktr.ee/employer1",
                style: TextStyle(color: Colors.blue),
              )
            ],
          ),
        ],
      ),
    );
  }
}
