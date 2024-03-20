import 'dart:io';

import 'package:carea/commons/AppTheme.dart';
import 'package:carea/commons/colors.dart';
import 'package:carea/commons/constants.dart';
import 'package:carea/commons/widgets.dart';
import 'package:carea/main.dart';
import 'package:carea/model/user_info.dart';
import 'package:carea/store/profile_ob.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nb_utils/nb_utils.dart';

import 'package:carea/screens/project_post_step2_screen.dart';

class ProjectPostStep1Screen extends StatefulWidget {
  ProjectPostStep1Screen({Key? key, this.isAppbarNeeded, this.appBar})
      : super(key: key);
  bool? isAppbarNeeded;
  final PreferredSizeWidget? appBar;

  @override
  State<ProjectPostStep1Screen> createState() => _ProjectPostStep1ScreenState();
}

class _ProjectPostStep1ScreenState extends State<ProjectPostStep1Screen> {
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
                    child: Text("1/4  Let's start with a strong title",
                        style: boldTextStyle(size: 18)),
                  ),
                  SizedBox(height: 25),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                        "This helps your post stand out to the right students. It's the first thing they'll see, so make it impressive!",
                        style: primaryTextStyle()),
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    controller: companyNameController,
                    focusNode: f1,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your post title';
                      }
                      return null;
                    },
                    onFieldSubmitted: (v) {
                      f1.unfocus();
                      FocusScope.of(context).requestFocus(f2);
                    },
                    decoration: inputDecoration(context,
                        hintText: "Write a title for your post"),
                  ),
                  SizedBox(height: 20),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text("Example titles",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15)),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(width: 10),
                      Text("-", style: TextStyle(fontSize: 15)),
                      SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                "Build responsive WordPress site with booking/payment functionality",
                                style: TextStyle(fontSize: 15)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(width: 10),
                      Text("-", style: TextStyle(fontSize: 15)),
                      SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                "Facebook ad specialist need for product launch",
                                style: TextStyle(fontSize: 15)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProjectPostStep2Screen()),
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
                      child: Text('Next Scope',
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
