import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:dart_knights/Home.dart';
import 'package:dart_knights/Home.dart';
import 'package:dart_knights/NewsPage.dart';
import 'package:dart_knights/controllers/home_controller.dart';
import 'package:dart_knights/views/MentalHealth.dart';
import 'package:dart_knights/views/home/jobs.dart';
import 'package:dart_knights/views/home/EmployerPost.dart';
import 'package:dart_knights/views/maps.dart';
import 'package:dart_knights/views/payment/razorpay.dart';

import 'package:dart_knights/constants.dart';
import 'package:dart_knights/views/home/Post.dart';
import 'package:dart_knights/views/home/drawer.dart';
import 'package:dart_knights/views/videoCalling/VideoCall.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  HomeController homeController = Get.put(HomeController());
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.w600);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homeController.getCurrentUserLocation();
    homeController.getUserDetails();
  }

  @override
  Widget build(BuildContext context) {
    List<IconData> iconList = [
      Icons.home,
      Icons.newspaper,
      Icons.work,
      homeController.isEmployer == true ? Icons.video_call : Icons.location_pin
    ];
    List<String> list = [
      "Home",
      "News",
      "Jobs",
      homeController.isEmployer == true ? "Video Call" : "Map",
      "Post"
    ];
    print(homeController.isEmployer);
    List<Widget> _widgetOptions = <Widget>[
      Home(),
      FlutterNews(),
      JobsPage(),
      homeController.isEmployer == true ? VideoCall() : maps(),
      homeController.isEmployer == true ? EmployerPost() : Post()
    ];
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
          //leading: IconButton(icon: Icons.menu, onPressed: (){Scaffold.},),
          title: Text(list[_selectedIndex]),
          backgroundColor: ResourceColors.primaryColor,
          actions: [
            // IconButton(
            //     onPressed: () {
            //       Navigator.push(context,
            //           MaterialPageRoute(builder: (context) => FlutterNews()));
            //     },
            //     icon: Icon(Icons.newspaper)),
            IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => MentalHealth()));
                },
                icon: Icon(Icons.health_and_safety_rounded)),
            IconButton(onPressed: () {}, icon: Icon(Icons.notifications)),
          ]),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ResourceColors.secondaryColor,
        child: Icon(Icons.add),
        onPressed: () {
          setState(() {
            _selectedIndex = 4;
          });
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar(
        backgroundColor: ResourceColors.primaryColor,
        activeColor: Colors.white,
        inactiveColor: ResourceColors.tertiaryColor,
        icons: iconList,
        activeIndex: _selectedIndex,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.smoothEdge,
        onTap: (index) => setState(() => _selectedIndex = index),
        //other params
      ),
      body: _selectedIndex == 4
          ? (homeController.isEmployer == true ? EmployerPost() : Post())
          : _widgetOptions.elementAt(_selectedIndex),
      // bottomNavigationBar: Container(
      //   decoration: BoxDecoration(
      //     color: ResourceColors.primaryColor,
      //     boxShadow: [
      //       BoxShadow(
      //         blurRadius: 20,
      //         color: Colors.black.withOpacity(.1),
      //       )
      //     ],
      //   ),
      //   child: SafeArea(
      //     child: Padding(
      //       padding: const EdgeInsets.fromLTRB(15, 8, 15, 8),
      //       child: GNav(
      //         rippleColor: Colors.grey[300]!,
      //         hoverColor: Colors.grey[100]!,
      //         gap: 8,
      //         activeColor: ResourceColors.primaryColor,
      //         iconSize: 24,
      //         padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      //         duration: Duration(milliseconds: 400),
      //         tabBackgroundColor: Colors.grey[100]!,
      //         //color: Colors.black,
      //         tabs: [
      //           GButton(
      //             icon: Icons.home_filled,
      //             text: 'Home',
      //             iconColor: Colors.white,
      //           ),
      //           GButton(
      //             icon: Icons.add_box,
      //             text: "Post",
      //             iconColor: Colors.white,
      //           ),
      //           GButton(
      //             icon: Icons.work,
      //             text: "Jobs",
      //             iconColor: Colors.white,
      //           ),
      //           homeController.isEmployer == true
      //               ? GButton(
      //                   icon: Icons.video_call,
      //                   text: "Video Call",
      //                   iconColor: Colors.white,
      //                 )
      //               : GButton(
      //                   icon: Icons.location_on,
      //                   text: "Maps",
      //                   iconColor: Colors.white,
      //                 ),
      //         ],
      //         selectedIndex: _selectedIndex,
      //         onTabChange: (index) {
      //           setState(() {
      //             _selectedIndex = index;
      //           });
      //         },
      //       ),
      //     ),
      //   ),
      // ),
    );
  }
}
