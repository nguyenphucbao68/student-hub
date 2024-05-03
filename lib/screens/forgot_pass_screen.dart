import 'dart:convert';

import 'package:carea/commons/images.dart';
import 'package:carea/commons/widgets.dart';
import 'package:carea/constants/app_constants.dart';
import 'package:carea/main.dart';
import 'package:carea/screens/forgotpass_otp.dart';
import 'package:carea/screens/login_with_pass_screen.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:http/http.dart' as http;

class ForgotPassScreen extends StatefulWidget {
  const ForgotPassScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPassScreen> createState() => _ForgotPassScreenState();
}

class _ForgotPassScreenState extends State<ForgotPassScreen> {
  final TextEditingController _emailController = TextEditingController();

  void forgotPassword() async {
    // if (_formKey.currentState!.validate()) {
    final email = _emailController.text;

    log("Email: " + email);

    // code request api here (restful): http://localhost:4400/auth/sign-in
    await http
        .post(
      Uri.parse(AppConstants.BASE_URL + '/user/forgotPassword'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'email': email,
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
              "We've sent you an email with a new password. Please check your email."),
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
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        FocusScope.of(context).unfocus();
        return true;
      },
      child: Scaffold(
        appBar: careaAppBarWidget(context, titleText: "Forgot the password"),
        body: Container(
          alignment: Alignment.topCenter,
          padding: EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Image(width: 200, height: 200, image: AssetImage(forgotpass)),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                      'Input your email address to receive your new password.',
                      style: primaryTextStyle()),
                ),
                SizedBox(height: 16),
                // Container(
                //   height: MediaQuery.of(context).size.width * 0.3,
                //   width: MediaQuery.of(context).size.width,
                //   padding: EdgeInsets.all(12),
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(24),
                //     border: Border.all(color: Colors.grey.shade300),
                //   ),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     crossAxisAlignment: CrossAxisAlignment.center,
                //     children: [
                //       CircleAvatar(
                //         backgroundColor: appStore.isDarkModeOn ? cardDarkColor : gray.withOpacity(0.2),
                //         child: Icon(Icons.message_rounded, color: context.iconColor, size: 20),
                //       ),
                //       Expanded(
                //         child: GestureDetector(
                //           onTap: () {
                //             Navigator.push(
                //               context,
                //               MaterialPageRoute(builder: (context) => ForgotPassOtp()),
                //             );
                //           },
                //           child: ListTile(
                //             title: Text('via SMS', style: secondaryTextStyle()),
                //             subtitle: Text('+1 111 ********99', style: boldTextStyle()),
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),

                SizedBox(height: 20),
                Container(
                  height: MediaQuery.of(context).size.width * 0.3,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundColor: appStore.isDarkModeOn
                            ? cardDarkColor
                            : gray.withOpacity(0.2),
                        child: Icon(Icons.email_rounded,
                            size: 20, color: context.iconColor),
                      ),

                      10.width,
                      // Input to enter email to send email
                      Expanded(
                        child: TextField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            hintText: 'Enter your email',
                            hintStyle: secondaryTextStyle(),
                            // border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30),
                InkWell(
                  onTap: () {
                    forgotPassword();
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: appStore.isDarkModeOn
                            ? cardDarkColor
                            : Colors.black,
                        borderRadius: BorderRadius.circular(45)),
                    child:
                        Text('Send', style: boldTextStyle(color: Colors.white)),
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
