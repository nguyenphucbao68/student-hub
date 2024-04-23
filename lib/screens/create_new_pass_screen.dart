import 'dart:convert';

import 'package:carea/commons/app_component.dart';
import 'package:carea/commons/colors.dart';
import 'package:carea/commons/widgets.dart';
import 'package:carea/constants/app_constants.dart';
import 'package:carea/main.dart';
import 'package:carea/screens/dashboard_screen.dart';
import 'package:carea/store/authprovider.dart';
import 'package:carea/store/user_signup.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../commons/images.dart';

class CreateNewPassScreen extends StatefulWidget {
  const CreateNewPassScreen({Key? key}) : super(key: key);

  @override
  State<CreateNewPassScreen> createState() => _CreateNewPassScreenState();
}

class _CreateNewPassScreenState extends State<CreateNewPassScreen> {
  late AuthProvider authStore;

  TextEditingController t1 = TextEditingController();
  TextEditingController t2 = TextEditingController();

  FocusNode f1 = FocusNode();
  FocusNode f2 = FocusNode();

  final _form_state_key = GlobalKey<FormState>();

  bool isIconCheck1 = false;
  bool isIconCheck2 = false;

  late double width;
  late double height;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    authStore = Provider.of<AuthProvider>(context);

    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
  }

  Future<void> changePassword() async {
    await http
        .put(
      Uri.parse(AppConstants.BASE_URL + '/user/changePassword'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ' + authStore.token.toString(),
      },
      body: jsonEncode(<String, String>{
        'oldPassword': t1.text,
        'newPassword': t2.text,
      }),
    )
        .then((response) {
      log(response.body);
      if (response.statusCode == 200) {
        customDialoge(context);
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
    return WillPopScope(
      onWillPop: () async {
        FocusScope.of(context).unfocus();
        return true;
      },
      child: Scaffold(
        appBar: careaAppBarWidget(context, titleText: "Create New password"),
        body: SingleChildScrollView(
          dragStartBehavior: DragStartBehavior.start,
          child: Container(
            height: height,
            alignment: Alignment.topCenter,
            padding: EdgeInsets.all(16),
            child: Form(
              key: _form_state_key,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(createpassimg,
                          color: context.iconColor,
                          fit: BoxFit.cover,
                          width: 170,
                          height: 170)
                      .center(),
                  SizedBox(height: 40),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text("Create Your New Password",
                        style: primaryTextStyle()),
                  ),
                  SizedBox(height: 25),
                  Observer(
                    builder: (context) => TextFormField(
                      obscureText: isIconCheck2,
                      focusNode: f1,
                      controller: t1,
                      validator: (value) {
                        return Validate.validate(value!);
                      },
                      onFieldSubmitted: (v) {
                        f1.unfocus();
                        FocusScope.of(context).requestFocus(f2);
                      },
                      decoration: InputDecoration(
                        hintText: 'Enter old password',
                        filled: true,
                        fillColor: appStore.isDarkModeOn
                            ? cardDarkColor
                            : editTextBgColor,
                        border: InputBorder.none,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: radius(defaultRadius),
                          borderSide:
                              BorderSide(color: Colors.transparent, width: 0.0),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: radius(defaultRadius),
                          borderSide: BorderSide(color: Colors.red, width: 0.0),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: radius(defaultRadius),
                          borderSide: BorderSide(color: Colors.red, width: 1.0),
                        ),
                        errorMaxLines: 2,
                        errorStyle:
                            primaryTextStyle(color: Colors.red, size: 12),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: radius(defaultRadius),
                          borderSide:
                              BorderSide(color: Colors.transparent, width: 0.0),
                        ),
                        prefixIcon: Icon(Icons.lock,
                            color: context.iconColor, size: 22),
                        suffixIcon: Theme(
                          data: ThemeData(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                          ),
                          child: IconButton(
                            highlightColor: Colors.transparent,
                            color: context.iconColor,
                            onPressed: () {
                              setState(() {
                                isIconCheck2 = !isIconCheck2;
                              });
                            },
                            icon: Icon(
                                size: 18,
                                (isIconCheck2)
                                    ? Icons.visibility_rounded
                                    : Icons.visibility_off),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Observer(
                    builder: (context) => TextFormField(
                      controller: t2,
                      focusNode: f2,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Enter The Password';
                        } else if (value.length > 16) {
                          return 'password must be less than 16 digit';
                        } else if (value.length < 8) {
                          return 'password must more than 8 digit';
                        }
                        return null;
                      },
                      onFieldSubmitted: (v) {
                        f2.unfocus();
                        if (_form_state_key.currentState!.validate()) {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) => HomeScreen()),
                          // );
                        }
                      },
                      obscureText: !isIconCheck1,
                      decoration: InputDecoration(
                        hintText: 'Enter new Password',
                        filled: true,
                        fillColor: appStore.isDarkModeOn
                            ? cardDarkColor
                            : editTextBgColor,
                        border: InputBorder.none,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: radius(defaultRadius),
                          borderSide:
                              BorderSide(color: Colors.transparent, width: 0.0),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: radius(defaultRadius),
                          borderSide: BorderSide(color: Colors.red, width: 0.0),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: radius(defaultRadius),
                          borderSide: BorderSide(color: Colors.red, width: 1.0),
                        ),
                        errorMaxLines: 2,
                        errorStyle:
                            primaryTextStyle(color: Colors.red, size: 12),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: radius(defaultRadius),
                          borderSide:
                              BorderSide(color: Colors.transparent, width: 0.0),
                        ),
                        prefixIcon: Icon(Icons.lock,
                            color: context.iconColor, size: 22),
                        suffixIcon: Theme(
                          data: ThemeData(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                          ),
                          child: IconButton(
                            highlightColor: Colors.transparent,
                            color: context.iconColor,
                            onPressed: () {
                              setState(
                                () {
                                  isIconCheck1 = !isIconCheck1;
                                },
                              );
                            },
                            icon: Icon(
                                (isIconCheck1)
                                    ? Icons.visibility_rounded
                                    : Icons.visibility_off,
                                size: 18),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 25),
                  SizedBox(height: 40),
                  GestureDetector(
                    child: Container(
                      width: width,
                      padding: EdgeInsets.symmetric(vertical: 16),
                      alignment: Alignment.center,
                      decoration: CircularBlackDecoration,
                      child: Text("Continue",
                          style: boldTextStyle(color: primaryWhiteColor)),
                    ),
                    onTap: () async {
                      if (_form_state_key.currentState!.validate()) {
                        // await customDialoge(context);
                        changePassword();
                      }
                    },
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
