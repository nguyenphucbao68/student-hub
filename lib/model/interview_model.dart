import 'package:carea/model/project.dart';
import 'package:carea/model/user_info.dart';

class Interview {
  int? id;
  String? deletedAt;
  String? title;
  String? startTime;
  String? endTime;
  int? disableFlag;
  int? meetingRoomId;
  MeetingRoom? meetingRoom;

  Interview(
      {this.id,
      this.deletedAt,
      this.title,
      this.startTime,
      this.endTime,
      this.disableFlag,
      this.meetingRoomId,
      this.meetingRoom});

  Interview? tryParse(dynamic data) {
    if (data == null) return null;
    return Interview(
      id: data['id'],
      deletedAt: data['deletedAt'],
      title: data['title'],
      startTime: data['startTime'],
      endTime: data['endTime'],
      disableFlag: data['disableFlag'],
      meetingRoomId: data['meetingRoomId'],
      meetingRoom: MeetingRoom().tryParse(data['meetingRoom']),
    );
  }

  Interview? tryParseWithMeetingRoom(dynamic data) {
    if (data == null) return null;
    return Interview(
      id: data['id'],
      deletedAt: data['deletedAt'],
      title: data['title'],
      startTime: data['startTime'],
      endTime: data['endTime'],
      disableFlag: data['disableFlag'],
      meetingRoomId: data['meetingRoomId'],
      meetingRoom: MeetingRoom().tryParse(data['meetingRoom']),
    );
  }
}

class MeetingRoom {
  int? id;
  String? meetingRoomCode;
  String? meetingRoomId;
  String? expiredAt;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  MeetingRoom(
      {this.id, this.meetingRoomCode, this.meetingRoomId, this.expiredAt, this.createdAt, this.deletedAt, this.updatedAt});

  MeetingRoom? tryParse(dynamic data) {
    if (data == null) return null;
    return MeetingRoom(
      id: data['id'],
      meetingRoomCode: data['meeting_room_code'],
      meetingRoomId: data['meeting_room_id'],
      expiredAt: data['expired_at'],
      createdAt: data['createdAt'],
      updatedAt: data['updatedAt'],
      deletedAt: data['deletedAt'],
    );
  }
}
