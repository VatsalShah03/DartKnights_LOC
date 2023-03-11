import 'package:dart_knights/constants.dart';
import 'package:dart_knights/controllers/auth_controller/g_sign_in.dart';
import 'package:dart_knights/controllers/home_controller.dart';
import 'package:dart_knights/views/profile/profile_main.dart';
import 'package:dart_knights/views/settings/settings.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class NavDrawer extends StatefulWidget {
  const NavDrawer({super.key});

  @override
  State<NavDrawer> createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  HomeController homeController = Get.put(HomeController());

  Widget getPremiumNow() {
    return Card(
      margin: EdgeInsets.all(8),
      color: ResourceColors.tertiaryColor,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(children: [
          SizedBox(
              height: 80, child: SvgPicture.asset("assets/get_premium.svg")),
          Text(
            "Get Premium Now !!",
            style: TextStyle(color: ResourceColors.primaryColor, fontSize: 25),
          ),
          Text(
            "Click to check benefits",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.lightBlue[50],
      child: FutureBuilder(
          future: homeController.getUserDetails(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView(
              padding: EdgeInsets.zero,
              children: [
                UserAccountsDrawerHeader(
                  accountName: Text(homeController.name!),
                  accountEmail: Text(homeController.email!),
                  currentAccountPicture: CircleAvatar(
                    child: ClipOval(
                      child: Image.network(
                        'https://images.unsplash.com/photo-1522075469751-3a6694fb2f61?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8ZmFjZSUyMHByb2ZpbGV8ZW58MHx8MHx8&w=1000&q=80',
                        width: 90,
                        height: 90,
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                      color: Colors.blueGrey,
                      image: DecorationImage(
                          image: NetworkImage(
                              'https://images.pexels.com/photos/1072179/pexels-photo-1072179.jpeg?auto=compress&cs=tinysrgb&w=600'),
                          fit: BoxFit.cover)),
                ),
                ListTile(
                    leading: Icon(
                      Icons.person,
                      color: Colors.blueGrey.shade900,
                    ),
                    title: Text(
                      "Profile",
                      style: TextStyle(fontSize: 16),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ProfileMain(uid: homeController.user.uid)));
                    }),
                ListTile(
                    leading: Icon(
                      Icons.settings,
                      color: Colors.blueGrey.shade900,
                    ),
                    title: Text(
                      "Settings",
                      style: TextStyle(fontSize: 16),
                    ),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Setting()));
                    }),
                ListTile(
                  leading: Icon(
                    Icons.logout,
                    color: Colors.blueGrey.shade900,
                  ),
                  title: Text(
                    "Log-Out",
                    style: TextStyle(fontSize: 16),
                  ),
                  onTap: () {
                    final provider = Provider.of<GoogleSignInProvider>(context,
                        listen: false);
                    provider.logout();
                  },
                ),
                Spacer(),
                getPremiumNow()
              ],
            );
          }),
    );
  }
}
