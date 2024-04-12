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
  TechStack? techStack;
  List<Proposal>? proposals;
  List<Education>? educations;
  List<Language>? languages;
  List<Experience>? experiences;
  List<SkillSet>? skillSets;

  Student(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.userId,
      this.techStackId,
      this.resume,
      this.transcript,
      this.techStack,
      this.proposals,
      this.educations,
      this.languages,
      this.experiences,
      this.skillSets});
}
