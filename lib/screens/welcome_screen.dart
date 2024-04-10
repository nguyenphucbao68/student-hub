import 'package:carea/screens/dashboard_screen.dart';
import 'package:carea/store/authprovider.dart';
import 'package:flutter/material.dart';
import 'package:carea/commons/widgets.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  late AuthProvider authStore;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    authStore = Provider.of<AuthProvider>(context);
  }

  @override
  Widget build(BuildContext context) {
    String name = authStore.fullName.toString();
    return Scaffold(
      appBar: careaAppBarWidget(
        context,
        titleText: "Welcome",
        actionWidget: IconButton(
            onPressed: () {},
            icon: Icon(Icons.person, color: context.iconColor)),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.signpost, size: 80),
            SizedBox(height: 50),
            Text('Welcome $name', style: primaryTextStyle(size: 18)),
            SizedBox(height: 10),
            Text('Let\'s start with your first project post',
                style: primaryTextStyle(size: 16)),
            SizedBox(height: 10),
            customButton(
              txt: 'Get started!',
              textSize: 16,
              high: 50,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              },
            ),
            SizedBox(height: 200),
          ],
        ),
      ),
    );
  }
}
