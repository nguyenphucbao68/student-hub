import 'package:carea/screens/login_with_pass_screen.dart';
import 'package:carea/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../commons/app_component.dart';
import '../commons/images.dart';
import '../main.dart';

class WalkThroughScreen extends StatefulWidget {
  const WalkThroughScreen({Key? key}) : super(key: key);

  @override
  State<WalkThroughScreen> createState() => _WalkThroughScreenState();
}

class _WalkThroughScreenState extends State<WalkThroughScreen>
    with SingleTickerProviderStateMixin {
  PageController pageController = PageController();
  int currentPage = 0;
  List<WalkThroughModelClass> list = [];

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    list.add(WalkThroughModelClass(
        title:
            'A comprehensive app facilitates connections between students and companies',
        image: student_gif));
    list.add(WalkThroughModelClass(
        title: 'Students can seek real-world projects', image: students_gif));
    list.add(WalkThroughModelClass(
        title: 'Companies can search for talents to develop their MVP',
        image: company_gif));
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.topRight,
        children: [
          PageView(
            controller: pageController,
            children: list.map((e) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(e.image.validate()),
                  SizedBox(height: 20),
                  Text(e.title.validate(),
                      style: boldTextStyle(size: 20),
                      textAlign: TextAlign.center),
                ],
              );
            }).toList(),
          ),
          Positioned(
            top: 24,
            child: TextButton(
              onPressed: () {
                RegistrationScreen().launch(context, isNewTask: true);
              },
              child: Text('Skip', style: primaryTextStyle()),
            ),
          ),
          Positioned(
            bottom: 130,
            right: 0,
            left: 0,
            child: DotIndicator(
              indicatorColor: appStore.isDarkModeOn ? white : Colors.black,
              pageController: pageController,
              pages: list,
              currentDotSize: 24,
              boxShape: BoxShape.circle,
              currentDotWidth: 60,
              currentBoxShape: BoxShape.rectangle,
              unselectedIndicatorColor: Colors.grey.shade400,
              onPageChanged: (index) {
                setState(
                  () {
                    currentPage = index;
                  },
                );
              },
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 32,
            child: GestureDetector(
              onTap: () {
                if (currentPage == 2) {
                  LoginWithPassScreen().launch(context, isNewTask: true);
                } else {
                  pageController.animateToPage(
                    currentPage + 1,
                    duration: Duration(milliseconds: 300),
                    curve: Curves.linear,
                  );
                }
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: 24),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                decoration: CircularBlackDecoration,
                child: Text("Get Started", style: boldTextStyle(color: white)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
