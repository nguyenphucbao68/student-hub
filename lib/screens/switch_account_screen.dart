import 'dart:convert';

import 'package:carea/commons/widgets.dart';
import 'package:carea/constants/app_constants.dart';
import 'package:carea/main.dart';
import 'package:carea/model/user_info.dart';
import 'package:carea/screens/login_with_pass_screen.dart';
import 'package:carea/screens/profile_input_ahaa_screen.dart';
import 'package:carea/screens/profile_input_nhap_screen.dart';
import 'package:carea/store/authprovider.dart';
import 'package:carea/store/profile_ob.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

class SwitchAccountScreen extends StatefulWidget {
  @override
  _SwitchAccountScreenState createState() => _SwitchAccountScreenState();
}

class _SwitchAccountScreenState extends State<SwitchAccountScreen> {
  late AuthProvider auth;
  late AuthProvider authStore;
  late ProfileOb profi;
  bool showRow = false;
  bool showInfoStudentRow = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    authStore = Provider.of<AuthProvider>(context);
    profi = Provider.of<ProfileOb>(context);
    init();
  }

  void init() async {
    await getMe();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  Future<void> getMe() async {
    await http.get(
      Uri.parse(AppConstants.BASE_URL + '/auth/me'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ' + authStore.token.toString(),
      },
    ).then((response) {
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        if (data['result'] != null) {
          UserInfo userInfo = UserInfo(
            id: data['result']['id'],
            fullName: data['result']['fullname'],
            roles: data['result']['roles'],
            student: data['result']['student'],
            company: data['result']['company'],
          );
          profi.setUserInfo(userInfo);

          // trigger rerender
          setState(() {});
        }
      }
    });
  }

  void changeProfile() {
    if (authStore.authSignUp == UserRole.STUDENT) {
      authStore.setAuthSignUp(UserRole.COMPANY);
    } else {
      authStore.setAuthSignUp(UserRole.STUDENT);
    }

    setState(() {});

    Navigator.pushNamed(context, "home");
  }

  @override
  Widget build(BuildContext context) {
    log("authStore.company" + authStore.company.toString());
    return Scaffold(
      appBar: careaAppBarWidget(
        context,
        titleText: "Profile Management",
        actionWidget: IconButton(
            onPressed: () {},
            icon: Icon(Icons.search, color: context.iconColor)),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: 16),
        child: Column(
          children: [
            SizedBox(height: 16),
            Stack(
              children: [
                Image.asset("assets/userImage.jpg",
                        height: 100, width: 100, fit: BoxFit.cover)
                    .cornerRadiusWithClipRRect(60),
              ],
            ),
            SizedBox(height: 8),
            Text('Andrew Desuza', style: boldTextStyle(size: 18)),
            SizedBox(height: 8),
            Text('+1 111 455 654 321', style: secondaryTextStyle()),
            SizedBox(height: 16),
            SettingItemWidget(
              leading: Icon(Icons.person_outline, color: context.iconColor),
              title: authStore.authSignUp == UserRole.STUDENT &&
                      profi.userInfo != null
                  ? (profi.userInfo!.fullName ?? "Unknown")
                  : (authStore.company != null
                      ? authStore.company!.companyName!
                      : ""),
              subTitle: authStore.authSignUp == UserRole.STUDENT
                  ? "Student"
                  : "Company",
              titleTextStyle: boldTextStyle(),
              onTap: () {
                setState(() {
                  showRow = !showRow;
                });
              },
              trailing: showRow
                  ? Transform.rotate(
                      angle: 3.14 / 2, // Độ xoay 90 độ
                      child: Icon(Icons.arrow_forward_ios_rounded,
                          size: 18, color: context.iconColor))
                  : Icon(Icons.arrow_forward_ios_rounded,
                      size: 18, color: context.iconColor),
            ),
            ((authStore.authSignUp == UserRole.STUDENT &&
                        authStore.company != null) ||
                    (authStore.authSignUp == UserRole.COMPANY &&
                        authStore.student != null &&
                        profi.userInfo != null))
                ? SizedBox(
                    width: 340,
                    child: showRow
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SettingItemWidget(
                                leading: Icon(Icons.person_outline,
                                    color: context.iconColor),
                                title: authStore.authSignUp == UserRole.COMPANY
                                    ? profi.userInfo!.fullName!
                                    : (authStore.company!.companyName ??
                                        "Unknown"),
                                subTitle:
                                    authStore.authSignUp != UserRole.STUDENT
                                        ? "Student"
                                        : "Company",
                                titleTextStyle: boldTextStyle(),
                                onTap: () {
                                  changeProfile();
                                },
                                trailing: Icon(Icons.arrow_forward_ios_rounded,
                                    size: 18, color: context.iconColor),
                              ),
                            ],
                          )
                        : null,
                  )
                : SizedBox(),
            SettingItemWidget(
              leading: Icon(Icons.person_2, color: context.iconColor),
              title: "Profile",
              titleTextStyle: boldTextStyle(),
              onTap: () {
                if (authStore.authSignUp == UserRole.COMPANY) {
                  var destinationScreen = profi.userInfo?.company != null
                      ? ProfileInputAhaaScreen()
                      : ProfileInputNhapScreen();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => destinationScreen),
                  );
                }

                setState(() {
                  showInfoStudentRow = !showInfoStudentRow;
                });
              },
              trailing: showInfoStudentRow
                  ? Transform.rotate(
                      angle: 3.14 / 2, // Độ xoay 90 độ
                      child: Icon(Icons.arrow_forward_ios_rounded,
                          size: 18, color: context.iconColor))
                  : Icon(Icons.arrow_forward_ios_rounded,
                      size: 18, color: context.iconColor),
            ),
            (authStore.authSignUp == UserRole.STUDENT &&
                    authStore.student != null)
                ? SizedBox(
                    width: 340,
                    child: showInfoStudentRow
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SettingItemWidget(
                                leading: Icon(Icons.school,
                                    color: context.iconColor),
                                title: "Techstack and Education",
                                titleTextStyle: boldTextStyle(),
                                onTap: () {
                                  // NotificationScreen().launch(context);
                                  Navigator.pushNamed(
                                      context, "techstack_education_screen", arguments: {
                                        "automaticallyImplyLeading": true,
                                      });
                                },
                                trailing: Icon(Icons.arrow_forward_ios_rounded,
                                    size: 18, color: context.iconColor),
                              ),
                              SettingItemWidget(
                                leading:
                                    Icon(Icons.work, color: context.iconColor),
                                title: "Experience",
                                titleTextStyle: boldTextStyle(),
                                onTap: () {
                                  // NotificationScreen().launch(context);
                                  Navigator.pushNamed(
                                      context, "experience_screen", arguments: {
                                        "automaticallyImplyLeading": true,
                                      });
                                },
                                trailing: Icon(Icons.arrow_forward_ios_rounded,
                                    size: 18, color: context.iconColor),
                              ),
                              SettingItemWidget(
                                leading: Icon(Icons.description,
                                    color: context.iconColor),
                                title: "CV/Transcript",
                                titleTextStyle: boldTextStyle(),
                                onTap: () {
                                  // NotificationScreen().launch(context);
                                  Navigator.pushNamed(
                                      context, "cv_transcript_screen", arguments: {
                                        "automaticallyImplyLeading": true,
                                      });
                                },
                                trailing: Icon(Icons.arrow_forward_ios_rounded,
                                    size: 18, color: context.iconColor),
                              ),
                            ],
                          )
                        : null,
                  )
                : SizedBox(),
            SettingItemWidget(
              leading: Icon(Icons.settings, color: context.iconColor),
              title: "Change Password",
              titleTextStyle: boldTextStyle(),
              onTap: () {
                // NotificationScreen().launch(context);
                Navigator.pushNamed(context, "create_new_pass_screen");
              },
              trailing: Icon(Icons.arrow_forward_ios_rounded,
                  size: 18, color: context.iconColor),
            ),
            SettingItemWidget(
              leading: Icon(Icons.wb_sunny_outlined, color: context.iconColor),
              title: "Dark Mode",
              titleTextStyle: boldTextStyle(),
              onTap: () async {
                if (appStore.isDarkModeOn) {
                  appStore.toggleDarkMode(value: false);
                } else {
                  appStore.toggleDarkMode(value: true);
                }
              },
              trailing: SizedBox(
                height: 20,
                width: 30,
                child: Switch(
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  value: appStore.isDarkModeOn,
                  onChanged: (bool value) {
                    appStore.toggleDarkMode(value: value);
                    setState(() {});
                  },
                ),
              ),
            ),
            SettingItemWidget(
              leading: Icon(Icons.login, color: context.iconColor),
              title: "Logout",
              titleTextStyle: boldTextStyle(),
              onTap: () {
                showConfirmDialogCustom(context, onAccept: (c) {
                  authStore.logout();

                  LoginWithPassScreen().launch(context, isNewTask: true);
                }, dialogType: DialogType.CONFIRMATION);
              },
              trailing: Icon(Icons.arrow_forward_ios_rounded,
                  size: 18, color: context.iconColor),
            ),
          ],
        ),
      ),
    );
  }
}
