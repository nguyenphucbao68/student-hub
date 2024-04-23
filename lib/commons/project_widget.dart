import 'dart:convert';

import 'package:carea/constants/app_constants.dart';
import 'package:carea/main.dart';
import 'package:carea/model/project.dart';
import 'package:carea/screens/project_details_screen.dart';
import 'package:carea/store/authprovider.dart';
import 'package:carea/store/profile_ob.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:carea/utils/Date.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class ProjectWidget extends StatefulWidget {
  Project? data = Project();
  String? btnText1;
  String? btnText2;

  ProjectWidget({this.data, this.btnText1, this.btnText2});

  @override
  _ProjectWidgetState createState() => _ProjectWidgetState();
}

class _ProjectWidgetState extends State<ProjectWidget> {
  late AuthProvider authStore;
  late ProfileOb profi;

  @override
  void initState() {
    super.initState();
  }

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    authStore = Provider.of<AuthProvider>(context);
    profi = Provider.of<ProfileOb>(context);
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  Future<void> addToFavorites() async {
    log("widget" + widget.data!.id.toString());
    await http
        .patch(
      Uri.parse(AppConstants.BASE_URL +
          '/favoriteProject/' +
          profi.user!.student!.id.toString()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ' + authStore.token.toString(),
      },
      body: jsonEncode(<String, dynamic>{
        'projectId': widget.data!.id!,
        "disableFlag": widget.data!.isFavorite ? 1 : 0,
      }),
    )
        .then((response) {
      log(response.body);
      if (response.statusCode == 200) {
        // If the server returns an OK response, then parse the JSON.

        setState(() {
          widget.data!.isFavorite = !widget.data!.isFavorite;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Added to favorites"),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Failed to add to favorites"),
          ),
        );
      }
    }).catchError((error) {
      log('Failed to login' + error.toString());
      // show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to login'),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    authStore = Provider.of<AuthProvider>(context);

    return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProjectDetailScreen(
                      data: widget.data,
                    )),
          );
        },
        child: Container(
          margin: EdgeInsets.only(bottom: 16),
          padding: EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 16),
          decoration: boxDecorationWithRoundedCorners(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            backgroundColor: context.cardColor,
          ),
          // onPress

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
                        child: Text(widget.data!.title!,
                            style: boldTextStyle(size: 16))),
                    profi.currentRole == UserRole.STUDENT
                        ? IconButton(
                            icon: Icon(
                                widget.data!.isFavorite
                                    ? Icons.favorite_rounded
                                    : Icons.favorite_border_rounded,
                                size: 25,
                                color: context.iconColor),
                            onPressed: () {
                              addToFavorites();
                            },
                            padding: EdgeInsets.only(left: 5, right: 5))
                        : Text(""),
                  ],
                ),
              ),

              6.height,
              Row(
                children: [
                  Row(
                    children: [
                      Icon(Icons.people, size: 15, color: context.iconColor),
                      4.width,
                      Text(
                          widget.data!.numberOfStudents.toString() +
                              " students",
                          style: secondaryTextStyle()),
                      12.width,
                      Icon(Icons.alarm, size: 15, color: context.iconColor),
                      4.width,
                      Text(
                          widget.data!.projectScopeFlag == 0
                              ? "1-3 months"
                              : "3-6 months",
                          style: secondaryTextStyle()),
                    ],
                  ),
                  8.width,
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    decoration: boxDecorationWithRoundedCorners(
                      backgroundColor: appStore.isDarkModeOn
                          ? scaffoldDarkColor
                          : gray.withOpacity(0.3),
                    ),
                    child: Text(
                        DateHandler.getDateTimeDifference(
                            DateTime.parse(widget.data!.createdAt!)),
                        style: primaryTextStyle(size: 12)),
                  ),
                ],
              ),
              12.height,
              // Text for project description
              new Container(
                width: MediaQuery.of(context).size.width * 0.8,
                padding: EdgeInsets.symmetric(vertical: 8),
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Text(
                      widget.data!.description!,
                      style: secondaryTextStyle(),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  // Text("Proposals: <5", style: boldTextStyle()),
                  // 16.width,
                  // padding-top: 10

                  GestureDetector(
                    onTap: () {
                      //
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                      margin: EdgeInsets.only(top: 10),
                      decoration: boxDecorationWithRoundedCorners(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        backgroundColor:
                            appStore.isDarkModeOn ? scaffoldDarkColor : black,
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.file_present, size: 12, color: white),
                          3.width,
                          Text(
                              "Proposals: " +
                                  widget.data!.countProposals.toString(),
                              style: primaryTextStyle(size: 12, color: white))
                        ],
                      ),
                      // child: Text("Proposals: 5",
                      //     style: primaryTextStyle(size: 12, color: white)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
