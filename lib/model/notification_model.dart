import 'package:carea/constants/app_constants.dart';
import 'package:carea/model/interview_model.dart';
import 'package:carea/model/meeting_room_model.dart';
import 'package:carea/model/message.dart';
import 'package:carea/model/user_info.dart';

class Notification {
  int? id;
  String? createdAt;
  String? updatedAt;
  String? title;
  String? notifyFlag;
  NOTIFICATION_TYPE? typeNotifyFlag;
  String? content;
  Message? message;
  User? sender;
  User? receiver;
  Interview? interview;
  MeetingRoom? meetingRoom;

  Notification({
    this.content,
    this.createdAt,
    this.id,
    this.interview,
    this.meetingRoom,
    this.message,
    this.notifyFlag,
    this.receiver,
    this.sender,
    this.title,
    this.typeNotifyFlag,
    this.updatedAt
  });

  Notification parse(props) {
    return Notification(
      content: props["content"],
      createdAt: props["createdAt"],
      id: props["id"],
      interview: props["interview"],
      meetingRoom: props["meetingRoom"],
      message: props["message"] != null ? Message().parse(props["message"]) : null,
      notifyFlag: props["notifyFlag"],
      receiver: props["receiver"] != null ? User().parse(props["receiver"]) : null,
      sender: props["sender"] != null ? User().parse(props["sender"]) : null,
      title: props["title"],
      typeNotifyFlag: getNotificationType(props["typeNotifyFlag"]),
      updatedAt: props["updatedAt"],
    );
  }

  NOTIFICATION_TYPE getNotificationType(String type) {
    switch (type) {
      case "0":
        return NOTIFICATION_TYPE.OFFER;

      case "1":
        return NOTIFICATION_TYPE.INTERVIEW;

      case "2":
        return NOTIFICATION_TYPE.SUBMITTED;

      case "3":
        return NOTIFICATION_TYPE.CHAT;

      default:
        return NOTIFICATION_TYPE.UNKNOWN_TYPE;
    }
  }
}