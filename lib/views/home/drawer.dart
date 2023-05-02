import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dart_knights/constants.dart';
import 'package:dart_knights/controllers/auth_controller/g_sign_in.dart';
import 'package:dart_knights/controllers/home_controller.dart';
import 'package:dart_knights/views/Donation.dart';
import 'package:dart_knights/views/nearby_devices/example/MainPage.dart';
import 'package:dart_knights/views/payment/razorpay.dart';
import 'package:dart_knights/views/profile/profile_main.dart';
import 'package:dart_knights/views/settings/settings.dart';
import 'package:dart_knights/views/videoCalling/VideoCall.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../Donation.dart';
import '../payment/razorpay.dart';

class NavDrawer extends StatefulWidget {
  const NavDrawer({super.key});

  @override
  State<NavDrawer> createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  HomeController homeController = Get.put(HomeController());

  Widget getPremiumNow() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Payment()));
      },
      child: Card(
        margin: EdgeInsets.all(8),
        color: ResourceColors.tertiaryColor,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(children: [
            SizedBox(
                height: 80, child: SvgPicture.asset("assets/get_premium.svg")),
            Text(
              "Get Premium Now !!",
              style:
                  TextStyle(color: ResourceColors.primaryColor, fontSize: 25),
            ),
            Text(
              "Click to check benefits",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ]),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.lightBlue[50],
      child: FutureBuilder<dynamic>(
          future: getUserDetails(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            print(snapshot.data);
            return ListView(
              padding: EdgeInsets.zero,
              children: [
                UserAccountsDrawerHeader(
                  accountName: Text(snapshot.data![0]),
                  accountEmail: Text(snapshot.data![1]),
                  currentAccountPicture:
                      CircleAvatar(child: Icon(Icons.person)),
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
                // ListTile(
                //   leading: Icon(
                //     Icons.video_camera_front,
                //     color: Colors.blueGrey.shade900,
                //   ),
                //   title: Text(
                //     "Video Call",
                //     style: TextStyle(fontSize: 16),
                //   ),
                //   onTap: () {
                //     print(homeController.isPremium!);
                //     snapshot.data[3]
                //         ? Navigator.push(
                //             context,
                //             MaterialPageRoute(
                //                 builder: (context) => VideoCall()))
                //         : ScaffoldMessenger.of(context).showSnackBar(
                //             SnackBar(
                //               content: Text(
                //                 "Sorry! You have to avail premium to enable this feature. Do so by clicking on the hamburger icon located at top left.",
                //                 style: TextStyle(
                //                     color: Colors.black,
                //                     letterSpacing: 1.5,
                //                     fontWeight: FontWeight.bold,
                //                     fontSize: 21),
                //               ),
                //               behavior: SnackBarBehavior.floating,
                //               backgroundColor: Colors.white,
                //             ),
                //           );
                //   },
                // ),
                ListTile(
                    leading: Icon(
                      Icons.water_drop,
                      color: Colors.blueGrey.shade900,
                    ),
                    title: Text(
                      "Donations",
                      style: TextStyle(fontSize: 16),
                    ),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Donation()));
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
                ListTile(
                  leading: Icon(
                    Icons.bluetooth,
                    color: Colors.blueGrey.shade900,
                  ),
                  title: Text(
                    "Nearby Devices",
                    style: TextStyle(fontSize: 16),
                  ),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MainPage()));
                  },
                ),
                SizedBox(height: 210,),
                //getPremiumNow()
                ListTile(
                    leading: Icon(
                      Icons.monetization_on,
                      color: ResourceColors.secondaryColor,
                    ),
                    title: Text(
                      "Try Premium",
                      style: TextStyle(fontSize: 16,
                      color: ResourceColors.secondaryColor,
                      fontWeight: FontWeight.w900),
                    ),
                    onTap: () {
                      Navigator.push(
                          context, MaterialPageRoute(builder: (context) => Payment()));
                    }),
              ],
            );
          }),
    );
  }

  getUserDetails() async {
    final user = FirebaseAuth.instance.currentUser!;
    final userCollection = FirebaseFirestore.instance.collection('Users');
    String? name;
    String? email;
    bool? isEmployer, isPremium;

    DocumentSnapshot ds = await userCollection.doc(user.uid).get();
    name = ds.get("Name");
    email = ds.get("Email");
    isEmployer = ds.get("is Employer");
    isPremium = ds.get("isPremium");
    return [name, email, isEmployer, isPremium];
  }
}
