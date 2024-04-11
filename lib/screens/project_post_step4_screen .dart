import 'dart:convert';
import 'package:carea/commons/widgets.dart';
import 'package:carea/constants/app_constants.dart';
import 'package:carea/main.dart';
import 'package:carea/model/project.dart';
import 'package:carea/screens/dashboard_screen.dart';
import 'package:carea/store/authprovider.dart';
import 'package:carea/store/profile_ob.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class ProjectPostStep4Screen extends StatefulWidget {
  // ProjectPostStep4Screen({Key? key, required this.image}) : super(key: key);
  const ProjectPostStep4Screen({super.key});
  // String image = "";

  @override
  State<ProjectPostStep4Screen> createState() => _ProjectPostStep4ScreenState();
}

class _ProjectPostStep4ScreenState extends State<ProjectPostStep4Screen> {
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
    profi = Provider.of<ProfileOb>(context);
  }

  void hadleCreateProject() async {
    await http
        .post(
      Uri.parse(AppConstants.BASE_URL + '/project'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ' + authStore.token.toString(),
      },
      body: jsonEncode({
        "companyId": profi.userInfo?.company['id'],
        "projectScopeFlag": profi.projectCreate?.projectScopeFlag,
        "title": profi.projectCreate?.title,
        "description": profi.projectCreate?.description,
        // "typeFlag": profi.projectCreate?.typeFlag,
        "numberOfStudents": profi.projectCreate?.numberOfStudents,
      }),
    )
        .then((response) {
      if (response.statusCode == 201) {
        var data = jsonDecode(response.body);
        print(data);
        if (data['result'] != null) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(data['message']),
            ),
          );
        }
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
    return WillPopScope(
      onWillPop: () async {
        FocusScope.of(context).unfocus();
        return true;
      },
      child: Scaffold(
        appBar: careaAppBarWidget(
          context,
          titleText: "Project post",
          actionWidget: IconButton(
              onPressed: () {},
              icon: Icon(Icons.person, color: context.iconColor)),
        ),
        body: SingleChildScrollView(
          child: Container(
            color: context.scaffoldBackgroundColor,
            padding: EdgeInsets.only(bottom: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 16),
                  child: Text("4/4  Project detail",
                      style: boldTextStyle(size: 18)),
                ),
                SizedBox(height: 10),
                Align(
                    alignment: Alignment.center,
                    child: Text(profi.projectCreate!.title!,
                        style: boldTextStyle(size: 22))),
                SizedBox(height: 16),
                Padding(
                  padding: EdgeInsets.only(left: 16),
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: Text("Students are looking for",
                          style: boldTextStyle())),
                ),
                SizedBox(height: 10),
                Text.rich(
                  TextSpan(
                    style: secondaryTextStyle(),
                    text: profi.projectCreate!.description!,
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
                    profi.projectCreate!.projectScopeFlag ==
                            ProjectScopeFlagToNum[
                                ProjectScopeFlag.OneToThreeMonth]
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
                    profi.projectCreate!.numberOfStudents.toString() +
                        " students",
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
                            hadleCreateProject();
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
                            child: Text('Post job',
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
        ),
      ),
    );
  }
}
