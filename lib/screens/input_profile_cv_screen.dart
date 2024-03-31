import 'package:carea/commons/widgets.dart';
import 'package:carea/components/upload_file.dart';
import 'package:carea/screens/dashboard_screen.dart';
import 'package:carea/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:carea/main.dart';

class InputProfileCVScreen extends StatefulWidget {
  const InputProfileCVScreen({super.key});

  @override
  State<InputProfileCVScreen> createState() => _InputProfileCVScreenState();
}

class _InputProfileCVScreenState extends State<InputProfileCVScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBarWidget(
        context,
      ),
      body: Container(
          padding: EdgeInsets.all(20),
          height: context.height(),
          color:
              appStore.isDarkModeOn ? scaffoldDarkColor : gray.withOpacity(0.1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Column(
                  children: [
                    Text(
                      "CV & Transcript",
                      style: boldTextStyle(size: 18),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Tell us about your self and you will be on your way connect with real-world project",
                      style: primaryTextStyle(size: 14),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Resume/CV (*)",
                        style: boldTextStyle(size: 14),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    UploadFile(onTapOverride: () {}),
                    SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Transcript (*)",
                        style: boldTextStyle(size: 14),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    UploadFile(onTapOverride: () {}),
                    SizedBox(
                      height: 100,
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //       builder: (context) => RegistrationScreen()),
                  // );
                  HomeScreen().launch(context, isNewTask: true);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  // width: MediaQuery.of(context).size.width * 0.4,
                  // margin: EdgeInsets.all(8),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: appStore.isDarkModeOn ? cardDarkColor : Colors.black,
                    borderRadius: BorderRadius.circular(35),
                  ),
                  child: Text('Next', style: boldTextStyle(color: white)),
                ),
              )
            ],
          )),
    );
  }
}
