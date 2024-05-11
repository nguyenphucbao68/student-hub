import 'package:carea/model/interview_model.dart';
import 'package:carea/screens/video_conference.dart';
import 'package:carea/utils/Date.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:carea/model/notification.dart' as Noti;

class InterviewNotificationWdiget extends StatefulWidget {
  final Noti.Notification notification;

  InterviewNotificationWdiget({required this.notification});

  @override
  State<InterviewNotificationWdiget> createState() =>
      _InterviewNotificationWdigetState();
}

class _InterviewNotificationWdigetState
    extends State<InterviewNotificationWdiget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: context.cardColor, borderRadius: BorderRadius.circular(20)),
      child: ListTile(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(widget.notification.title!, style: boldTextStyle()),
            SizedBox(height: 10),
            Text(
              widget.notification.content!,
              style: secondaryTextStyle(),
            ),
            SizedBox(height: 10),
            Text(
              DateHandler.getDateTimeDifference(
                  DateTime.parse(widget.notification.createdAt!)),
              style: secondaryTextStyle(size: 14),
            ),
            SizedBox(height: 10),
            if (widget.notification.content != "Interview cancelled")
              ElevatedButton(
                onPressed: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //       builder: (context) => DetailScreen(image: car11)),
                  // );
                  log({
                    'disalbeFlag':
                        widget.notification.message?.interview?.disableFlag
                  });
                  _onJoinClick(widget.notification.message?.interview);
                },
                child: Text("Join", style: boldTextStyle(color: grey)),
              ),
          ],
        ),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(200),
          child: Container(
            height: 50,
            width: 50,
            color: Colors.black,
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.group, color: Colors.white, size: 18),
            ),
          ),
        ),
      ),
    );
  }

  void _onJoinClick(Interview? interview) {
    if (interview == null) {
      return;
    }

    if (interview.disableFlag == 1) {
      Widget okButton = TextButton(
        child: Text("OK"),
        onPressed: () {
          context.pop();
        },
      );

      AlertDialog alert = AlertDialog(
        title: Text("Interview Cancelled"),
        content: Text(
            "Can't join. The interview is cancelled"),
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
    }

    else {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                //  MeetScreen())
                VideoConferencePage(
                    conferenceID: interview.meetingRoom!.meetingRoomCode!)),
      );
    }
   
  }
}
