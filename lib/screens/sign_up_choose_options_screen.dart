import 'package:carea/commons/images.dart';
import 'package:carea/main.dart';
import 'package:carea/screens/home_screen.dart';
import 'package:carea/screens/signup_screen.dart';
import 'package:carea/store/user_signup.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class SignUpChooseOptionsScreen extends StatefulWidget {
  const SignUpChooseOptionsScreen({Key? key}) : super(key: key);

  @override
  State<SignUpChooseOptionsScreen> createState() =>
      _SignUpChooseOptionsScreenState();
}

class _SignUpChooseOptionsScreenState extends State<SignUpChooseOptionsScreen> {
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
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image(
                    height: 100,
                    width: 100,
                    fit: BoxFit.fitWidth,
                    image: AssetImage(student_hub)),
                SizedBox(height: 10),
                Text('Join as company or Student',
                    style: boldTextStyle(size: 24)),
                SizedBox(height: 20),
                RadioListTile<String>(
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.engineering,
                        size: 30,
                        color: context.iconColor,
                      ),
                      SizedBox(height: 10),
                      Text('I am a company, find engineer for project'),
                    ],
                  ),
                  value: "company",
                  groupValue: "userType",
                  onChanged: (value) {},
                  controlAffinity: ListTileControlAffinity.trailing,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    side: BorderSide(color: gray.withOpacity(0.5)),
                  ),
                ),
                SizedBox(height: 20),
                RadioListTile<String>(
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.school,
                        size: 30,
                        color: context.iconColor,
                      ),
                      SizedBox(height: 10),
                      Text('I am a student looking for projects'),
                    ],
                  ),
                  value: "student",
                  groupValue: "userType",
                  // color of the radio button
                  onChanged: (value) {},
                  controlAffinity: ListTileControlAffinity.trailing,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    side: BorderSide(color: gray.withOpacity(0.5)),
                  ),
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SignUpScreen()));
                  },
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    decoration: boxDecorationWithRoundedCorners(
                      borderRadius: BorderRadius.all(Radius.circular(45)),
                      backgroundColor:
                          appStore.isDarkModeOn ? cardDarkColor : black,
                    ),
                    child: Text('Create Account',
                        style: boldTextStyle(color: white)),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Spacer(),
                    Text("Already have an account?"),
                    TextButton(
                      onPressed: () {
                        // TODO: Implement log-in logic
                      },
                      child: Text("Log in"),
                    ),
                    Spacer(),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
