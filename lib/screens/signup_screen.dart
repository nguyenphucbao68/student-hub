import 'dart:convert';

import 'package:carea/commons/colors.dart';
import 'package:carea/commons/images.dart';
import 'package:carea/commons/widgets.dart';
import 'package:carea/constants/app_constants.dart';
import 'package:carea/main.dart';
import 'package:carea/screens/dashboard_screen.dart';
import 'package:carea/screens/login_with_pass_screen.dart';
import 'package:carea/screens/profile_screen.dart';
import 'package:carea/store/authprovider.dart';
import 'package:carea/store/user_signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  late AuthProvider auth;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  FocusNode focusEmail = FocusNode();
  FocusNode focusName = FocusNode();
  FocusNode focusPassword = FocusNode();

  bool isIconTrue = true;
  bool isLoading = false;

  // declare userSignupStore
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    auth = Provider.of<AuthProvider>(context);
  }

  void _signup() async {
    // if (_formKey.currentState!.validate()) {
    setState(() {
      isLoading = true;
    });
    final email = _emailController.text;
    final password = _passwordController.text;
    final name = _nameController.text;

    log("Email: " + email);
    log("Password: " + password);
    log("Name: " + name);

    // code request api here (restful): http://localhost:4400/auth/sign-in
    await http
        .post(
      Uri.parse(AppConstants.BASE_URL + '/auth/sign-up'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'email': email,
        'password': password,
        'fullname': name,
        'role': auth.authSignUp == UserRole.STUDENT ? 0 : 1,
      }),
    )
        .then((response) {
      log("Res" + response.statusCode.toString());
      if (response.statusCode == 201) {
        // If the server returns an OK response, then parse the JSON.
        var data = jsonDecode(response.body);
        Widget okButton = TextButton(
          child: Text("OK"),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginWithPassScreen()),
            );
          },
        );

        AlertDialog alert = AlertDialog(
          title: Text("Congrats"),
          content: Text(
              "You've successfully signed up. Please check your email to confirm your account before logging in"),
          actions: [
            okButton,
          ],
        );

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return alert;
          },
        );

        // if (auth.authSignUp == UserRole.STUDENT) {
        //   http.post(Uri.parse(AppConstants.BASE_URL + '/profile/student'),
        //       headers: <String, String>{
        //         'Content-Type': 'application/json; charset=UTF-8',
        //       },
        //       body: jsonEncode({
        //         "techStackId": 1
        //       })).then((value) {
        //         log('Student create successfully');
        //       });
        // }

        log("Data" + data.toString());
      } else {
        // If the server returns an error response, then throw an exception.
        // throw Exception('Failed to login');
        log('Failed to login 2');
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
    // }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: careaAppBarWidget(context),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image(
                    height: 100,
                    width: 100,
                    fit: BoxFit.fitWidth,
                    image: AssetImage(student_hub)),
                SizedBox(height: 16),
                Text('Sign up as a ' + userRoleToText[auth.authSignUp]!,
                    style: boldTextStyle(size: 24)),
                SizedBox(height: 20),
                TextFormField(
                  autofocus: true,
                  focusNode: focusName,
                  onFieldSubmitted: (v) {
                    focusName.unfocus();
                    FocusScope.of(context).requestFocus(focusEmail);
                  },
                  controller: _nameController,
                  decoration: inputDecoration(context,
                      prefixIcon: Icons.person, hintText: "Full Name"),
                ),
                SizedBox(height: 20),
                TextFormField(
                  autofocus: false,
                  validator: (value) {
                    if (!value!.contains('@')) {
                      return 'Please enter the correct email';
                    }
                    return null;
                  },
                  focusNode: focusEmail,
                  autofillHints: [AutofillHints.email],
                  onFieldSubmitted: (v) {
                    focusEmail.unfocus();
                    FocusScope.of(context).requestFocus(focusPassword);
                  },
                  controller: _emailController,
                  decoration: inputDecoration(context,
                      prefixIcon: Icons.mail_rounded, hintText: "Email"),
                ),
                SizedBox(height: 20),
                Observer(
                  builder: (context) => TextFormField(
                    autofocus: false,
                    focusNode: focusPassword,
                    controller: _passwordController,
                    obscureText: isIconTrue,
                    validator: (value) {
                      return Validate.validate(value!);
                    },
                    onFieldSubmitted: (v) {
                      focusPassword.unfocus();
                      if (_formKey.currentState!.validate()) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProfileScreen()),
                        );
                      }
                    },
                    decoration: inputDecoration(
                      context,
                      prefixIcon: Icons.lock,
                      hintText: "Password",
                      suffixIcon: Theme(
                        data: ThemeData(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent),
                        child: IconButton(
                          highlightColor: Colors.transparent,
                          onPressed: () {
                            setState(() {
                              isIconTrue = !isIconTrue;
                            });
                          },
                          icon: Icon(
                            (isIconTrue)
                                ? Icons.visibility_rounded
                                : Icons.visibility_off,
                            size: 16,
                            color: appStore.isDarkModeOn ? white : gray,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 5),
                // Check box to agree to terms and conditions
                Row(
                  children: [
                    Checkbox(
                      value: true,
                      onChanged: (value) {},
                      // value: userSignupStore.isAgree,
                      // onChanged: (value) {
                      //   userSignupStore.isAgree = value!;
                      // },
                    ),
                    Text(
                      'I agree to the ',
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 15,
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      'Terms and Conditions',
                      style: TextStyle(
                          color: primaryColor,
                          fontSize: 15,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                SizedBox(height: 10),

                GestureDetector(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      _signup();
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) => ProfileScreen()),
                      // );
                    }
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    alignment: Alignment.center,
                    decoration: boxDecorationWithRoundedCorners(
                      borderRadius: BorderRadius.all(Radius.circular(45)),
                      backgroundColor:
                          appStore.isDarkModeOn ? cardDarkColor : black,
                    ),
                    child: isLoading
                        ? CircularProgressIndicator(
                            color: white,
                          )
                        : Text('Sign Up', style: boldTextStyle(color: white)),
                  ),
                ),
                //Divider
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 40,
                    child: Row(
                      children: [
                        Expanded(
                            child: Container(height: 0.2, color: Colors.black)),
                        SizedBox(width: 10),
                        Text(
                          'Or looking for a project?',
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 15,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                            child: Container(
                                height: 0.2, color: primaryBlackColor)),
                      ],
                    ),
                  ),
                ),

                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LoginWithPassScreen()),
                    );
                  },
                  child: Text.rich(
                    TextSpan(
                      text: "Apply as a student? ",
                      style: secondaryTextStyle(),
                      children: [
                        TextSpan(text: ' Sign in', style: primaryTextStyle()),
                      ],
                    ),
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
