import 'dart:async';

import 'package:carea/screens/input_profile_experience_screen.dart';
import 'package:carea/screens/login_with_pass_screen.dart';
import 'package:carea/screens/send_hire_offer_screen.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class FlashScreen extends StatefulWidget {
  const FlashScreen({Key? key}) : super(key: key);

  @override
  State<FlashScreen> createState() => _FlashScreenState();
}

class _FlashScreenState extends State<FlashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 2),
      () {
        // WalkThroughScreen().launch(context, isNewTask: true);
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => Home()),
        // );
        // Si().launch(context, isNewTask: true);
        LoginWithPassScreen().launch(context, isNewTask: true);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Icon(Icons.car_crash, size: 120)),
    );
  }
}
