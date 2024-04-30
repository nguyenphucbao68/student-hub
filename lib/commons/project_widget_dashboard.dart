import 'dart:convert';

import 'package:carea/constants/app_constants.dart';
import 'package:carea/main.dart';
import 'package:carea/model/project.dart';
import 'package:carea/screens/dashboard_screen.dart';
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

  Widget buildActionButtons() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        profi.currentRole == UserRole.COMPANY
            ? OutlinedButton(
                onPressed: () {
                  profi.setProjectInfo(widget.data);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ManageProjectScreen()),
                  );
                },
                child: Text(
                  "Manage project",
                  style: boldTextStyle(color: Colors.black, size: 16),
                ),
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  minimumSize: Size(double.infinity, 0),
                ),
              )
            : SizedBox(),

        profi.currentRole == UserRole.COMPANY
            ? SizedBox(height: 10)
            : SizedBox(),
        profi.currentRole == UserRole.STUDENT
            ? OutlinedButton(
                onPressed: () {
                  onStartWorkingThisProject();
                },
                child: Text(
                  "Start working this project",
                  style: boldTextStyle(color: Colors.black, size: 16),
                ),
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  minimumSize: Size(double.infinity, 0),
                ),
              )
            : SizedBox(),
        // SizedBox(height: 10),
        // OutlinedButton(
        //   onPressed: () {},
        //   child: Text(
        //     "View hired",
        //     style: boldTextStyle(color: Colors.black, size: 16),
        //   ),
        //   style: OutlinedButton.styleFrom(
        //     padding: EdgeInsets.symmetric(vertical: 12),
        //     minimumSize: Size(double.infinity, 0),
        //   ),
        // ),
        // SizedBox(height: 10),
        // OutlinedButton(
        //   onPressed: () {},
        //   child: Text(
        //     "View job posting",
        //     style: boldTextStyle(color: Colors.black, size: 16),
        //   ),
        //   style: OutlinedButton.styleFrom(
        //     padding: EdgeInsets.symmetric(vertical: 12),
        //     minimumSize: Size(double.infinity, 0),
        //   ),
        // ),
        // SizedBox(height: 10),
        // OutlinedButton(
        //   onPressed: () {},
        //   child: Text(
        //     "Edit posting",
        //     style: boldTextStyle(color: Colors.black, size: 16),
        //   ),
        //   style: OutlinedButton.styleFrom(
        //     padding: EdgeInsets.symmetric(vertical: 12),
        //     minimumSize: Size(double.infinity, 0),
        //   ),
        // ),
        // SizedBox(height: 10),
        // OutlinedButton(
        //   onPressed: () {},
        //   child: Text(
        //     "Remove posting",
        //     style: boldTextStyle(color: Colors.black, size: 16),
        //   ),
        //   style: OutlinedButton.styleFrom(
        //     padding: EdgeInsets.symmetric(vertical: 12),
        //     minimumSize: Size(double.infinity, 0),
        //   ),
        // ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    profi = Provider.of<ProfileOb>(context);
    int ytd = DateTime.now()
        .difference(DateTime.parse(widget.data!.createdAt.toString()))
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
                    child: Text(widget.data!.title.toString(),
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
          Text(ytd > 0 ? "Created $ytd days ago" : "Created today",
              style: primaryTextStyle(size: 14, color: Colors.black38)),
          SizedBox(height: 5),
          new Container(
            width: MediaQuery.of(context).size.width * 0.8,
            padding: EdgeInsets.symmetric(vertical: 8),
            child: new Text(
              widget.data!.description.toString(),
              style: secondaryTextStyle(),
            ),
          ),
          10.height,
          // check if widget.data!.countProposals is not null and is a number
          widget.data!.countProposals != null
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
                          Text(widget.data!.countProposals.toString(),
                              style: primaryTextStyle()),
                          Text("Proposals", style: primaryTextStyle(size: 12)),
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
                          Text(widget.data!.countMessages.toString(),
                              style: primaryTextStyle()),
                          Text("Messages", style: primaryTextStyle(size: 12)),
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
                          Text(widget.data!.countHired.toString(),
                              style: primaryTextStyle()),
                          Text("Hired", style: primaryTextStyle(size: 12)),
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
