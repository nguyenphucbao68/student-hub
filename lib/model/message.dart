import 'package:carea/model/interview_model.dart';

import 'package:carea/model/user_info.dart';
import 'package:carea/model/project.dart';

class Message {
  int? id;
  String? createdAt;
  String? updateAt;
  String? deleteAt;
  String? content;
  int? messageFlag;
  User? sender;
  User? receiver;
  Project? project;
  Interview? interview;
  String? formatedDate;

  Message(
      {this.id,
      this.createdAt,
      this.updateAt,
      this.content,
      this.deleteAt,
      this.interview,
      this.messageFlag,
      this.receiver,
      this.sender,
      this.project,
      this.formatedDate});
}
