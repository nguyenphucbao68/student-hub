import 'package:carea/main.dart';
import 'package:carea/model/project.dart';
import 'package:carea/screens/project_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:carea/utils/Date.dart';

class ProjectWidget extends StatefulWidget {
  Project? data = Project();
  String? btnText1;
  String? btnText2;

  ProjectWidget({this.data, this.btnText1, this.btnText2});

  @override
  _ProjectWidgetState createState() => _ProjectWidgetState();
}

class _ProjectWidgetState extends State<ProjectWidget> {
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
                    IconButton(
                        icon: Icon(
                            widget.data!.isFavorite
                                ? Icons.favorite_rounded
                                : Icons.favorite_border_rounded,
                            size: 25,
                            color: context.iconColor),
                        onPressed: () {},
                        padding: EdgeInsets.only(left: 5, right: 5)),
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
