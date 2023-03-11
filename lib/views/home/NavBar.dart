import 'package:dart_knights/constants.dart';
import 'package:dart_knights/views/home/Post.dart';
import 'package:dart_knights/views/home/drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'Home.dart';
import 'Jobs.dart';
import 'Maps.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.w600);
  static List<Widget> _widgetOptions = <Widget>[
    Home(),
    Post(),
    Jobs(),
    Maps(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
          //leading: IconButton(icon: Icons.menu, onPressed: (){Scaffold.},),
          backgroundColor: ResourceColors.primaryColor,
          actions: [
            IconButton(onPressed: () {}, icon: Icon(Icons.notifications))
          ]),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: ResourceColors.primaryColor,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 8, 15, 8),
            child: GNav(
              rippleColor: Colors.grey[300]!,
              hoverColor: Colors.grey[100]!,
              gap: 8,
              activeColor: ResourceColors.primaryColor,
              iconSize: 24,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: Duration(milliseconds: 400),
              tabBackgroundColor: Colors.grey[100]!,
              //color: Colors.black,
              tabs: [
                GButton(
                  icon: Icons.home_filled,
                  text: 'Home',
                  iconColor: Colors.white,
                ),
                GButton(
                  icon: Icons.add_box,
                  text: "Post",
                  iconColor: Colors.white,
                ),
                GButton(
                  icon: Icons.work,
                  text: "Jobs",
                  iconColor: Colors.white,
                ),
                GButton(
                  icon: Icons.location_on,
                  text: "Maps",
                  iconColor: Colors.white,
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
