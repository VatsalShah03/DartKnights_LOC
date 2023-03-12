import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants.dart';

class MentalHealth extends StatefulWidget {
  const MentalHealth({Key? key}) : super(key: key);

  @override
  State<MentalHealth> createState() => _MentalHealthState();
}

class _MentalHealthState extends State<MentalHealth> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
                title: Text("For your Mental Wellbeing."),
                backgroundColor: ResourceColors.primaryColor),
            body: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  MentalHealthCards(
                    text1: "Do you feel stressed due to unemployment?",
                    text2: "Allow us to present to you resources to help.",
                    text3: "https://mhfaindia.com/mhfa-workplaces",
                  ),
                  MentalHealthCards(
                    text1:
                        "Riddled with anxiety and dread at your current job?",
                    text2:
                        "Yes, it's completely normal to dread going to work.",
                    text3:
                        "https://www.workitdaily.com/dread-going-to-work#:~:text=Is%20It%20Normal%20To%20Dread,look%20for%20a%20new%20job.",
                  ),
                  MentalHealthCards(
                    text1: "In need of serious financial help?",
                    text2: "Connect with NGOs for aid.",
                    text3:
                        "https://prsindia.org/theprsblog/the-insolvency-and-bankruptcy-code-all-you-need-to-know?page=328&per-page=1",
                  ),
                  MentalHealthCards(
                    text1: "Eager to start a business, but don't know how?",
                    text2: "Let us get you pff the blocks and running.",
                    text3:
                        "https://www.businessnewsdaily.com/4686-how-to-start-a-business.html",
                  ),
                ],
              ),
            )));
  }
}

class MentalHealthCards extends StatelessWidget {
  String? text1, text2, text3;

  MentalHealthCards(
      {Key? key, required this.text1, required this.text2, required this.text3})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsetsDirectional.fromSTEB(16, 15, 16, 12),
        child: Container(
          width: double.infinity,
          constraints: BoxConstraints(
            maxWidth: 570,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                blurRadius: 3,
                color: Color(0x33000000),
                offset: Offset(0, 1),
              )
            ],
            borderRadius: BorderRadius.circular(12),
          ),
          padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 4),
                child: Text(
                  text1!,
                  style: TextStyle(
                    color: Color(0xFF101213),
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 8),
                child: Text(
                  text2!,
                  style: TextStyle(
                    color: Color(0xFF57636C),
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(80, 0, 16, 0),
                    child: Container(
                      height: 32,
                      decoration: BoxDecoration(
                        color: ResourceColors.tertiaryColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      alignment: AlignmentDirectional(0, 0),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                        child: InkWell(
                          child: Text(
                            "Click to know more.",
                            style: TextStyle(
                              fontFamily: 'Outfit',
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          onTap: () {
                            var text = Uri.parse(text3!);
                            launchUrl(text);
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
