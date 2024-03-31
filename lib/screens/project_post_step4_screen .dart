import 'package:carea/commons/constants.dart';
import 'package:carea/commons/images.dart';
import 'package:carea/commons/widgets.dart';
import 'package:carea/main.dart';
import 'package:carea/screens/registration_screen.dart';
import 'package:carea/screens/wish_list_screen.dart';
import 'package:carea/screens/zoom_image_screen.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../commons/colors.dart';

class ProjectPostStep4Screen extends StatefulWidget {
  // ProjectPostStep4Screen({Key? key, required this.image}) : super(key: key);
  const ProjectPostStep4Screen({super.key});
  // String image = "";

  @override
  State<ProjectPostStep4Screen> createState() => _ProjectPostStep4ScreenState();
}

class _ProjectPostStep4ScreenState extends State<ProjectPostStep4Screen> {
  TabController? tabController;
  PageController pageController = PageController(viewportFraction: 1);

  List carname = [
    "Mercedes",
    "Tesla",
    "BMW",
    "Honda",
    "Toyata",
    "Volvo",
    "Bugatti",
    "More"
  ];

  List<String> carList = [
    car1,
    car2,
    car3,
    car4,
    car5,
    car6,
    car7,
    car8,
    car9,
    car10,
    car11,
    car12,
    car13
  ];

  String? imageaddr;

  @override
  void didChangeDependencies() {
    tabController;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        FocusScope.of(context).unfocus();
        return true;
      },
      child: Scaffold(
        appBar: careaAppBarWidget(
          context,
          titleText: "Project post",
          actionWidget: IconButton(
              onPressed: () {},
              icon: Icon(Icons.person, color: context.iconColor)),
        ),
        body: SingleChildScrollView(
          child: Container(
            color: context.scaffoldBackgroundColor,
            padding: EdgeInsets.only(bottom: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // SizedBox(
                //   width: MediaQuery.of(context).size.width,
                //   height: MediaQuery.of(context).size.width * 0.65,
                //   child: PageView.builder(
                //     controller: pageController,
                //     itemCount: carname.length,
                //     itemBuilder: (context, index) => Container(
                //       width: MediaQuery.of(context).size.width,
                //       height: MediaQuery.of(context).size.width * 0.55,
                //       padding: EdgeInsets.all(20),
                //       margin: EdgeInsets.all(5),
                //       alignment: Alignment.center,
                //       child: Image.asset(
                //           (widget.image.isNotEmpty)
                //               ? widget.image
                //               : ListOfCarImg[0],
                //           alignment: Alignment.topCenter),
                //     ),
                //   ),
                // ),

                // Align(
                //   alignment: Alignment.bottomCenter,
                //   child: SmoothPageIndicator(
                //     controller: pageController,
                //     count: 3,
                //     effect: CustomizableEffect(
                //       activeDotDecoration: DotDecoration(
                //         height: 8,
                //         width: 8,
                //         color:
                //             appStore.isDarkModeOn ? white : primaryBlackColor,
                //         borderRadius: BorderRadius.circular(40),
                //       ),
                //       dotDecoration: DotDecoration(
                //         height: 8,
                //         width: 8,
                //         color: Colors.grey,
                //         borderRadius: BorderRadius.circular(40),
                //       ),
                //     ),
                //   ),
                // ),
                // SizedBox(height: 15),
                Padding(
                    padding: EdgeInsets.only(left: 16),
                    child:
                        Text("ItViec Project", style: boldTextStyle(size: 20))),
                SizedBox(height: 15),
                Padding(
                  padding: EdgeInsets.only(left: 16),
                  child: Row(
                    children: [
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                        decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(6)),
                        child: Text("3 days ago",
                            style:
                                TextStyle(color: Colors.black, fontSize: 12)),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.star_half_rounded, color: context.iconColor),
                      SizedBox(width: 8),
                      Text('4.9 (86 reviews)', style: secondaryTextStyle()),
                      SizedBox(width: 8),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                Padding(
                  padding: EdgeInsets.only(left: 16),
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: Text("Students are looking for",
                          style: boldTextStyle())),
                ),
                SizedBox(height: 10),
                Text.rich(
                  TextSpan(
                    style: secondaryTextStyle(),
                    text:
                        "  - Clear expectation about your project and deliverables\n"
                        "  - The skills required for your project\n"
                        "  - Detail about your project",
                    // children: [
                    //   TextSpan(
                    //       text: ' view more ...', style: primaryTextStyle()),
                    // ],
                  ),
                ).paddingOnly(right: 16, left: 16),
                SizedBox(height: 25),
                Padding(
                  padding: EdgeInsets.only(left: 16),
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: Text("Extra Information", style: boldTextStyle())),
                ),
                SizedBox(height: 5),

                ListTile(
                  contentPadding: EdgeInsets.only(left: 16),
                  leading: Icon(Icons.alarm_rounded, size: 30),
                  title: Text("Project Scope", style: boldTextStyle()),
                  subtitle: Text(
                    "3 to 6 months",
                    style: secondaryTextStyle(),
                  ),
                ),
                ListTile(
                  contentPadding: EdgeInsets.only(left: 16),
                  leading: Icon(Icons.people, size: 30),
                  title: Text("Student required", style: boldTextStyle()),
                  subtitle: Text(
                    "6 students",
                    style: secondaryTextStyle(),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.width * 0.015),

                Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      new Expanded(
                        flex: 1,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegistrationScreen()),
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 12),
                            // width: MediaQuery.of(context).size.width * 0.4,
                            // margin: EdgeInsets.all(8),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: appStore.isDarkModeOn
                                  ? cardDarkColor
                                  : Colors.black,
                              borderRadius: BorderRadius.circular(35),
                            ),
                            child: Text('Post job',
                                style: boldTextStyle(color: white)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
