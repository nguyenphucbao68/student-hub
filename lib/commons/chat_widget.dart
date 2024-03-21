import 'package:carea/components/schedule_interview_component.dart';
import 'package:carea/main.dart';
import 'package:carea/model/calling_model.dart';
import 'package:carea/screens/meet_screen.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class ChatWidget extends StatelessWidget {
  const ChatWidget({
    Key? key,
    required this.isMe,
    required this.data,
  }) : super(key: key);

  final bool isMe;
  final BHMessageModel data;

  List<Widget> activeMeetingOption(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return [
      130.width,
      GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MeetScreen()),
          );
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 36),
          margin: EdgeInsets.only(top: 12),
          decoration: boxDecorationWithRoundedCorners(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            backgroundColor: appStore.isDarkModeOn ? scaffoldDarkColor : black,
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
      4.width,
      IconButton(
          padding: EdgeInsets.only(top: 10),
          onPressed: () {
            showModalBottomSheet(
              enableDrag: true,
              isDismissible: true,
              isScrollControlled: true,
              constraints: BoxConstraints.expand(
                height: height * 0.15,
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
                                      ScheduleInterviewComponent(
                                        scheduleMeetingCallback: () {},
                                      )),
                            );
                          },
                          child: Text(
                            "Re-schedule the meeting",
                            style: boldTextStyle(color: Colors.black, size: 16),
                          ),
                          style: OutlinedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 12),
                            minimumSize: Size(double.infinity, 0),
                          ),
                        ),
                        SizedBox(height: 10),
                        OutlinedButton(
                          onPressed: () {
                            data.meetingInfo!.isCancel = true;
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Cancel the messages",
                            style: boldTextStyle(color: Colors.black, size: 16),
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
                  data.msg!,
                  style: boldTextStyle(
                      size: 17, color: appStore.isDarkModeOn ? white : black),
                ),
              ),
              8.height,
              Container(
                margin: EdgeInsets.only(bottom: 8),
                padding:
                    EdgeInsets.only(left: 16, right: 8, top: 8, bottom: 12),
                decoration: boxDecorationWithRoundedCorners(
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
                              child: Text(
                                  "Title: " + data.meetingInfo!.scheduleTitle!,
                                  style: boldTextStyle(size: 16))),
                          Text(data.meetingInfo!.duration!,
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
                              "  Start time: " + data.meetingInfo!.startTime!,
                              style: primaryTextStyle(
                                  size: 15,
                                  color: appStore.isDarkModeOn ? white : black),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "  End time: " + data.meetingInfo!.endTime!,
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
                      children: !data.meetingInfo!.isCancel!
                          ? activeMeetingOption(context)
                          : cancelMeetingOption(context),
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
                    ? scaffoldDarkColor
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
                  data.msg!,
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
              Text(
                data.time!,
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
    double height = MediaQuery.of(context).size.height;

    if (data.meetingInfo != null) {
      return scheduleMeetingWiget(context);
    }
    return messageWidget(context);
  }
}