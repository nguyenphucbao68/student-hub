import 'package:carea/model/project.dart';
import 'package:carea/model/user_info.dart';

class Interview {
  int? id;
  String? title;
  String? startTime;
  String? endTime;
  int? disableFlag;
  int? meetingRoomId;
  MettingRroom? meetingRoom;

  Interview(
      {this.id,
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
      title: data['title'],
      startTime: data['startTime'],
      endTime: data['endTime'],
      disableFlag: data['disableFlag'],
      meetingRoomId: data['meetingRoomId'],
      // meetingRoom: MettingRroom().tryParse(data['meetingRoom']),
    );
  }

  Interview? tryParseWithMeetingRoom(dynamic data) {
    if (data == null) return null;
    return Interview(
      id: data['id'],
      title: data['title'],
      startTime: data['startTime'],
      endTime: data['endTime'],
      disableFlag: data['disableFlag'],
      meetingRoomId: data['meetingRoomId'],
      meetingRoom: MettingRroom().tryParse(data['meetingRoom']),
    );
  }
}

class MettingRroom {
  int? id;
  String? meetingRoomCode;
  String? meetingRoomId;
  String? expiredAt;

  MettingRroom(
      {this.id, this.meetingRoomCode, this.meetingRoomId, this.expiredAt});

  MettingRroom? tryParse(dynamic data) {
    if (data == null) return null;
    return MettingRroom(
      id: data['id'],
      meetingRoomCode: data['meeting_room_code'],
      meetingRoomId: data['meeting_room_id'],
      expiredAt: data['expired_at'],
    );
  }
}
