class MeetingRoom {
  int? id;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? meetingRoomCode;
  String? meetingRoomId;
  String? expiredAt;

  MeetingRoom(
      {this.createdAt,
      this.deletedAt,
      this.expiredAt,
      this.id,
      this.meetingRoomCode,
      this.meetingRoomId,
      this.updatedAt});

  MeetingRoom parse(props) {
    return MeetingRoom(
      createdAt: props['createdAt'],
      deletedAt: props['deletedAt'],
      expiredAt: props['expiredAt'],
      id: props['id'],
      meetingRoomCode: props['meetingRoomCode'],
      meetingRoomId: props['meetingRoomId'],
      updatedAt: props['updatedAt'],
    );
  }
}
