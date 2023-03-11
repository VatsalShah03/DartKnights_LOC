import 'package:dart_knights/constants.dart';
import 'package:flutter/material.dart';

class ProfileInfoWidget extends StatefulWidget {
  const ProfileInfoWidget(
      {super.key,
      required this.name,
      required this.qualification,
      required this.education,
      required this.address,
      required this.email});
  final String email;
  final String name;
  final String qualification;
  final String education;
  final String address;

  @override
  State<ProfileInfoWidget> createState() => _ProfileInfoWidgetState();
}

class _ProfileInfoWidgetState extends State<ProfileInfoWidget> {
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
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => const EditProfile(),
                    //   ),
                    // );
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
              Expanded(
                child: Text(
                  widget.email,
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
              Expanded(
                child: Text(
                  "The Entrepreneurship Cell (E-Cell) of St. Xavier's College is an organization that aims to promote and support entrepreneurship among the students of the college.",
                  style: TextStyle(fontSize: height * 0.014),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 32,
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
                "linktr.ee/ecell.xaviers",
                style: TextStyle(color: Colors.blue),
              )
            ],
          ),
          const SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
}
