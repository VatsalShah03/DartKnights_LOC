import 'package:dart_knights/controllers/auth_controller/g_sign_in.dart';
import 'package:dart_knights/controllers/home_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class NavDrawer extends StatefulWidget {
  const NavDrawer({super.key});

  @override
  State<NavDrawer> createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  HomeController homeController = Get.put(HomeController());
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
                    onTap: () {}),
                ListTile(
                    leading: Icon(
                      Icons.settings,
                      color: Colors.blueGrey.shade900,
                    ),
                    title: Text(
                      "Settings",
                      style: TextStyle(fontSize: 16),
                    ),
                    onTap: () {}),
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
              ],
            );
          }),
    );
  }
}