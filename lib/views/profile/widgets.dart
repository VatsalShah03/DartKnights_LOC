import 'package:dart_knights/models/previous_jobs.dart';
import 'package:flutter/material.dart';

import 'package:readmore/readmore.dart';

class EventsWidget extends StatefulWidget {
  const EventsWidget({
    Key? key,
    required this.imgUrl,
    required this.message,
  }) : super(key: key);
  final String imgUrl;
  final String message;

  @override
  State<EventsWidget> createState() => _EventsWidgetState();
}

class _EventsWidgetState extends State<EventsWidget> {
  String isVegetarian = '';

  var isLiked = false;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {},
      child: Card(
        margin: const EdgeInsets.all(12),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(
                    widget.imgUrl,
                    height: width * 0.35,
                    width: width * 0.35,
                    fit: BoxFit.cover,
                  )),
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.message,
                  style:
                      TextStyle(fontSize: height * 0.017, color: Colors.black),
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }
}

class PreviousJobsWidget extends StatelessWidget {
  const PreviousJobsWidget({super.key, required this.previousJobs});
  final PreviousJobs previousJobs;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, right: 8, left: 8),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Column(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Container(
                        height: 65,
                        width: 65,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.contain,
                            image: AssetImage(
                              previousJobs.companyLogo,
                            ),
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                previousJobs.companyName,
                                style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.black),
                              ),
                              const SizedBox(height: 5.0),
                              Text(
                                previousJobs.position,
                                style: TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black),
                              )
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ReadMoreText(
                previousJobs.description,
                textAlign: TextAlign.justify,
                trimLines: 1,
                colorClickableText: const Color.fromARGB(255, 231, 200, 154),
                trimMode: TrimMode.Line,
                trimCollapsedText: ' Show more',
                trimExpandedText: ' Show less',
                style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text("Sat Nov 26 2022 | 5:07 P.M.",
                    style: TextStyle(
                        fontSize: 8.0,
                        fontWeight: FontWeight.w400,
                        color: Colors.black)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
