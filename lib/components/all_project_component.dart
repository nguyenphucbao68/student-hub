import 'dart:convert';

import 'package:carea/commons/project_widget_dashboard.dart';
import 'package:carea/main.dart';
import 'package:carea/model/proposal.dart';
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
  List<Proposal> proposalsData = [];

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
    if (profi.currentRole == UserRole.COMPANY) {
      await getProjects();
    } else if (profi.currentRole == UserRole.STUDENT) {
      await getProjectsForStudents();
    }
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  Future<void> getProjects() async {
    if (profi.user!.company == null) return;
    // int companyID = profi.userInfo?.company['id'];

    int companyID = profi.user!.company!.id!;
    String urlLink = AppConstants.BASE_URL + '/project/company/$companyID';
    if (widget.titleProject == "working")
      urlLink += "?typeFlag=0";
    else if (widget.titleProject == "archieved") urlLink += "?typeFlag=1";
    await http.get(
      Uri.parse(urlLink),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ' + authStore.token.toString(),
      },
    ).then((response) {
      // log(response.body);
      log(response.statusCode);
      if (response.statusCode == 200) {
        // If the server returns an OK response, then parse the JSON.
        var data = jsonDecode(response.body);
        if (data['result'] != null) {
          setState(() {
            projectData = data['result']
                .map<Project>((item) => Project().parseWithProposal(item))
                .toList();
          });
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

  Future<void> getProjectsForStudents() async {
    log('test');
    if (profi.user!.student == null) return;
    // int companyID = profi.userInfo?.company['id'];
    log('test 2');

    int studentID = profi.user!.student!.id!;
    String urlLink = AppConstants.BASE_URL +
        '/proposal/project/$studentID?offset=0&limit=100';

    await http.get(
      Uri.parse(urlLink),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ' + authStore.token.toString(),
      },
    ).then((response) {
      log(response.body);
      log(response.statusCode);
      if (response.statusCode == 200) {
        // If the server returns an OK response, then parse the JSON.
        var data = jsonDecode(response.body);
        if (data['result'] != null) {
          setState(() {
            proposalsData = Proposal().parseToList(data['result']) ?? [];
            log(proposalsData.toString());
          });
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
      if (profi.currentRole == UserRole.COMPANY) {
        // List<Project> projects = projectData.toList();
        List<Project> projects = [];
        if (widget.titleProject == "all") {
          projects = projectData.where((item) => item.typeFlag == 0).toList();
        } else if (widget.titleProject == "working") {
          projects = projectData.where((item) => item.typeFlag == 1).toList();
        } else if (widget.titleProject == "archieved") {
          projects = projectData.where((item) => item.typeFlag == 2).toList();
        }
        return ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: projects.length,
          padding: EdgeInsets.only(left: 12, bottom: 12, right: 12, top: 20),
          itemBuilder: (context, index) {
            Project data = projects.elementAt(index);

            return ProjectWidgetDashboard(data: data);
          },
        );
      }

      List<Proposal> proposals = [];

      if (widget.titleProject == "working") {
        proposals = proposalsData
            .where((item) => item.disableFlag == 0 && item.statusFlag == 3)
            .toList();
        // return ListView.builder(
        //   shrinkWrap: true,
        //   physics: NeverScrollableScrollPhysics(),
        //   itemCount: proposalsData
        //       .where((item) => item.disableFlag == 0 && item.statusFlag == 3)
        //       .length,
        //   padding: EdgeInsets.only(left: 12, bottom: 12, right: 12, top: 20),
        //   itemBuilder: (context, index) {
        //     Proposal proposal = proposalsData
        //         .where((item) => item.disableFlag == 0 && item.statusFlag == 3)
        //         .elementAt(index);
        //     Project data = proposal.project!;

        //     return ProjectWidgetDashboard(data: data);
        //   },
        // );
      }

      if (widget.titleProject == "archieved") {
        proposals =
            proposalsData.where((item) => item.disableFlag == 1).toList();
      }

      if (widget.titleProject == "working" ||
          widget.titleProject == "archieved") {
        return ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: proposals.length,
          padding: EdgeInsets.only(left: 12, bottom: 12, right: 12, top: 20),
          itemBuilder: (context, index) {
            Proposal proposal = proposals.elementAt(index);
            Project data = proposal.project!;

            return ProjectWidgetDashboard(data: data, proposalId: proposal.id);
          },
        );
      }

      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        if (profi.currentRole == UserRole.STUDENT) 16.height,
        if (profi.currentRole == UserRole.STUDENT)
          Container(
            padding: EdgeInsets.only(left: 12, right: 12),
            child: Text(
              "Active Proposals (${proposalsData.where((item) => item.disableFlag == 0 && item.statusFlag == 1).length})",
              style:
                  boldTextStyle(size: 14, color: appStore.textSecondaryColor),
              textAlign: TextAlign.left,
            ),
          ),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: proposalsData
              .where((item) => item.disableFlag == 0 && item.statusFlag == 1)
              .length,
          padding: EdgeInsets.only(left: 12, bottom: 12, right: 12, top: 20),
          itemBuilder: (context, index) {
            Proposal proposal = proposalsData
                .where((item) => item.disableFlag == 0 && item.statusFlag == 1)
                .elementAt(index);
            Project data = proposal.project!;

            return ProjectWidgetDashboard(data: data, proposalId: proposal.id);
          },
        ),
        if (profi.currentRole == UserRole.STUDENT)
          Container(
            padding: EdgeInsets.only(left: 12, right: 12),
            child: Text(
              "Submitted Proposals (${proposalsData.where((item) => item.disableFlag == 0 && item.statusFlag == 0).length})",
              style:
                  boldTextStyle(size: 14, color: appStore.textSecondaryColor),
              textAlign: TextAlign.left,
            ),
          ),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: proposalsData
              .where((item) => item.disableFlag == 0 && item.statusFlag == 0)
              .length,
          padding: EdgeInsets.only(left: 12, bottom: 12, right: 12, top: 20),
          itemBuilder: (context, index) {
            Proposal proposal = proposalsData
                .where((item) => item.disableFlag == 0 && item.statusFlag == 0)
                .elementAt(index);
            Project data = proposal.project!;

            return ProjectWidgetDashboard(data: data, proposalId: proposal.id);
          },
        )
      ]);
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
