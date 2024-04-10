import 'package:carea/commons/project_widget.dart';
import 'package:carea/model/project.dart';
import 'package:flutter/material.dart';

class ActiveComponent extends StatefulWidget {
  List<Project> data = [
    Project(
        id: 1,
        createdAt: "2024-04-01T05:03:15.352Z",
        updatedAt: "2024-04-01T05:03:15.352Z",
        deletedAt: null,
        companyId: "31",
        projectScopeFlag: 0,
        title: "Fullstack developer",
        description: "description of the project",
        numberOfStudents: 0,
        typeFlag: 0),
    Project(
        id: 2,
        createdAt: "2024-04-01T05:03:15.352Z",
        updatedAt: "2024-04-01T05:03:15.352Z",
        deletedAt: null,
        companyId: "31",
        projectScopeFlag: 0,
        title: "Fullstack developer",
        description: "description of the project",
        numberOfStudents: 0,
        typeFlag: 0),
    Project(
        id: 3,
        createdAt: "2024-04-01T05:03:15.352Z",
        updatedAt: "2024-04-01T05:03:15.352Z",
        deletedAt: null,
        companyId: "31",
        projectScopeFlag: 0,
        title: "Fullstack developer",
        description: "description of the project",
        numberOfStudents: 0,
        typeFlag: 0),
  ];
  ActiveComponent({this.data = const []});

  @override
  _ActiveComponentState createState() => _ActiveComponentState();
}

class _ActiveComponentState extends State<ActiveComponent> {
  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {}

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: widget.data.length,
      padding: EdgeInsets.only(left: 16, bottom: 16, right: 16, top: 24),
      itemBuilder: (context, index) {
        Project data = widget.data[index];

        return ProjectWidget(
            data: data, btnText1: "In Delivery", btnText2: "Track order");
      },
    );
  }
}
