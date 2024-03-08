import 'package:flutter/material.dart';
import 'package:carea/commons/widgets.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:carea/screens/login_with_pass_screen.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          const LoginWithPassScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBarWidget(context),
      body: Container(
        padding: EdgeInsets.all(25),
        child: Column(
          children: [
            SizedBox(height: 25),
            Text(
              "Build your product with high-skilled student",
              style: boldTextStyle(),
            ),
            SizedBox(height: 30),
            Text(
              "Find and onboard best-skilled student for your product. Student works to gain experience & skills from real-world projects",
              style: primaryTextStyle(),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 25,
            ),
            customButton(
                txt: 'Company',
                onTap: () => {Navigator.of(context).push(_createRoute())},
                wid: 200),
            SizedBox(height: 5),
            customButton(
                txt: 'Student',
                onTap: () => {Navigator.of(context).push(_createRoute())},
                // LoginWithPassScreen().launch(context, isNewTask: true)},
                wid: 200),
            SizedBox(
              height: 25,
            ),
            Text(
              'StudentHub is university market place to connect high-skilled student and company on a real-world project',
              style: primaryTextStyle(),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
