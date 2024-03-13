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

import 'create_pin_screen.dart';

class ProfileInputAhaaScreen extends StatefulWidget {
  ProfileInputAhaaScreen({Key? key, this.isAppbarNeeded, this.appBar})
      : super(key: key);
  bool? isAppbarNeeded;
  final PreferredSizeWidget? appBar;

  @override
  State<ProfileInputAhaaScreen> createState() => _ProfileInputAhaaScreenState();
}

class _ProfileInputAhaaScreenState extends State<ProfileInputAhaaScreen> {
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
      },
      child: Scaffold(
        appBar: careaAppBarWidget(
          context,
          titleText: "Student Hub",
          actionWidget: IconButton(
              onPressed: () {},
              icon: Icon(Icons.search, color: context.iconColor)),
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
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Observer(
                        builder: (context) => GestureDetector(
                          onTap: () async {
                            if (UserImage != null) {
                              imagePath = UserImage;
                            }
                            try {
                              await pr_ob.pickImage();
                              imagePath = pr_ob.pickedFile!.path;
                            } catch (e) {
                              print(e);
                            }
                          },
                          child: (pr_ob.pickedFile != null)
                              ? Image.file(
                                  File(pr_ob.pickedFile!.path),
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ).cornerRadiusWithClipRRect(60)
                              : Image.asset(
                                  "assets/userImage.jpg",
                                  fit: BoxFit.cover,
                                  height: 100,
                                  width: 100,
                                ).cornerRadiusWithClipRRect(60),
                        ),
                      ),
                      Positioned(
                        right: 0,
                        bottom: 8,
                        child: GestureDetector(
                          onTap: () async {
                            if (UserImage != null) {
                              imagePath = UserImage;
                            }
                            try {
                              await pr_ob.pickImage();
                              imagePath = pr_ob.pickedFile!.path;
                            } catch (e) {
                              print(e);
                            }
                          },
                          child: Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Colors.black,
                              border: Border.all(
                                  color: Colors.black.withOpacity(0.3)),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(Icons.edit, color: white, size: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  Text(
                    'Welcome to Student Hub',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 25),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text("Company name",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15)),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: companyNameController,
                    focusNode: f1,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter company name';
                      }
                      return null;
                    },
                    onFieldSubmitted: (v) {
                      f1.unfocus();
                      FocusScope.of(context).requestFocus(f2);
                    },
                    decoration:
                        inputDecoration(context, hintText: "Company name"),
                  ),
                  SizedBox(height: 15),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text("Website",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15)),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: websiteController,
                    focusNode: f2,
                    onFieldSubmitted: (v) {
                      f2.unfocus();
                      FocusScope.of(context).requestFocus(f3);
                    },
                    decoration: inputDecoration(context, hintText: "Website"),
                  ),
                  SizedBox(height: 15),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text("Description",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15)),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: descriptionController,
                    focusNode: f3,
                    minLines: 3,
                    maxLines: 3,
                    onFieldSubmitted: (v) {
                      f3.unfocus();
                      FocusScope.of(context).requestFocus(f3);
                    },
                    decoration:
                        inputDecoration(context, hintText: "Description"),
                  ),
                  SizedBox(height: 15),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text("How many people are in your company?",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15)),
                  ),
                  SizedBox(height: 10),
                  RadioListTile<String>(
                    title: Text(
                      "It's just me",
                      style: TextStyle(fontSize: 14),
                    ),
                    value: "It's just me",
                    groupValue: selectedOption,
                    onChanged: (value) {
                      setState(() {
                        selectedOption = value;
                      });
                    },
                  ),
                  SizedBox(height: 30),
                  GestureDetector(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CreatePinScreen()),
                        );
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        color: appStore.isDarkModeOn
                            ? cardDarkColor
                            : Colors.white,
                        borderRadius: BorderRadius.circular(45),
                        border: Border.all(
                          color: Colors.black,
                          width: 2,
                        ),
                      ),
                      child: Text('Edit', style: boldTextStyle(color: black)),
                    ),
                  ),
                  SizedBox(height: 8),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
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
                      child: Text('Cancel', style: boldTextStyle(color: white)),
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
