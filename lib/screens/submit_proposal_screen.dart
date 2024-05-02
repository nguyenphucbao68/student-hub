import 'dart:convert';
import 'dart:io';

import 'package:carea/commons/AppTheme.dart';
import 'package:carea/commons/colors.dart';
import 'package:carea/commons/constants.dart';
import 'package:carea/commons/widgets.dart';
import 'package:carea/constants/app_constants.dart';
import 'package:carea/main.dart';
import 'package:carea/model/project.dart';
import 'package:carea/model/user_info.dart';
import 'package:carea/screens/dashboard_screen.dart';
import 'package:carea/store/authprovider.dart';
import 'package:carea/store/profile_ob.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:http/http.dart' as http;
import 'package:carea/screens/project_post_step2_screen.dart';
import 'package:provider/provider.dart';

class SubmitProposalScreen extends StatefulWidget {
  SubmitProposalScreen(
      {Key? key, this.isAppbarNeeded, this.appBar, this.project})
      : super(key: key);
  bool? isAppbarNeeded;
  final PreferredSizeWidget? appBar;
  final Project? project;

  @override
  State<SubmitProposalScreen> createState() => _SubmitProposalScreenState();
}

class _SubmitProposalScreenState extends State<SubmitProposalScreen> {
  late AuthProvider authStore;

  final _formKey = GlobalKey<FormState>();
  XFile? pickedFile;
  late ProfileOb profi;
  UserInfo? _userInfo;
  String? imagePath;
  String? UserImage;
  String dropdownValue = 'Male';

  TextEditingController coverLetterController = TextEditingController();

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
  void didChangeDependencies() {
    super.didChangeDependencies();
    authStore = Provider.of<AuthProvider>(context);
  }

  Future<void> submitProposal() async {
    log(jsonEncode(<String, String>{
      'projectId': widget.project?.id.toString() ?? "",
      'studentId': profi.user?.student?.id.toString() ?? "",
      'coverLetter': coverLetterController.text,
    }));

    // Navigator.pushNamed(context, "home", arguments: {
    //   'defaultPage': 1,
    // });

    await http
        .post(
      Uri.parse(AppConstants.BASE_URL + '/proposal'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ' + authStore.token.toString(),
      },
      body: jsonEncode(<String, String>{
        'projectId': widget.project?.id.toString() ?? "",
        'studentId': profi.user?.student?.id.toString() ?? "",
        'coverLetter': coverLetterController.text,
      }),
    )
        .then((response) {
      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Submit proposal successfully"),
          ),
        );
        // Navigator.pushNamed(context, "home");
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => HomeScreen(defaultPage: 1)));
      } else {
        // If the server returns an error response, then throw an exception.
        // throw Exception('Failed to login');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Invalid password"),
          ),
        );
      }
    }).catchError((error) {
      log('Failed to login' + error.toString());
      // show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to login'),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    profi = Provider.of<ProfileOb>(context);

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
          titleText: "Submit a Proposal",
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
                    child: Text("Cover Letter", style: boldTextStyle(size: 18)),
                  ),
                  SizedBox(height: 25),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                        "Describe why you are the best candidate for this project",
                        style: primaryTextStyle()),
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    controller: coverLetterController,
                    focusNode: f1,
                    // multilines
                    maxLines: 5,
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
                    decoration: inputDecoration(
                      context,
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: customButton(
                            txt: 'Cancel',
                            wid: 120,
                            high: 50,
                            textSize: 16,
                            // color grey
                            color: Colors.grey.shade200,
                            txtcolor: Colors.black,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ProjectPostStep2Screen()),
                              );
                            },
                          )),
                      10.width,
                      Expanded(
                          flex: 1,
                          child: customButton(
                            txt: 'Submit a proposal',
                            wid: 120,
                            high: 50,
                            textSize: 16,
                            onTap: () {
                              // log(widget.project?.title ?? "No title");
                              submitProposal();
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //       builder: (context) =>
                              //           ProjectPostStep2Screen()),
                              // );
                            },
                          ))
                    ],
                  )
                  // GestureDetector(
                  //   onTap: () {
                  //     if (_formKey.currentState!.validate()) {
                  //       Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //             builder: (context) => ProjectPostStep2Screen()),
                  //       );
                  //     }
                  //   },
                  //   child: Container(
                  //     alignment: Alignment.center,
                  //     padding: EdgeInsets.symmetric(vertical: 16),
                  //     decoration: BoxDecoration(
                  //       color: appStore.isDarkModeOn
                  //           ? cardDarkColor
                  //           : Colors.black,
                  //       borderRadius: BorderRadius.circular(45),
                  //     ),
                  //     child: Text('Next Scope',
                  //         style: boldTextStyle(color: white)),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
