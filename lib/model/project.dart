import 'package:carea/model/proposal.dart';

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
  bool isFavorite = false;
  dynamic proposals;
  int? countProposals;
  int? countMessages;
  int? countHired;

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
      this.proposals,
      this.countProposals,
      this.countMessages,
      this.countHired,
      this.isFavorite = false});

  Project parse(dynamic item) {
    return Project(
      id: item['id'],
      createdAt: item['createdAt'],
      updatedAt: item['updatedAt'],
      deletedAt: item['deletedAt'],
      companyId: item['companyId'],
      projectScopeFlag: item['projectScopeFlag'],
      title: item['title'],
      description: item['description'],
      typeFlag: item['typeFlag'],
      numberOfStudents: item['numberOfStudents'],
      countProposals: item['countProposals'],
      countMessages: item['countMessages'],
      countHired: item['countHired'],
    );
  }

  Project? tryParse(dynamic item) {
    if (item == null) return null;
    return Project().parse(item);
  }

  Project parseWithProposal(dynamic item) {
    return Project(
      id: item['id'],
      createdAt: item['createdAt'],
      updatedAt: item['updatedAt'],
      deletedAt: item['deletedAt'],
      companyId: item['companyId'],
      projectScopeFlag: item['projectScopeFlag'],
      title: item['title'],
      description: item['description'],
      typeFlag: item['typeFlag'],
      numberOfStudents: item['numberOfStudents'],
      proposals: Proposal().parseToList(item['proposals']),
      countProposals: item['countProposals'],
      countMessages: item['countMessages'],
      countHired: item['countHired'],
    );
  }

  Project? tryParseWithProposal(dynamic item) {
    if (item == null) return null;
    return Project().parseWithProposal(item);
  }
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
