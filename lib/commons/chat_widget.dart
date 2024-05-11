import 'package:carea/commons/constants.dart';
import 'package:carea/components/schedule_interview_component.dart';
import 'package:carea/screens/update_interview_screen.dart';
import 'package:carea/main.dart';
import 'package:carea/model/calling_model.dart';
import 'package:carea/screens/dashboard_screen.dart';
import 'package:carea/screens/meet_screen.dart';
import 'package:carea/screens/video_conference.dart';
import 'package:carea/utils/Date.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:carea/model/message.dart';

class ChatWidget extends StatelessWidget {
  const ChatWidget({
    Key? key,
    required this.isMe,
    required this.msg,
    required this.updateInterviewCallback,
    required this.disableInterviewCallback,
    required this.deleteInterviewCallback,
  }) : super(key: key);

  final bool isMe;
  // final BHMessageModel data;
  final Message msg;
  final Function updateInterviewCallback;
  final Function disableInterviewCallback;
  final Function deleteInterviewCallback;

  List<Widget> activeMeetingOption(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return [
      isMe ? 130.width : 180.width,
      GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    //  MeetScreen())
                    VideoConferencePage(
                        conferenceID:
                            msg.interview!.meetingRoom!.meetingRoomCode!)),
          );
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 36),
          margin: EdgeInsets.only(top: 12),
          decoration: boxDecorationWithRoundedCorners(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            backgroundColor: appStore.buttonPrimaryColor!,
          ),
          child: Row(
            children: [
              Icon(Icons.video_call_outlined, size: 20, color: white),
              10.width,
              Text("Join", style: primaryTextStyle(size: 16, color: white))
            ],
          ),
          // child: Text("Proposals: 5",
          //     style: primaryTextStyle(size: 12, color: white)),
        ),
      ),
      isMe
          ? IconButton(
              padding: EdgeInsets.only(top: 10),
              onPressed: () {
                showModalBottomSheet(
                  enableDrag: true,
                  isDismissible: true,
                  isScrollControlled: true,
                  constraints: BoxConstraints.expand(
                    height: height * 0.23,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(60),
                        topRight: Radius.circular(60)),
                  ),
                  context: context,
                  builder: (context) {
                    return SingleChildScrollView(
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: context.scaffoldBackgroundColor,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8),
                              topRight: Radius.circular(8)),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            OutlinedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          UpdateInterviewScreen(
                                              data: msg.interview!,
                                              updateInterviewCallback:
                                                  updateInterviewCallback),
                                    ));
                              },
                              child: Text(
                                "Re-schedule the meeting",
                                style: boldTextStyle(
                                    color: appStore.textPrimaryColor, size: 16),
                              ),
                              style: OutlinedButton.styleFrom(
                                padding: EdgeInsets.symmetric(vertical: 12),
                                minimumSize: Size(double.infinity, 0),
                              ),
                            ),
                            SizedBox(height: 10),
                            OutlinedButton(
                              onPressed: () {
                                disableInterviewCallback(msg.interview);
                                Navigator.pop(context);
                              },
                              child: Text(
                                "Cancel this intervew",
                                style: boldTextStyle(
                                    color: Colors.black, size: 16),
                              ),
                              style: OutlinedButton.styleFrom(
                                padding: EdgeInsets.symmetric(vertical: 12),
                                minimumSize: Size(double.infinity, 0),
                              ),
                            ),
                            SizedBox(height: 10),
                            OutlinedButton(
                              onPressed: () {
                                deleteInterviewCallback(msg.interview);
                                Navigator.pop(context);
                              },
                              child: Text(
                                "Delete this intervew",
                                style: boldTextStyle(
                                    color: appStore.textPrimaryColor, size: 16),
                              ),
                              style: OutlinedButton.styleFrom(
                                padding: EdgeInsets.symmetric(vertical: 12),
                                minimumSize: Size(double.infinity, 0),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              icon: Icon(
                Icons.pending_outlined,
                size: 40,
              ))
          : SizedBox(),
    ];
  }

  List<Widget> cancelMeetingOption(BuildContext context) {
    return [
      120.width,
      Text(
        "The meeting is canceled",
        style: boldTextStyle(color: Colors.red),
      )
    ];
  }

  Widget scheduleMeetingWiget(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Divider(),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 2),
          child: Column(
            crossAxisAlignment:
                isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  msg.content!,
                  style: boldTextStyle(
                      size: 17, color: appStore.isDarkModeOn ? white : black),
                ),
              ),
              8.height,
              Container(
                margin: EdgeInsets.only(bottom: 8),
                padding:
                    EdgeInsets.only(left: 16, right: 8, top: 8, bottom: 12),
                decoration: BoxDecoration(
                  color: appStore.appBarColor,
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  border: Border.all(
                    color: appStore.isDarkModeOn ? white : black,
                    width: 2,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        // space between
                        children: <Widget>[
                          Expanded(
                              flex: 1,
                              // child: Text(msg.interview!.title!,
                              child: Text("Title: " + msg.interview!.title!,
                                  style: boldTextStyle(size: 16))),
                          Text(
                              DateTime.parse(msg.interview!.endTime!)
                                      .difference(DateTime.parse(
                                          msg.interview!.startTime!))
                                      .inMinutes
                                      .toString() +
                                  " minutes",
                              style: TextStyle(
                                  fontSize: 15, fontStyle: FontStyle.italic)),
                        ],
                      ),
                    ),
                    6.height,
                    Container(
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              // msg.interview?.startTime ?? 'Unknown',
                              "  Start time: " +
                                  DateFormat(DATE_FORMAT_4).format(
                                      DateTime.parse(
                                          msg.interview!.startTime!)),
                              style: primaryTextStyle(
                                  size: 15,
                                  color: appStore.isDarkModeOn ? white : black),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              // msg.interview?.endTime ?? 'Unknown',
                              "  End time: " +
                                  DateFormat(DATE_FORMAT_4).format(
                                      DateTime.parse(msg.interview!.endTime!)),
                              style: primaryTextStyle(
                                  size: 15,
                                  color: appStore.isDarkModeOn ? white : black),
                            ),
                          ),
                        ],
                      ),
                    ),
                    6.height,
                    Row(
                      children: (DateTime.now().isAfter(DateTime.parse(
                                  msg.interview!.meetingRoom!.expiredAt!)) ||
                              msg.interview?.disableFlag == 1)
                          ? cancelMeetingOption(context)
                          : activeMeetingOption(context),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Divider(),
      ],
    );
  }

  Widget messageWidget(BuildContext context) {
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
            color: !isMe
                ? appStore.isDarkModeOn
                    ? appStore.buttonPrimaryColor
                    : gray.withOpacity(0.2)
                : appStore.isDarkModeOn
                    ? cardDarkColor
                    : Colors.black,
            boxShadow: defaultBoxShadow(),
            borderRadius: isMe.validate()
                ? BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  )
                : BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
          ),
          child: Column(
            crossAxisAlignment:
                isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: Text(
                  msg.content.validate(),
                  style: primaryTextStyle(
                    color: !isMe
                        ? appStore.isDarkModeOn
                            ? white
                            : black
                        : appStore.isDarkModeOn
                            ? white
                            : white,
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                DateHandler.getTime(
                    DateTime.parse(msg.createdAt!).add(Duration(hours: 7))),
                style: secondaryTextStyle(
                  size: 14,
                  color: !isMe
                      ? context.iconColor
                      : appStore.isDarkModeOn
                          ? gray
                          : white,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // double width = MediaQuery.of(context).size.width;
    // double height = MediaQuery.of(context).size.height;

    if (msg.interview != null) {
      print(msg.interview?.title);
      print(msg.interview?.deletedAt);
      print(msg.interview?.disableFlag);
      if (msg.interview?.deletedAt == null || msg.interview?.deletedAt == '')
        return scheduleMeetingWiget(context);
      return SizedBox();
    }
    return messageWidget(context);
  }
}
