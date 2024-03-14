import 'dart:io';

import 'package:carea/commons/AppTheme.dart';
import 'package:carea/commons/colors.dart';
import 'package:carea/commons/constants.dart';
import 'package:carea/commons/widgets.dart';
import 'package:carea/main.dart';
import 'package:carea/model/user_info.dart';
import 'package:carea/screens/project_post_step3_screen.dart';
import 'package:carea/store/profile_ob.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nb_utils/nb_utils.dart';

import 'create_pin_screen.dart';

class ProjectPostStep2Screen extends StatefulWidget {
  ProjectPostStep2Screen({Key? key, this.isAppbarNeeded, this.appBar})
      : super(key: key);
  bool? isAppbarNeeded;
  final PreferredSizeWidget? appBar;

  @override
  State<ProjectPostStep2Screen> createState() => _ProjectPostStep2ScreenState();
}

class _ProjectPostStep2ScreenState extends State<ProjectPostStep2Screen> {
  final _formKey = GlobalKey<FormState>();
  XFile? pickedFile;
  ProfileOb pr_ob = ProfileOb();
  UserInfo? _userInfo;
  String? imagePath;
  String? UserImage;
  String dropdownValue = 'Male';

  TextEditingController companyNameController = TextEditingController();
  TextEditingController websiteController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  FocusNode f1 = FocusNode();
  FocusNode f2 = FocusNode();
  FocusNode f3 = FocusNode();
  FocusNode f4 = FocusNode();
  FocusNode f5 = FocusNode();
  FocusNode f6 = FocusNode();

  String? selectedOption;

  final List<String> timeList = [
    "1 to 3 months",
    "3 to 6 months",
  ];

  var time = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        FocusScope.of(context).unfocus();
        return true;
        // Navigator.pop(context);
        // return false;
      },
      child: Scaffold(
        appBar: careaAppBarWidget(
          context,
          titleText: "Poject post",
          actionWidget: IconButton(
              onPressed: () {},
              icon: Icon(Icons.person, color: context.iconColor)),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(16),
            alignment: Alignment.center,
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text("2/4  Next, estimate the scope of your job",
                        style: boldTextStyle(size: 18)),
                  ),
                  SizedBox(height: 25),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                        "Consider the size of your project and the timeline",
                        style: primaryTextStyle()),
                  ),
                  SizedBox(height: 15),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text("How long will your project take",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15)),
                  ),
                  SizedBox(height: 15),
                  SizedBox(
                    height: timeList.length * (55 + 10),
                    child: ListView.separated(
                      controller: ScrollController(),
                      itemCount: timeList.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 10),
                      itemBuilder: (context, index) => Container(
                        margin: EdgeInsets.only(bottom: 8),
                        decoration: boxDecorationWithRoundedCorners(
                          borderRadius:
                              BorderRadius.all(Radius.circular(defaultRadius)),
                          backgroundColor: Colors.grey.shade200,
                        ),
                        padding: EdgeInsets.symmetric(vertical: 6),
                        child: RadioListTile(
                          visualDensity: VisualDensity(
                              horizontal: VisualDensity.minimumDensity,
                              vertical: VisualDensity.minimumDensity),
                          title: Row(
                            children: [
                              SizedBox(width: 16),
                              Text(timeList[index], style: primaryTextStyle()),
                            ],
                          ),
                          controlAffinity: ListTileControlAffinity.trailing,
                          value: timeList[index],
                          groupValue: time,
                          activeColor: context.iconColor,
                          hoverColor: Colors.black,
                          onChanged: (value) {
                            setState(() {
                              time = value.toString();
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                        "How many students do you want for this project",
                        style: boldTextStyle(size: 15)),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: companyNameController,
                    focusNode: f1,
                    // validator: (value) {
                    //   if (value!.isEmpty) {
                    //     return 'Please enter your post title';
                    //   }
                    //   return null;
                    // },
                    onFieldSubmitted: (v) {
                      f1.unfocus();
                      FocusScope.of(context).requestFocus(f2);
                    },
                    decoration: inputDecoration(context,
                        hintText: "Number of students"),
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProjectPostStep3Screen()),
                        );
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        color: appStore.isDarkModeOn
                            ? cardDarkColor
                            : Colors.black,
                        borderRadius: BorderRadius.circular(45),
                      ),
                      child: Text('Next Description',
                          style: boldTextStyle(color: white)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
