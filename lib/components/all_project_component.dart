import 'dart:convert';

import 'package:carea/commons/project_widget_dashboard.dart';
import 'package:carea/store/profile_ob.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:carea/constants/app_constants.dart';
import 'package:carea/model/project.dart';
import 'package:carea/store/authprovider.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class AllProjectComponents extends StatefulWidget {
  String? titleProject;
  bool? isStudent;
  AllProjectComponents({this.titleProject, this.isStudent = false});
  @override
  _AllProjectComponentsState createState() => _AllProjectComponentsState();
}

class _AllProjectComponentsState extends State<AllProjectComponents> {
  late AuthProvider authStore;
  late ProfileOb profi;

  List<Project> projectData = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    authStore = Provider.of<AuthProvider>(context);
    profi = Provider.of<ProfileOb>(context);
    // profi.addListener()
    init();
  }

  void init() async {
    await getProjects();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  Future<void> getProjects() async {
    print('cc');
    print(profi.userInfo?.company);
    if (profi.userInfo?.company == null) return;
    int companyID = profi.userInfo?.company['id'];
    await http.get(
      Uri.parse(AppConstants.BASE_URL + '/project/company/$companyID'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ' + authStore.token.toString(),
      },
    ).then((response) {
      // log(response.body);
      if (response.statusCode == 200) {
        // If the server returns an OK response, then parse the JSON.
        var data = jsonDecode(response.body);
        if (data['result'] != null) {
          setState(() {
            projectData = data['result']
                .map<Project>((item) => Project.clone(
                    id: item['id'],
                    createdAt: item['createdAt'],
                    updatedAt: item['updatedAt'],
                    deletedAt: item['deletedAt'],
                    companyId: item['companyId'],
                    projectScopeFlag: item['projectScopeFlag'],
                    title: item['title'],
                    description: item['description'],
                    numberOfStudents: item['numberOfStudents'],
                    typeFlag: item['typeFlag'],
                    proposals: item['proposals'],
                    countProposals: item['countProposals'],
                    countMessages: item['countMessages'],
                    countHired: item['countHired']))
                .toList();
          });
          print(projectData);
        } else {
          log('error');
          // show error message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(data['message']),
            ),
          );
        }
      } else {
        // If the server returns an error response, then throw an exception.
        // throw Exception('Something wrong');
        log('Something wrong');
      }
    }).catchError((error) {
      log('Something wrong' + error.toString());
      // show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Something wrong'),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileOb>(builder: (context, profi, child) {
      getProjects();
      return ListView.builder(
        shrinkWrap: true,
        itemCount: projectData.length,
        padding: EdgeInsets.only(left: 16, bottom: 16, right: 16, top: 24),
        itemBuilder: (context, index) {
          Project data = projectData[index];

          return ProjectWidgetDashboard(
              data: data, btnText1: "In Delivery", btnText2: "Track order");
        },
      );
    });
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
  //     if (widget.isStudent == true) 16.height,
  //     if (widget.isStudent == true)
  //       Container(
  //         padding: EdgeInsets.only(left: 16, right: 16),
  //         child: Text(
  //           "Active Project (1)",
  //           style: boldTextStyle(size: 14, color: Colors.black45),
  //           textAlign: TextAlign.left,
  //         ),
  //       ),

  //     if (widget.isStudent == true)
  //       ListView.builder(
  //         shrinkWrap: true,
  //         itemCount: 1,
  //         padding: EdgeInsets.only(left: 16, bottom: 16, right: 16, top: 16),
  //         itemBuilder: (context, index) {
  //           Project data = projectData[index];

  //           return ProjectWidgetDashboard(
  //               //common
  //               data: data,
  //               btnText1: "In Delivery",
  //               btnText2: "Track order");
  //         },
  //       ),
  //     // add hr
  //     if (widget.isStudent == true)
  //       Divider(
  //         color: Colors.white,
  //         height: 0,
  //         thickness: 1,
  //         indent: 16,
  //         endIndent: 16,
  //       ),
  //     if (widget.isStudent == true) 16.height,
  //     if (widget.isStudent == true)
  //       Container(
  //         padding: EdgeInsets.only(left: 16, right: 16),
  //         child: Text(
  //           "Submitted Projects (5)",
  //           style: boldTextStyle(size: 14, color: Colors.black45),
  //           textAlign: TextAlign.left,
  //         ),
  //       ),
  //     ListView.builder(
  //       shrinkWrap: true,
  //       physics: AlwaysScrollableScrollPhysics(),
  //       itemCount: projectData.length,
  //       padding: EdgeInsets.only(left: 16, bottom: 16, right: 16, top: 16),
  //       itemBuilder: (context, index) {
  //         Project data = projectData[index];

  //         return ProjectWidgetDashboard(
  //             //common
  //             data: data,
  //             btnText1: "In Delivery",
  //             btnText2: "Track order");
  //       },
  //     )
  //   ]);
  // }
}
