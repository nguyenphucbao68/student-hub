class Project {
  // String id;
  // String projectName;
  // String period;
  // String description;
  // String? duration;

  // Project({
  //   required this.id,
  //   required this.projectName,
  //   required this.period,
  //   required this.description,
  //   this.duration
  // });
  // "id": 1,
  //     "createdAt": "2024-04-01T05:03:15.352Z",
  //     "updatedAt": "2024-04-01T05:03:15.352Z",
  //     "deletedAt": null,
  //     "companyId": "31",
  //     "projectScopeFlag": 0,
  //     "title": "Fullstack developer",
  //     "description": "description of the project",
  //     "numberOfStudents": 0,
  //     "typeFlag": 0
  int? id;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? companyId;
  int? projectScopeFlag;
  String? title;
  String? description;
  int? numberOfStudents;
  int? typeFlag;

  Project(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.companyId,
      this.projectScopeFlag,
      this.title,
      this.description,
      this.numberOfStudents,
      this.typeFlag});
}
