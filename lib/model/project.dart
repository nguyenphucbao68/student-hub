class Project {
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
  int countProposals = 0;
  bool isFavorite = false;

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
      this.typeFlag,
      this.countProposals = 0,
      this.isFavorite = false});
}

class ProjectCreate {
  int? companyId;
  int? projectScopeFlag; // time
  String? title;
  String? description;
  int? numberOfStudents;
  int? typeFlag = TypeFlagToNum[TypeFlag.Working];
  //status (working || arichived)

  ProjectCreate(
      {this.projectScopeFlag,
      this.title,
      this.description,
      this.numberOfStudents,
      this.typeFlag});
}

enum StatusFlag {
  Waitting,
  Offer,
  Hired,
}

Map<StatusFlag, int> StatusFlagToNum = {
  StatusFlag.Waitting: 0,
  StatusFlag.Offer: 1,
  StatusFlag.Hired: 2,
};

enum DisableFlag {
  Enable,
  Disable,
}

Map<DisableFlag, int> DisableFlagToNum = {
  DisableFlag.Enable: 0,
  DisableFlag.Disable: 1,
};

enum TypeFlag {
  Working,
  Archieved,
}

Map<TypeFlag, int> TypeFlagToNum = {
  TypeFlag.Working: 0,
  TypeFlag.Archieved: 1,
};

enum ProjectScopeFlag { OneToThreeMonth, ThreeToSixMonth }

Map<ProjectScopeFlag, int> ProjectScopeFlagToNum = {
  ProjectScopeFlag.OneToThreeMonth: 0,
  ProjectScopeFlag.ThreeToSixMonth: 1,
};
