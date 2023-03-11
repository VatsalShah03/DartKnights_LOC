import 'package:dart_knights/constants.dart';
import 'package:dart_knights/views/profile/club_info_announcements.dart';
import 'package:dart_knights/views/profile/profile_info_widget.dart';
import 'package:dart_knights/views/profile/profile_controller.dart';
import 'package:dart_knights/views/profile/profile_posts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileMain extends StatefulWidget {
  const ProfileMain({super.key, required this.uid});
  final String uid;
  @override
  State<ProfileMain> createState() => _ProfileMainState();
}

class _ProfileMainState extends State<ProfileMain>
    with SingleTickerProviderStateMixin {
  ScrollController scrollController = ScrollController();
  late TabController _controller;
  ProfileController profileController = Get.put(ProfileController());
  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, initialIndex: 0, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return FutureBuilder(
        future: profileController.getUserDetails(widget.uid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Scaffold(
              appBar: AppBar(
                elevation: 0,
                title: Text(
                  profileController.name!,
                  style: TextStyle(color: Colors.black),
                ),
                backgroundColor: Colors.white,
                leading: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    )),
              ),
              body: NestedScrollView(
                physics: const NeverScrollableScrollPhysics(),
                headerSliverBuilder: (context, isScrolled) {
                  return [
                    SliverAppBar(
                        leading: const SizedBox(),
                        backgroundColor: Colors.white,
                        collapsedHeight: height * 0.52,
                        expandedHeight: height * 0.52,
                        flexibleSpace: ProfileInfoWidget(
                          address: 'Sample Address',
                          name: profileController.name!,
                          email: profileController.email!,
                          education: "zcxzdcdsffsdz",
                          qualification: "zxczsdsdzc",
                        )),
                    SliverPersistentHeader(
                      delegate: MyDelegate(
                        TabBar(
                            labelColor: ResourceColors.secondaryColor,
                            unselectedLabelColor: Colors.black,
                            labelStyle: TextStyle(fontSize: height * 0.020),
                            indicator: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: ResourceColors.primaryColor,
                                  width: 3.0,
                                ),
                              ),
                            ),
                            controller: _controller,
                            tabs: [
                              Tab(
                                text: "Posts",
                              ),
                              Tab(
                                text: "Previous Jobs",
                              ),
                            ]),
                      ),
                      floating: true,
                      pinned: true,
                    )
                  ];
                },
                body: TabBarView(
                    controller: _controller,
                    children: const [ProfilePosts(), ProfilePreviousJobs()]),
              ));
        });
  }
}

class MyDelegate extends SliverPersistentHeaderDelegate {
  MyDelegate(this.tabBar);
  final TabBar tabBar;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      child: tabBar,
    );
  }

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
