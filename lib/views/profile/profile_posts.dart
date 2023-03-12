import 'package:dart_knights/views/profile/widgets.dart';
import 'package:flutter/material.dart';

class ProfilePosts extends StatefulWidget {
  const ProfilePosts({super.key});

  @override
  State<ProfilePosts> createState() => _ProfilePostsState();
}

class _ProfilePostsState extends State<ProfilePosts> {
  List<String> imgUrlList = [
    'assets/images (9).jpg',
    'assets/images (8).jpg',
    'assets/images (10).jpg'
  ];
  List<String> messagesList = [
    "As a direct response copywriter, I specialize in making readers take a specific action. I write a variety of copy, including articles.",
    "t Security Software, we ask a lot of our employees, which is why we give so much in return. In addition to your competitive salary.",
    "As Security Software’s sole Content Marketer, you’ll meet the initiative’s strategic needs on your own, experimenting, learning, and "
  ];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      //shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 3,
      itemBuilder: (context, index) {
        return EventsWidget(
          imgUrl: imgUrlList[index],
          message: messagesList[index],
        );
      },
    );
  }
}
