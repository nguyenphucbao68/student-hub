import 'package:carea/commons/colors.dart';
import 'package:carea/commons/images.dart';
import 'package:carea/commons/widgets.dart';
import 'package:carea/main.dart';
import 'package:carea/screens/login_with_pass_screen.dart';
import 'package:carea/screens/profile_screen.dart';
import 'package:carea/store/user_signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  FocusNode focusEmail = FocusNode();
  FocusNode focusPassword = FocusNode();

  bool isIconTrue = false;

  // declare userSignupStore

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
                Text('Sign up as a Company', style: boldTextStyle(size: 24)),
                SizedBox(height: 20),
                TextFormField(
                  autofocus: false,
                  focusNode: focusEmail,
                  onFieldSubmitted: (v) {
                    focusEmail.unfocus();
                    FocusScope.of(context).requestFocus(focusPassword);
                  },
                  controller: _emailController,
                  decoration: inputDecoration(context,
                      prefixIcon: Icons.person, hintText: "Fullname"),
                ),
                SizedBox(height: 20),
                TextFormField(
                  autofocus: false,
                  validator: (value) {
                    if (!value!.contains('@') || !value.endsWith(".com")) {
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProfileScreen()),
                      );
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
                    child: Text('Sign Up', style: boldTextStyle(color: white)),
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
