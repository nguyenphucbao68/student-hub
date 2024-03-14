import 'package:carea/commons/colors.dart';
import 'package:carea/components/project_filter_component.dart';
import 'package:carea/main.dart';
import 'package:carea/model/calling_model.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class ProjectWidgetDashboard extends StatefulWidget {
  CallingModel? data = CallingModel();
  String? btnText1;
  String? btnText2;

  ProjectWidgetDashboard({this.data, this.btnText1, this.btnText2});

  @override
  _ProjectWidgetDashboardState createState() => _ProjectWidgetDashboardState();
}

class _ProjectWidgetDashboardState extends State<ProjectWidgetDashboard> {
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
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
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
                    child: Text("Senior frontend developer (Fintech)",
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
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  OutlinedButton(
                                    onPressed: () {},
                                    child: Text(
                                      "View proposals",
                                      style: boldTextStyle(
                                          color: Colors.black, size: 16),
                                    ),
                                    style: OutlinedButton.styleFrom(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 12),
                                      minimumSize: Size(double.infinity, 0),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  OutlinedButton(
                                    onPressed: () {},
                                    child: Text(
                                      "View messages",
                                      style: boldTextStyle(
                                          color: Colors.black, size: 16),
                                    ),
                                    style: OutlinedButton.styleFrom(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 12),
                                      minimumSize: Size(double.infinity, 0),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  OutlinedButton(
                                    onPressed: () {},
                                    child: Text(
                                      "View hired",
                                      style: boldTextStyle(
                                          color: Colors.black, size: 16),
                                    ),
                                    style: OutlinedButton.styleFrom(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 12),
                                      minimumSize: Size(double.infinity, 0),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  OutlinedButton(
                                    onPressed: () {},
                                    child: Text(
                                      "View job posting",
                                      style: boldTextStyle(
                                          color: Colors.black, size: 16),
                                    ),
                                    style: OutlinedButton.styleFrom(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 12),
                                      minimumSize: Size(double.infinity, 0),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  OutlinedButton(
                                    onPressed: () {},
                                    child: Text(
                                      "Edit posting",
                                      style: boldTextStyle(
                                          color: Colors.black, size: 16),
                                    ),
                                    style: OutlinedButton.styleFrom(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 12),
                                      minimumSize: Size(double.infinity, 0),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  OutlinedButton(
                                    onPressed: () {},
                                    child: Text(
                                      "Remove posting",
                                      style: boldTextStyle(
                                          color: Colors.black, size: 16),
                                    ),
                                    style: OutlinedButton.styleFrom(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 12),
                                      minimumSize: Size(double.infinity, 0),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                    padding: EdgeInsets.only(left: 15)),
              ],
            ),
          ),
          Text("Created 3 days ago", style: primaryTextStyle(size: 15)),
          SizedBox(height: 5),
          new Container(
            width: MediaQuery.of(context).size.width * 0.8,
            padding: EdgeInsets.symmetric(vertical: 8),
            child: new Column(
              children: <Widget>[
                new Text(
                  "Students are looking for\n"
                  "  - Clear expectation about your project or deliverables",
                  style: secondaryTextStyle(),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text("6", style: primaryTextStyle()),
                  Text("Proposals", style: primaryTextStyle()),
                ],
              ),
              Container(
                width: 100,
                padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                decoration: boxDecorationWithRoundedCorners(
                  backgroundColor: appStore.isDarkModeOn
                      ? scaffoldDarkColor
                      : gray.withOpacity(0.3),
                ),
                child: Column(
                  children: [
                    Text("8", style: primaryTextStyle()),
                    Text("Messages", style: primaryTextStyle()),
                  ],
                ),
              ),
              Container(
                width: 100,
                padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                decoration: boxDecorationWithRoundedCorners(
                  backgroundColor:
                      appStore.isDarkModeOn ? scaffoldDarkColor : Colors.black,
                ),
                child: Column(
                  children: [
                    Text("2", style: primaryTextStyle(color: Colors.white)),
                    Text("Hired", style: primaryTextStyle(color: Colors.white)),
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
