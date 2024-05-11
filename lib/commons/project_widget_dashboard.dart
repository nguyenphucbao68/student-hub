import 'dart:convert';

import 'package:carea/constants/app_constants.dart';
import 'package:carea/main.dart';
import 'package:carea/model/project.dart';
import 'package:carea/screens/dashboard_screen.dart';
import 'package:carea/screens/edit_project_detail_screen.dart';
import 'package:carea/screens/manage_project_screen.dart';
import 'package:carea/store/authprovider.dart';
import 'package:carea/store/profile_ob.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class ProjectWidgetDashboard extends StatefulWidget {
  Project data;
  int? proposalId;

  ProjectWidgetDashboard({required this.data, this.proposalId});

  @override
  _ProjectWidgetDashboardState createState() => _ProjectWidgetDashboardState();
}

class _ProjectWidgetDashboardState extends State<ProjectWidgetDashboard> {
  late ProfileOb profi;
  late AuthProvider authStore;

  void didChangeDependencies() {
    super.didChangeDependencies();
    authStore = Provider.of<AuthProvider>(context);
  }

  void onStartWorkingThisProject() async {
    if (widget.proposalId == null) {
      return;
    }
    log('start working this project');
    log(widget.proposalId.toString());
    await http
        .patch(
      Uri.parse(AppConstants.BASE_URL + '/proposal/${widget.proposalId}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ' + authStore.token.toString(),
      },
      body: jsonEncode(<String, int>{
        'statusFlag': 3,
      }),
    )
        .then((response) {
      log(response.statusCode.toString());
      log(response.body.toString());
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("You have started working on this project"),
          ),
        );
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => HomeScreen(defaultPage: 1)));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(response.statusCode.toString()),
          ),
        );
      }
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Something wrong'),
        ),
      );
    });
  }

  void handleDeleteProject() async {
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () async {
        int? projectID = widget.data.id;
        if (projectID == null) return;
        await http.delete(
          Uri.parse(AppConstants.BASE_URL + '/project/$projectID'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer ' + authStore.token.toString(),
          },
        ).then((response) {
          if (response.statusCode == 200) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Project deleted"),
              ),
            );
          } else {
            print(response.statusCode);
          }
        }).catchError((error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(error.toString()),
            ),
          );
        });
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text("Warning"),
      content: Text("Do you want to delete this project?"),
      actions: [
        okButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Widget buildActionButtons() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: profi.currentRole == UserRole.COMPANY
          ? [
              // Add View proposals item
              OutlinedButton(
                onPressed: () {
                  profi.setProjectInfo(widget.data);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ManageProjectScreen(
                              tabIndex: 0,
                            )),
                  );
                },
                child: Text(
                  appStore.viewProposals,
                  style:
                      boldTextStyle(color: appStore.textPrimaryColor, size: 16),
                ),
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  minimumSize: Size(double.infinity, 0),
                ),
              ),
              SizedBox(height: 10),
              // View Messages
              OutlinedButton(
                onPressed: () {
                  profi.setProjectInfo(widget.data);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ManageProjectScreen(tabIndex: 2)),
                  );
                },
                child: Text(
                  appStore.viewMessages,
                  style:
                      boldTextStyle(color: appStore.textPrimaryColor, size: 16),
                ),
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  minimumSize: Size(double.infinity, 0),
                ),
              ),
              SizedBox(height: 10),
              // View hired
              OutlinedButton(
                onPressed: () {
                  profi.setProjectInfo(widget.data);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ManageProjectScreen(tabIndex: 3)),
                  );
                },
                child: Text(
                  appStore.viewHired,
                  style:
                      boldTextStyle(color: appStore.textPrimaryColor, size: 16),
                ),
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  minimumSize: Size(double.infinity, 0),
                ),
              ),
              SizedBox(height: 10),
              // add a border line
              Container(
                height: 1,
                color: Colors.black87,
              ),
              SizedBox(height: 10),
              // View job posting
              OutlinedButton(
                onPressed: () {
                  profi.setProjectInfo(widget.data);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ManageProjectScreen(tabIndex: 1)),
                  );
                },
                child: Text(
                  appStore.viewJobPosting,
                  style:
                      boldTextStyle(color: appStore.textPrimaryColor, size: 16),
                ),
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  minimumSize: Size(double.infinity, 0),
                ),
              ),
              SizedBox(height: 10),
              // Edit posting
              OutlinedButton(
                onPressed: () {
                  profi.setProjectInfo(widget.data);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EditProjectDetailScreen()),
                  );
                },
                child: Text(
                  appStore.editPosting,
                  style:
                      boldTextStyle(color: appStore.textPrimaryColor, size: 16),
                ),
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  minimumSize: Size(double.infinity, 0),
                ),
              ),

              SizedBox(height: 10),
              // Remove posting
              OutlinedButton(
                onPressed: () {
                  handleDeleteProject();
                },
                child: Text(
                  appStore.removePosting,
                  style:
                      boldTextStyle(color: appStore.textPrimaryColor, size: 16),
                ),
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  minimumSize: Size(double.infinity, 0),
                ),
              ),
              SizedBox(height: 10),
              Container(
                height: 1,
                color: Colors.black87,
              ),
              SizedBox(height: 10),
              OutlinedButton(
                onPressed: () {
                  profi.setProjectInfo(widget.data);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ManageProjectScreen()),
                  );
                },
                child: Text(
                  appStore.manageProject,
                  style:
                      boldTextStyle(color: appStore.textPrimaryColor, size: 16),
                ),
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  minimumSize: Size(double.infinity, 0),
                ),
              ),
            ]
          : [
              OutlinedButton(
                onPressed: () {
                  onStartWorkingThisProject();
                },
                child: Text(
                  appStore.startWorkingThisProject,
                  style:
                      boldTextStyle(color: appStore.textPrimaryColor, size: 16),
                ),
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  minimumSize: Size(double.infinity, 0),
                ),
              )
            ],
    );
  }

  @override
  Widget build(BuildContext context) {
    profi = Provider.of<ProfileOb>(context);
    int ytd = DateTime.now()
        .difference(DateTime.parse(widget.data.createdAt.toString()))
        .inDays;
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 16),
      decoration: boxDecorationWithRoundedCorners(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        backgroundColor: context.cardColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // space between
              children: <Widget>[
                Expanded(
                    flex: 1,
                    child: Text(widget.data.title.toString(),
                        style: boldTextStyle(size: 16))),
                IconButton(
                  icon: Icon(Icons.more_horiz,
                      size: 25, color: context.iconColor),
                  // onPressed: () {},
                  onPressed: () {
                    // query = '';
                    showModalBottomSheet(
                      enableDrag: true,
                      isDismissible: true,
                      isScrollControlled: true,
                      // constraints: BoxConstraints(
                      //     maxHeight: height * 0.45,
                      //     maxWidth: width,
                      //     minHeight: height * 0.45,
                      //     minWidth: width),
                      // shape: RoundedRectangleBorder(
                      //   borderRadius: BorderRadius.vertical(),
                      // ),
                      context: context,
                      builder: (context) {
                        return SingleChildScrollView(
                          child: Container(
                            padding: EdgeInsets.all(8),
                            // decoration: BoxDecoration(
                            //   color: context.scaffoldBackgroundColor,
                            //   borderRadius: BorderRadius.only(
                            //       topLeft: Radius.circular(8),
                            //       topRight: Radius.circular(8)),
                            // ),
                            child: buildActionButtons(),
                          ),
                        );
                      },
                    );
                  },
                  // padding: EdgeInsets.only(left: 15)
                ),
              ],
            ),
          ),
          5.height,
          Text(
              ytd > 0
                  ? appStore.isVi
                      ? "Đã tạo $ytd ngày trước"
                      : "Created $ytd days ago"
                  : appStore.isVi
                      ? "Tạo Hôm nay"
                      : "Created today",
              style: primaryTextStyle(
                  size: 14, color: appStore.textSecondaryColor)),
          SizedBox(height: 5),
          new Container(
            width: MediaQuery.of(context).size.width * 0.8,
            padding: EdgeInsets.symmetric(vertical: 8),
            child: new Text(
              widget.data.description.toString(),
              style: secondaryTextStyle(),
            ),
          ),
          10.height,
          // check if widget.data!.countProposals is not null and is a number
          widget.data.countProposals != null
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 90,
                      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                      decoration: boxDecorationWithRoundedCorners(
                        backgroundColor: appStore.isDarkModeOn
                            ? scaffoldDarkColor
                            : gray.withOpacity(0.3),
                      ),
                      child: Column(
                        children: [
                          Text(widget.data.countProposals.toString(),
                              style: primaryTextStyle()),
                          Text(appStore.proposal,
                              style: primaryTextStyle(size: 12)),
                        ],
                      ),
                    ),
                    Container(
                      width: 90,
                      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                      decoration: boxDecorationWithRoundedCorners(
                        backgroundColor: appStore.isDarkModeOn
                            ? scaffoldDarkColor
                            : gray.withOpacity(0.3),
                      ),
                      child: Column(
                        children: [
                          Text(widget.data.countMessages.toString(),
                              style: primaryTextStyle()),
                          Text(appStore.message,
                              style: primaryTextStyle(size: 12)),
                        ],
                      ),
                    ),
                    Container(
                      width: 90,
                      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                      decoration: boxDecorationWithRoundedCorners(
                        backgroundColor: appStore.isDarkModeOn
                            ? scaffoldDarkColor
                            : gray.withOpacity(0.3),
                      ),
                      child: Column(
                        children: [
                          Text(widget.data.countHired.toString(),
                              style: primaryTextStyle()),
                          Text(appStore.hired,
                              style: primaryTextStyle(size: 12)),
                        ],
                      ),
                    ),
                  ],
                )
              : SizedBox(),
        ],
      ),
    );
  }
}
