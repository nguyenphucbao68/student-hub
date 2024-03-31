import 'package:carea/commons/data_provider.dart';
import 'package:carea/commons/project_widget.dart';
import 'package:carea/commons/project_widget_dashboard.dart';
import 'package:carea/model/calling_model.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class AllProjectComponents extends StatefulWidget {
  String? titleProject;
  bool? isStudent;
  AllProjectComponents({this.titleProject, this.isStudent = false});
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
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      if (widget.isStudent == true) 16.height,
      if (widget.isStudent == true)
        Container(
          padding: EdgeInsets.only(left: 16, right: 16),
          child: Text(
            "Active Project (1)",
            style: boldTextStyle(size: 14, color: Colors.black45),
            textAlign: TextAlign.left,
          ),
        ),

      if (widget.isStudent == true)
        ListView.builder(
          shrinkWrap: true,
          itemCount: 1,
          padding: EdgeInsets.only(left: 16, bottom: 16, right: 16, top: 16),
          itemBuilder: (context, index) {
            CallingModel data = projectData[index];

            return ProjectWidgetDashboard(
                //common
                data: data,
                btnText1: "In Delivery",
                btnText2: "Track order");
          },
        ),
      // add hr
      if (widget.isStudent == true)
        Divider(
          color: Colors.white,
          height: 0,
          thickness: 1,
          indent: 16,
          endIndent: 16,
        ),
      if (widget.isStudent == true) 16.height,
      if (widget.isStudent == true)
        Container(
          padding: EdgeInsets.only(left: 16, right: 16),
          child: Text(
            "Submitted Projects (5)",
            style: boldTextStyle(size: 14, color: Colors.black45),
            textAlign: TextAlign.left,
          ),
        ),
      ListView.builder(
        shrinkWrap: true,
        itemCount: projectData.length,
        padding: EdgeInsets.only(left: 16, bottom: 16, right: 16, top: 16),
        itemBuilder: (context, index) {
          CallingModel data = projectData[index];

          return ProjectWidgetDashboard(
              //common
              data: data,
              btnText1: "In Delivery",
              btnText2: "Track order");
        },
      )
    ]);
  }
}
