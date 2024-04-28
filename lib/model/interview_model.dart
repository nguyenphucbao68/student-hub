import 'package:carea/model/project.dart';
import 'package:carea/model/user_info.dart';

class Interview {
  int? id;
  String? startTime;
  String? endTime;
  Project? project;
  User? sender;
  User? receiver;
  String? meetingRoomCode;
  String? meetingRoomId;
  String? expiredAt;

  Interview(
      {this.endTime,
      this.expiredAt,
      this.id,
      this.meetingRoomCode,
      this.meetingRoomId,
      this.project,
      this.receiver,
      this.sender,
      this.startTime});
}
