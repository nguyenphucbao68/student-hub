class Company {
  int? userId;
  String? companyName;
  String? website;
  CompanySize? size;
  String? description;

  Company(
      {this.userId,
      this.companyName,
      this.website,
      this.size,
      this.description});
}

// enum CompanySize {
//   JUST_ME = 0, //"It's just me",
//   SMALL = 1, //'2-9 employees',
//   MEDIUM = 2, //'10-99 employees',
//   LARGE = 3, //'100-1000 employees',
//   VERY_LARGE = 4, //'More than 100 employees',
// }
enum CompanySize {
  JUST_ME(0), //"It's just me",
  SMALL(1), //'2-9 employees',
  MEDIUM(2), //'10-99 employees',
  LARGE(3), //'100-1000 employees',
  VERY_LARGE(4); //'More than 100 employees',

  const CompanySize(this.value);
  final int value;
}
