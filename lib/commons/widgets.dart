import 'dart:async';

import 'package:carea/commons/colors.dart';
import 'package:carea/commons/constants.dart';
import 'package:carea/commons/images.dart';
import 'package:carea/main.dart';
import 'package:carea/model/calling_model.dart';
import 'package:carea/screens/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';

Widget text({
  required String txt,
  double size = 12,
  final Color? color = primaryWhiteColor,
  final FontWeight? fontWeight,
  final TextAlign? textAlign,
  final Color? backgroundColor,
}) {
  return Text(
    txt,
    textAlign: textAlign,
    style: TextStyle(
        backgroundColor: backgroundColor,
        color: color,
        fontSize: size,
        fontWeight: fontWeight),
  );
}

Widget customButton({
  final GestureTapCallback? onTap,
  String txt = "",
  double? wid,
  double? high = 40,
  final Color? color = primaryBlackColor,
  final double? elevation = 5,
  final BoxBorder? border,
  final Color? txtcolor = primaryWhiteColor,
  final double? textSize = 14,
}) {
  return InkWell(
    onTap: onTap,
    child: Card(
      // elevation: elevation,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      child: Container(
        height: high,
        width: wid,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            border: border,
            color: color,
            borderRadius: BorderRadius.circular(40)),
        child: Text(txt, style: TextStyle(color: txtcolor, fontSize: textSize)),
      ),
    ),
  );
}

Widget customButton_1({
  final GestureTapCallback? onTap,
  String txt = "",
  final Color? color = primaryBlackColor,
  final double? elevation = 10,
  final BoxBorder? border,
  final Color? txtcolor = primaryWhiteColor,
}) {
  return InkWell(
    onTap: onTap,
    child: Card(
      elevation: elevation,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            border: border,
            color: color,
            borderRadius: BorderRadius.circular(15)),
        child: Text(txt, style: TextStyle(color: txtcolor)),
      ),
    ),
  );
}

