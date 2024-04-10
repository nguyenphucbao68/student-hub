import 'dart:convert';

import 'package:carea/commons/images.dart';
import 'package:carea/commons/widgets.dart';
import 'package:carea/constants/app_constants.dart';
import 'package:carea/main.dart';
import 'package:carea/screens/dashboard_screen.dart';
import 'package:carea/screens/forgot_pass_screen.dart';
import 'package:carea/screens/sign_up_choose_options_screen.dart';
import 'package:carea/store/authprovider.dart';
import 'package:carea/store/logicprovider.dart';
import 'package:carea/store/user_signup.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

class LoginWithPassScreen extends StatefulWidget {
  const LoginWithPassScreen({Key? key}) : super(key: key);

  @override
  State<LoginWithPassScreen> createState() => _LoginWithPassScreenState();
}

class _LoginWithPassScreenState extends State<LoginWithPassScreen> {
  late AuthProvider observer;

  TextEditingController? _emailController;
  TextEditingController? _passwordController;

  bool isIconTrue = false;
  bool isChecked = false;

  FocusNode f1 = FocusNode();
  FocusNode f2 = FocusNode();

  final _formKey = GlobalKey<FormState>();
  var userinfo;

  bool? checkBoxValue = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var userinfo = ModalRoute.of(context)!.settings.arguments;
    observer = Provider.of<AuthProvider>(context);

    if (_emailController == null || _passwordController == null) {
      if (userinfo == null) {
        _emailController = TextEditingController();
        _passwordController = TextEditingController();
      } else {
        userinfo as UserCreadential;
        _emailController = TextEditingController(text: userinfo.user_email);
        _passwordController =
            TextEditingController(text: userinfo.user_password);
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _login() async {
    // if (_formKey.currentState!.validate()) {
    final email = _emailController!.text;
    final password = _passwordController!.text;

    // code request api here (restful): http://localhost:4400/auth/sign-in
    await http
        .post(
      Uri.parse(AppConstants.BASE_URL + '/auth/sign-in'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    )
        .then((response) {
      if (response.statusCode == 201) {
        // If the server returns an OK response, then parse the JSON.
        var data = jsonDecode(response.body);
        log("Data" + data.toString());
        if (data['result'] != null) {
          // save token to local storage

          observer.login(data['result']['token']);
          log('Login success' + data['result']['token']);

          // console.log
          // print('Login success' + data['result']['tojen']);

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
          );
        } else {
          log('error');
          // show error message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(data['message']),
            ),
          );
        }
      } else {
        // If the server returns an error response, then throw an exception.
        // throw Exception('Failed to login');
        // log('Failed to login 2');
        //  show username and password incorrect
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Username or password incorrect!'),
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
    // }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        FocusScope.of(context).unfocus();
        return true;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
            elevation: 0, iconTheme: IconThemeData(color: context.iconColor)),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image(
                      height: 100,
                      width: 100,
                      fit: BoxFit.fitWidth,
                      image: AssetImage(student_hub)),
                  SizedBox(height: 10),
                  Text('Login to Your Account', style: boldTextStyle(size: 24)),
                  SizedBox(height: 20),
                  TextFormField(
                    focusNode: f1,
                    onFieldSubmitted: (v) {
                      f1.unfocus();
                      FocusScope.of(context).requestFocus(f2);
                    },
                    // validator: (k) {
                    //   if (!k!.contains('@')) {
                    //     return 'Please enter the correct email';
                    //   }
                    //   return null;
                    // },
                    controller: _emailController,
                    decoration: inputDecoration(context,
                        prefixIcon: Icons.mail_rounded, hintText: "Email"),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: isIconTrue,
                    focusNode: f2,
                    // validator: (value) {
                    //   return Validate.validate(value!);
                    // },
                    onFieldSubmitted: (v) {
                      f2.unfocus();
                      if (_formKey.currentState!.validate()) {
                        // _login();
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
                  SizedBox(height: 8),
                  Theme(
                    data: ThemeData(
                        unselectedWidgetColor:
                            appStore.isDarkModeOn ? Colors.white : black),
                    child: CheckboxListTile(
                      contentPadding: EdgeInsets.all(0),
                      title: Text("Remember Me", style: primaryTextStyle()),
                      value: checkBoxValue,
                      dense: true,
                      onChanged: (newValue) {
                        setState(() {
                          checkBoxValue = newValue;
                        });
                      },
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        _login();
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => HomeScreen()));
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(vertical: 16),
                      decoration: boxDecorationWithRoundedCorners(
                        borderRadius: BorderRadius.all(Radius.circular(45)),
                        backgroundColor:
                            appStore.isDarkModeOn ? cardDarkColor : black,
                      ),
                      child:
                          Text('Sign in', style: boldTextStyle(color: white)),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ForgotPassScreen()));
                    },
                    child:
                        Text('Forgot the password ?', style: boldTextStyle()),
                  ),
                  SizedBox(height: 8),
                  SizedBox(
                    height: 30,
                    child: Row(
                      children: [
                        Expanded(
                            child:
                                Container(height: 0.2, color: Colors.black26)),
                        SizedBox(width: 10),
                        Text('Or continue with', style: secondaryTextStyle()),
                        SizedBox(width: 10),
                        Expanded(
                            child:
                                Container(height: 0.2, color: Colors.black26)),
                      ],
                    ),
                  ),
                  SizedBox(height: 5),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        // MaterialPageRoute(builder: (context) => SignUpScreen()),
                        MaterialPageRoute(
                            builder: (context) => SignUpChooseOptionsScreen()),
                      );
                    },
                    child: Text.rich(
                      TextSpan(
                        text: "Already have an account? ",
                        style: secondaryTextStyle(),
                        children: [
                          TextSpan(
                              text: ' Sign up', style: boldTextStyle(size: 14)),
                        ],
                      ),
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
