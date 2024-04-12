// class UserInfo {
//   String userFullName;
//   String userNickName;
//   String userDateOfBirth;
//   String userEmail;
//   String userContactNumber;
//   String userGender;
//   String userImage;

//   UserInfo(
//     this.userFullName,
//     this.userNickName,
//     this.userDateOfBirth,
//     this.userEmail,
//     this.userContactNumber,
//     this.userGender,
//     this.userImage,
//   );
// }

class UserInfo {
  int? id;
  String? fullName;
  int? currentRole;
  dynamic roles;
  dynamic student;
  dynamic company;
  UserInfo({
    this.id,
    this.fullName,
    this.roles,
    this.student,
    this.company,
  });
}

class Student {
  int? id;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  int? userId;
  int? techStackId;
  dynamic resume;
  dynamic transcript;
  dynamic user;
  dynamic techStack;
  dynamic educations;
  Student({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.userId,
    this.techStackId,
    this.resume,
    this.transcript,
    this.user,
    this.techStack,
    this.educations,
  });
}

class Proposal {
  int? id;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  int? projectId;
  int? studentId;
  String? coverLetter;
  int? statusFlag;
  int? disableFlag;
  Student? student;
  Proposal({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.projectId,
    this.studentId,
    this.coverLetter,
    this.statusFlag,
    this.disableFlag,
    this.student,
  });
}