Future customDialoge(
  BuildContext context, {
  final GestureTapCallback? onTap,
  final List<Widget>? actions,
  // Flash? i,
  var arguments,
}) {
  //var flashObserver = i;
  return showDialog(
    context: context,
    builder: (context) {
      Timer.periodic(Duration(milliseconds: 500), (timer) {
        appStore.i += 1;
        if (timer.tick == 500) {
          timer.cancel();
        }
      });
      Timer(
        Duration(seconds: 1),
        () {
          Navigator.pop(context);
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => HomeScreen()));
        },
      );
      final high = MediaQuery.of(context).size.width;
      return AlertDialog(
        scrollable: true,
        actions: actions,
        backgroundColor: context.scaffoldBackgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(36)),
        content: SingleChildScrollView(
          child: Container(
            alignment: Alignment.topCenter,
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            width: high / 6 * 3,
            child: FittedBox(
              child: Column(
                children: [
                  16.height,
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.all(42),
                        decoration: boxDecorationWithRoundedCorners(
                          boxShape: BoxShape.circle,
                          backgroundColor:
                              appStore.isDarkModeOn ? cardDarkColor : black,
                        ),
                      ),
                      Icon(Icons.person,
                          size: 50,
                          color: appStore.isDarkModeOn ? white : white)
                    ],
                  ),
                  24.height,
                  Text('Congratulations', style: boldTextStyle(size: 18)),
                  SizedBox(height: 15),
                  Text(
                    'Your account is ready to use. You will\nbe redirected to the home page in a\nfew seconds',
                    textAlign: TextAlign.center,
                    style: secondaryTextStyle(),
                  ),
                  SizedBox(height: 15),
                  Observer(
                    builder: (context) => Transform.rotate(
                      angle: appStore.i + 0.5,
                      child: Image(
                          image: AssetImage(loding),
                          color: context.iconColor,
                          height: high / 24 * 3,
                          width: high / 24 * 3),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}

PreferredSizeWidget careaAppBarWidget(BuildContext context,
    {String? titleText, Widget? actionWidget, Widget? actionWidget2}) {
  return AppBar(
    backgroundColor: context.scaffoldBackgroundColor,
    leading: IconButton(
      icon: Icon(Icons.arrow_back, color: context.iconColor),
      onPressed: () {
        Navigator.pop(context);
      },
    ),
    actions: [actionWidget ?? SizedBox(), actionWidget2 ?? SizedBox()],
    title: Text(titleText ?? "", style: boldTextStyle(size: 18)),
    elevation: 0.0,
  );
}

PreferredSizeWidget commonAppBarWidget(BuildContext context,
    {String? titleText, Widget? actionWidget, Widget? actionWidget2}) {
  return AppBar(
    elevation: 0,
    toolbarHeight: 50,
    // backgroundColor: appStore.isDarkModeOn ? scaffoldDarkColor : white,
    backgroundColor: Color.fromARGB(255, 228, 227, 227),
    title: Text("Student Hub", style: boldTextStyle()),
    automaticallyImplyLeading: false,
    // leading: GestureDetector(
    //   child: Padding(
    //     padding: EdgeInsets.only(top: 8, right: 8, bottom: 8, left: 16),
    //     child: Image.asset("assets/student_hub_icon.png", fit: BoxFit.cover)
    //         .cornerRadiusWithClipRRect(60),
    //   ),
    //   onTap: () {
    //     // Navigator.push(
    //     //   context,
    //     //   MaterialPageRoute(builder: (context) => ProfileScreen()),
    //     // );
    //   },
    // ),
    actions: [
      IconButton(
        icon: Icon(Icons.person, size: 22, color: context.iconColor),
        onPressed: () {
          print('Hello wolrd');
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => NotificationScreen()),
          // );
        },
      ),
      // IconButton(
      //   icon: Icon(Icons.favorite_border_rounded,
      //       size: 22, color: context.iconColor),
      //   onPressed: () {
      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(builder: (context) => WishListScreen()),
      //     );
      //   },
      // )
    ],
  );
}

InputDecoration inputDecoration(
  BuildContext context, {
  IconData? prefixIcon,
  Widget? suffixIcon,
  String? labelText,
  double? borderRadius,
  String? hintText,
}) {
  return InputDecoration(
    counterText: "",
    contentPadding: EdgeInsets.only(left: 12, bottom: 10, top: 10, right: 10),
    labelText: labelText,
    labelStyle: secondaryTextStyle(),
    alignLabelWithHint: true,
    hintText: hintText.validate(),
    hintStyle: secondaryTextStyle(),
    isDense: true,
    prefixIcon: prefixIcon != null
        ? Icon(prefixIcon,
            size: 16, color: appStore.isDarkModeOn ? white : gray)
        : null,
    suffixIcon: suffixIcon.validate(),
    enabledBorder: OutlineInputBorder(
      borderRadius: radius(borderRadius ?? defaultRadius),
      borderSide: BorderSide(color: Colors.transparent, width: 0.0),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: radius(borderRadius ?? defaultRadius),
      borderSide: BorderSide(color: Colors.red, width: 0.0),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: radius(borderRadius ?? defaultRadius),
      borderSide: BorderSide(color: Colors.red, width: 1.0),
    ),
    errorMaxLines: 2,
    errorStyle: primaryTextStyle(color: Colors.red, size: 12),
    focusedBorder: OutlineInputBorder(
      borderRadius: radius(borderRadius ?? defaultRadius),
      borderSide: BorderSide(color: Colors.transparent, width: 0.0),
    ),
    filled: true,
    fillColor: appStore.isDarkModeOn ? cardDarkColor : editTextBgColor,
  );
}

Decoration commonDecoration({double? cornorRadius}) {
  return boxDecorationWithRoundedCorners(
    backgroundColor: appStore.isDarkModeOn ? cardDarkColor : white,
    borderRadius: BorderRadius.all(Radius.circular(cornorRadius ?? 8.0)),
    border: Border.all(
        color: appStore.isDarkModeOn ? white : gray.withOpacity(0.1)),
  );
}

class ChatMessageWidget extends StatelessWidget {
  const ChatMessageWidget({
    Key? key,
    required this.isMe,
    required this.data,
  }) : super(key: key);

  final bool isMe;
  final BHMessageModel data;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment:
          isMe.validate() ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 2),
          margin: isMe.validate()
              ? EdgeInsets.only(
                  top: 3.0,
                  bottom: 3.0,
                  right: 0,
                  left: (500 * 0.25).toDouble())
              : EdgeInsets.only(
                  top: 4.0,
                  bottom: 4.0,
                  left: 0,
                  right: (500 * 0.25).toDouble(),
                ),
          decoration: BoxDecoration(
            color: !isMe ? Colors.red.withOpacity(0.85) : context.cardColor,
            boxShadow: defaultBoxShadow(),
            borderRadius: isMe.validate()
                ? BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10))
                : BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                    topRight: Radius.circular(10)),
            border: Border.all(
                color:
                    isMe ? Theme.of(context).dividerColor : Colors.transparent),
          ),
          child: Column(
            crossAxisAlignment:
                isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: Text(
                  data.msg!,
                  style: primaryTextStyle(
                    color: !isMe
                        ? white
                        : appStore.isDarkModeOn
                            ? white
                            : textPrimaryColor,
                  ),
                ),
              ),
              Text(
                data.time!,
                style: secondaryTextStyle(
                  size: 12,
                  color: !isMe
                      ? white
                      : appStore.isDarkModeOn
                          ? gray
                          : textSecondaryColor,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

String formatDate(String? dateTime,
    {String format = DATE_FORMAT_2,
    bool isFromMicrosecondsSinceEpoch = false}) {
  if (isFromMicrosecondsSinceEpoch) {
    return DateFormat(format).format(DateTime.fromMicrosecondsSinceEpoch(
        dateTime.validate().toInt() * 1000));
  } else {
    return DateFormat(format).format(DateTime.parse(dateTime.validate()));
  }
}

Row dialogWithTitle(
  BuildContext context, {
  required String title,
  required List<Widget> childrenWidget,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        title,
        style: boldTextStyle(size: 14),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Dialog(
                        backgroundColor: Colors.white,
                        child: Padding(
                            padding: EdgeInsets.only(
                                top: 10.0,
                                left: 20.0,
                                right: 20.0,
                                bottom: 15.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: childrenWidget,
                            )),
                      );
                    });
              },
              icon: Icon(Icons.add_circle_outline)),
        ],
      ),
    ],
  );
}
