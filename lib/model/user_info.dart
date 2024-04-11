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
