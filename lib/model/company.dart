class Company {
  int? id;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  int? userId;
  String? companyName;
  String? website;
  int? size;
  String? description;

  Company(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.userId,
      this.companyName,
      this.website,
      this.size,
      this.description});

  Company parse(dynamic data) {
    return Company(
      id: data['id'],
      createdAt: data['createdAt'],
      updatedAt: data['updatedAt'],
      deletedAt: data['deletedAt'],
      userId: data['userId'],
      companyName: data['companyName'],
      website: data['website'],
      size: data['size'],
      description: data['description'],
    );
  }

  Company? tryParse(dynamic data) {
    if (data == null) return null;
    return Company().parse(data);
  }
}

// enum CompanySize {
//   JUST_ME = 0, //"It's just me",
//   SMALL = 1, //'2-9 employees',
//   MEDIUM = 2, //'10-99 employees',
//   LARGE = 3, //'100-1000 employees',
//   VERY_LARGE = 4, //'More than 100 employees',
// }
