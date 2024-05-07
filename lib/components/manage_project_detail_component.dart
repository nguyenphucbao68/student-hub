import 'dart:convert';
import 'package:carea/commons/widgets.dart';
import 'package:carea/constants/app_constants.dart';
import 'package:carea/main.dart';
import 'package:carea/model/project.dart';
import 'package:carea/screens/dashboard_screen.dart';
import 'package:carea/screens/edit_project_detail_screen.dart';
import 'package:carea/store/authprovider.dart';
import 'package:carea/store/profile_ob.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class ManageProjectDetailComponent extends StatefulWidget {
  const ManageProjectDetailComponent({super.key});
  @override
  State<ManageProjectDetailComponent> createState() =>
      _ManageProjectDetailComponentState();
}

class _ManageProjectDetailComponentState
    extends State<ManageProjectDetailComponent> {
  late AuthProvider authStore;
  late ProfileOb profi;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    authStore = Provider.of<AuthProvider>(context);
    super.didChangeDependencies();
  }

  void handleCloseProject() async {
    if (profi.projectInfo == null) return;
    int? projectID = profi.projectInfo!.id;
    await http.delete(
      Uri.parse(AppConstants.BASE_URL + '/project/$projectID'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ' + authStore.token.toString(),
      },
    ).then((response) {
      if (response.statusCode == 200) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
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
  }

  @override
  Widget build(BuildContext context) {
    profi = Provider.of<ProfileOb>(context);
    return SingleChildScrollView(
      child: Container(
        color: context.scaffoldBackgroundColor,
        padding: EdgeInsets.only(bottom: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.only(left: 16),
              child: Align(
                  alignment: Alignment.topLeft,
                  child: Text("Description", style: boldTextStyle())),
            ),
            SizedBox(height: 10),
            Text.rich(
              TextSpan(
                style: secondaryTextStyle(),
                text: profi.projectInfo!.description!,
              ),
            ).paddingOnly(right: 16, left: 16),
            SizedBox(height: 25),
            Padding(
              padding: EdgeInsets.only(left: 16),
              child: Align(
                  alignment: Alignment.topLeft,
                  child: Text("Extra Information", style: boldTextStyle())),
            ),
            SizedBox(height: 5),
            ListTile(
              contentPadding: EdgeInsets.only(left: 16),
              leading: Icon(Icons.alarm_rounded, size: 30),
              title: Text("Project Scope", style: boldTextStyle()),
              subtitle: Text(
                profi.projectInfo!.projectScopeFlag ==
                        ProjectScopeFlagToNum[ProjectScopeFlag.OneToThreeMonth]
                    ? "1 to 3 months"
                    : "3 to 6 months",
                style: secondaryTextStyle(),
              ),
            ),
            ListTile(
              contentPadding: EdgeInsets.only(left: 16),
              leading: Icon(Icons.people, size: 30),
              title: Text("Student required", style: boldTextStyle()),
              subtitle: Text(
                profi.projectInfo!.numberOfStudents.toString() + " students",
                style: secondaryTextStyle(),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.width * 0.015),
            Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  new Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditProjectDetailScreen()),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(35),
                          border: Border.all(
                            color: Colors.black,
                            width: 1.0,
                          ),
                        ),
                        child: Text('Edit project',
                            style: boldTextStyle(color: Colors.black)),
                      ),
                    ),
                  ),
                  new SizedBox(width: 10),
                  new Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () {
                        handleCloseProject();
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: appStore.isDarkModeOn
                              ? cardDarkColor
                              : Colors.black,
                          borderRadius: BorderRadius.circular(35),
                        ),
                        child: Text('Close project',
                            style: boldTextStyle(color: white)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
