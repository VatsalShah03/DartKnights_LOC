import 'package:dart_knights/models/previous_jobs.dart';
import 'package:dart_knights/views/profile/widgets.dart';
import 'package:flutter/material.dart';

class ProfilePreviousJobs extends StatefulWidget {
  const ProfilePreviousJobs({super.key});

  @override
  State<ProfilePreviousJobs> createState() => _ProfilePreviousJobsState();
}

class _ProfilePreviousJobsState extends State<ProfilePreviousJobs> {
  List<PreviousJobs> previousJobsList = [
    PreviousJobs(
        companyName: "Facebook",
        companyLogo: "assets/f-logo.png",
        position: "React Native Developer",
        description: "Made Facebook, Instagram, Whatsapp from Scratch"),
    PreviousJobs(
        companyName: "Google",
        companyLogo: "assets/images.png",
        position: "React Native Developer",
        description: "Made Facebook, Instagram, Whatsapp from Scratch"),
    PreviousJobs(
        companyName: "Facebook",
        companyLogo: "assets/f-logo.png",
        position: "React Native Developer",
        description: "Made Facebook, Instagram, Whatsapp from Scratch"),
  ];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      //shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: previousJobsList.length,
      itemBuilder: (context, index) {
        return PreviousJobsWidget(
          previousJobs: previousJobsList[index],
        );
      },
    );
  }
}
