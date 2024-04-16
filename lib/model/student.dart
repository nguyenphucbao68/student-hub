import 'package:carea/model/education.dart';
import 'package:carea/model/experience.dart';
import 'package:carea/model/language.dart';
import 'package:carea/model/proposal.dart';
import 'package:carea/model/skill_set.dart';
import 'package:carea/model/tech_stack.dart';

class Student {
  int? id;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  int? userId;
  int? techStackId;
  String? resume;
  String? transcript;
  String? fullname;
  TechStack? techStack;
  List<Proposal>? proposals;
  dynamic educations;
  dynamic languages;
  dynamic experiences;
  dynamic skillSets;

  Student(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.userId,
      this.techStackId,
      this.resume,
      this.transcript,
      this.fullname,
      this.techStack,
      this.proposals,
      this.educations,
      this.languages,
      this.experiences,
      this.skillSets});

  Student parse(dynamic data) {
    return Student(
      id: data['id'],
      createdAt: data['createdAt'],
      updatedAt: data['updatedAt'],
      deletedAt: data['deletedAt'],
      userId: data['userId'],
      techStackId: data['techStackId'],
      resume: data['resume'],
      transcript: data['transcript'],
      techStack: TechStack().tryParse(data['techStack']),
      proposals: Proposal().parseToList(data['proposals']),
      educations: data['educations'],
      languages: data['languages'],
      experiences: data['experiences'],
      skillSets: data['skillSets'],
    );
  }

  Student parseWithFullname(dynamic data) {
    return Student(
      id: data['id'],
      userId: data['userId'],
      techStackId: data['techStackId'],
      resume: data['resume'],
      transcript: data['transcript'],
      fullname: data['user']['fullname'],
      techStack: TechStack().tryParse(data['techStack']),
      educations: data['educations'],
      languages: data['languages'],
      experiences: data['experiences'],
      skillSets: data['skillSets'],
    );
  }

  Student? tryParse(dynamic data) {
    if (data == null) return null;
    return Student().parse(data);
  }

  Student? tryParseWithFullname(dynamic data) {
    if (data == null) return null;
    return Student().parseWithFullname(data);
  }
}
