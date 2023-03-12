import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dart_knights/constants.dart';
import 'package:dart_knights/models/posts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    Stream<List<Posts>> getPosts() {
      return FirebaseFirestore.instance.collection("Posts").snapshots().map(
          (snapshot) =>
              snapshot.docs.map((doc) => Posts.fromMap(doc.data())).toList());
    }

    return Scaffold(
      body: StreamBuilder(
          stream: getPosts(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  Posts post = snapshot.data![index];
                  final PageController _pageController =
                      PageController(viewportFraction: 0.8, keepPage: true);
                  return Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Card(
                      elevation: 5.0,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(12),
                              decoration: const BoxDecoration(
                                  color: ResourceColors.secondaryColor,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(15),
                                      topRight: Radius.circular(15))),
                              child: Row(
                                children: [
                                  const CircleAvatar(
                                    backgroundColor: ResourceColors.slightWhite,
                                    child: Icon(
                                      Icons.person,
                                      color: ResourceColors.tertiaryColor,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        post.UserName,
                                        style: TextStyle(
                                            fontSize: height * 0.017,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white),
                                      ),
                                      // Text(
                                      //   "Position",
                                      //   style: TextStyle(
                                      //       fontSize: height * 0.013,
                                      //       color: Colors.white),
                                      // ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Image.network(
                            post.url,
                            height: width * 0.9,
                            width: double.infinity,
                            fit: BoxFit.fill,
                          ),
                          Divider(
                            color: Colors.black,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ReadMoreText(
                                  post.Description,
                                  textAlign: TextAlign.justify,
                                  trimLines: 1,
                                  colorClickableText: Colors.grey,
                                  trimMode: TrimMode.Line,
                                  trimCollapsedText: ' Show more',
                                  trimExpandedText: ' Show less',
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                });
          }),
    );
  }
}
