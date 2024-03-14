import 'package:carea/commons/data_provider.dart';
import 'package:carea/commons/project_widget.dart';
import 'package:carea/commons/project_widget_dashboard.dart';
import 'package:carea/model/calling_model.dart';
import 'package:flutter/material.dart';

class AllProjectComponents extends StatefulWidget {
  String? titleProject;
  AllProjectComponents({this.titleProject});
  @override
  _AllProjectComponentsState createState() => _AllProjectComponentsState();
}

class _AllProjectComponentsState extends State<AllProjectComponents> {
  List<CallingModel> projectData = projectDataList();

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: projectData.length,
      padding: EdgeInsets.only(left: 16, bottom: 16, right: 16, top: 24),
      itemBuilder: (context, index) {
        CallingModel data = projectData[index];

        return ProjectWidgetDashboard(
            //common
            data: data,
            btnText1: "In Delivery",
            btnText2: "Track order");
      },
    );
  }
}
