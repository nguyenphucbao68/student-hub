import 'package:carea/commons/widgets.dart';
import 'package:carea/main.dart';
import 'package:carea/screens/login_with_pass_screen.dart';
import 'package:carea/screens/notification_screen.dart';
import 'package:carea/screens/payment_screen.dart';
import 'package:carea/screens/profile_input_ahaa_screen.dart';
import 'package:carea/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class SwitchAccountScreen extends StatefulWidget {
  @override
  _SwitchAccountScreenState createState() => _SwitchAccountScreenState();
}

class _SwitchAccountScreenState extends State<SwitchAccountScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  bool showRow = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: careaAppBarWidget(
        context,
        titleText: "StudentHub",
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
                // Positioned(
                //   right: 0,
                //   bottom: 0,
                //   // child:
                //   // Container(
                //   //   alignment: Alignment.center,
                //   //   padding: EdgeInsets.all(6),
                //   //   decoration: BoxDecoration(
                //   //     color: Colors.black,
                //   //     // border: Border.all(color: Colors.black.withOpacity(0.3)),
                //   //     // borderRadius: BorderRadius.circular(8),
                //   //   ),
                //   //   child: Icon(Icons.edit, color: white, size: 16),
                //   // ).onTap(() {
                //   //   ProfileScreen().launch(context);
                //   // }),
                // ),
              ],
            ),
            SizedBox(height: 8),
            Text('Andrew Desuza', style: boldTextStyle(size: 18)),
            SizedBox(height: 8),
            Text('+1 111 455 654 321', style: secondaryTextStyle()),
            SizedBox(height: 16),
            SettingItemWidget(
              leading: Icon(Icons.person_outline, color: context.iconColor),
              title: "Hai Pham",
              subTitle: "Company",
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
            SizedBox(
              width: 340,
              child: showRow
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SettingItemWidget(
                          leading: Icon(Icons.person_outline,
                              color: context.iconColor),
                          title: "Hai Pham",
                          subTitle: "Student",
                          titleTextStyle: boldTextStyle(),
                          onTap: () {},
                          trailing: Icon(Icons.arrow_forward_ios_rounded,
                              size: 18, color: context.iconColor),
                        ),
                      ],
                    )
                  : null,
            ),
            SettingItemWidget(
              leading: Icon(Icons.person_2, color: context.iconColor),
              title: "Profile",
              titleTextStyle: boldTextStyle(),
              onTap: () {
                //
              },
              trailing: Icon(Icons.arrow_forward_ios_rounded,
                  size: 18, color: context.iconColor),
            ),
            SettingItemWidget(
              leading: Icon(Icons.settings, color: context.iconColor),
              title: "Setting",
              titleTextStyle: boldTextStyle(),
              onTap: () {
                NotificationScreen().launch(context);
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
