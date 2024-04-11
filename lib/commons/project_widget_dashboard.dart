import 'package:carea/main.dart';
import 'package:carea/model/project.dart';
import 'package:carea/screens/manage_project.dart';
import 'package:carea/store/profile_ob.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class ProjectWidgetDashboard extends StatefulWidget {
  Project? data = Project();
  String? btnText1;
  String? btnText2;

  ProjectWidgetDashboard({this.data, this.btnText1, this.btnText2});

  @override
  _ProjectWidgetDashboardState createState() => _ProjectWidgetDashboardState();
}

class _ProjectWidgetDashboardState extends State<ProjectWidgetDashboard> {
  late ProfileOb profi;
  Widget buildActionButtons() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        OutlinedButton(
          onPressed: () {
            profi.setProjectInfo(widget.data);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ManageProjectScreen()),
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
        ),
        SizedBox(height: 10),
        OutlinedButton(
          onPressed: () {},
          child: Text(
            "View messages",
            style: boldTextStyle(color: Colors.black, size: 16),
          ),
          style: OutlinedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 12),
            minimumSize: Size(double.infinity, 0),
          ),
        ),
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
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
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
                        constraints: BoxConstraints(
                            maxHeight: height * 0.45,
                            maxWidth: width,
                            minHeight: height * 0.45,
                            minWidth: width),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(60),
                              topRight: Radius.circular(60)),
                        ),
                        context: context,
                        builder: (context) {
                          return SingleChildScrollView(
                            child: Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: context.scaffoldBackgroundColor,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                    topRight: Radius.circular(8)),
                              ),
                              child: buildActionButtons(),
                            ),
                          );
                        },
                      );
                    },
                    padding: EdgeInsets.only(left: 15)),
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
          Row(
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
          ),
        ],
      ),
    );
  }
}
