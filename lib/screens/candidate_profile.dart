import 'dart:convert';

import 'package:carea/commons/widgets.dart';
import 'package:carea/constants/app_constants.dart';
import 'package:carea/main.dart';
import 'package:carea/model/student.dart';
import 'package:carea/model/user_info.dart';
import 'package:carea/screens/login_with_pass_screen.dart';
import 'package:carea/screens/profile_input_ahaa_screen.dart';
import 'package:carea/screens/profile_input_nhap_screen.dart';
import 'package:carea/store/authprovider.dart';
import 'package:carea/store/profile_ob.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

class CandidateProfileScreen extends StatefulWidget {
  // add studentId as a param
  final int? studentId;
  const CandidateProfileScreen({Key? key, required this.studentId})
      : super(key: key);
  @override
  _CandidateProfileScreenState createState() => _CandidateProfileScreenState();
}

class _CandidateProfileScreenState extends State<CandidateProfileScreen> {
  late AuthProvider auth;
  late AuthProvider authStore;
  late ProfileOb profi;
  bool showRow = false;
  bool showInfoStudentRow = false;
  bool showExperienceRow = false;
  bool showEducationRow = false;
  bool showLanguageRow = false;
  bool showSkillSetRow = false;
  Student candidate = Student();
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    authStore = Provider.of<AuthProvider>(context);
    profi = Provider.of<ProfileOb>(context);
    init();
  }

  void init() async {
    await getCandidateInfo();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  Future<void> getCandidateInfo() async {
    if (widget.studentId == null) {
      return;
    }
    await http.get(
      Uri.parse(AppConstants.BASE_URL +
          '/profile/student/' +
          widget.studentId.toString()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ' + authStore.token.toString(),
      },
    ).then((response) {
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        if (data['result'] != null) {
          setState(() {
            candidate =
                Student().tryParseWithFullnameAndEmail(data['result']) ??
                    Student();
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // log("authStore.company" + authStore.company.toString());
    return Scaffold(
      appBar: careaAppBarWidget(
        context,
        titleText: candidate.fullname ?? "",
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: 16),
        child: Column(
          children: [
            SizedBox(height: 16),

            SizedBox(height: 8),
            Text(candidate.email ?? "", style: boldTextStyle(size: 18)),
            SizedBox(height: 8),
            Text(candidate.techStack?.name ?? "", style: secondaryTextStyle()),
            SizedBox(height: 16),
            SettingItemWidget(
              leading: Icon(Icons.person_2, color: context.iconColor),
              title: "Experiences",
              titleTextStyle: boldTextStyle(),
              onTap: () {
                setState(() {
                  showExperienceRow = !showExperienceRow;
                });
              },
              trailing: showExperienceRow
                  ? Transform.rotate(
                      angle: 3.14 / 2, // Độ xoay 90 độ
                      child: Icon(Icons.arrow_forward_ios_rounded,
                          size: 18, color: context.iconColor))
                  : Icon(Icons.arrow_forward_ios_rounded,
                      size: 18, color: context.iconColor),
            ),
            SizedBox(
              width: 340,
              child: showExperienceRow
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: candidate.experiences!.map((e) {
                        return SettingItemWidget(
                          leading: Icon(Icons.work, color: context.iconColor),
                          title: e.title ?? "",
                          titleTextStyle: boldTextStyle(),
                          trailing: Text(
                            e.startMonth! + " - " + e.endMonth!,
                            style: secondaryTextStyle(),
                          ),
                        );
                      }).toList(),
                    )
                  : null,
            ),
            // EDUCATION
            SettingItemWidget(
              leading: Icon(Icons.school, color: context.iconColor),
              title: "Educations",
              titleTextStyle: boldTextStyle(),
              onTap: () {
                setState(() {
                  showEducationRow = !showEducationRow;
                });
              },
              trailing: showEducationRow
                  ? Transform.rotate(
                      angle: 3.14 / 2, // Độ xoay 90 độ
                      child: Icon(Icons.arrow_forward_ios_rounded,
                          size: 18, color: context.iconColor))
                  : Icon(Icons.arrow_forward_ios_rounded,
                      size: 18, color: context.iconColor),
            ),
            SizedBox(
              width: 340,
              child: showEducationRow
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: candidate.educations!.map((e) {
                        return SettingItemWidget(
                          leading: Icon(Icons.school, color: context.iconColor),
                          title: e.schoolName ?? "",
                          titleTextStyle: boldTextStyle(),
                          trailing: Text(
                            e.startYear!.toString() +
                                " - " +
                                e.endYear!.toString(),
                            style: secondaryTextStyle(),
                          ),
                        );
                      }).toList(),
                    )
                  : null,
            ),
            // LANGUAGE
            SettingItemWidget(
              leading: Icon(Icons.language, color: context.iconColor),
              title: "Languages",
              titleTextStyle: boldTextStyle(),
              onTap: () {
                setState(() {
                  showLanguageRow = !showLanguageRow;
                });
              },
              trailing: showLanguageRow
                  ? Transform.rotate(
                      angle: 3.14 / 2, // Độ xoay 90 độ
                      child: Icon(Icons.arrow_forward_ios_rounded,
                          size: 18, color: context.iconColor))
                  : Icon(Icons.arrow_forward_ios_rounded,
                      size: 18, color: context.iconColor),
            ),
            SizedBox(
              width: 340,
              child: showLanguageRow
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: candidate.languages!.map((e) {
                        return SettingItemWidget(
                          leading:
                              Icon(Icons.language, color: context.iconColor),
                          title: e.languageName ?? "",
                          titleTextStyle: boldTextStyle(),
                          trailing: Text(
                            e.level ?? "",
                            style: secondaryTextStyle(),
                          ),
                        );
                      }).toList(),
                    )
                  : null,
            ),
            // SKILL SET
            SettingItemWidget(
              leading: Icon(Icons.star, color: context.iconColor),
              title: "Skill Sets",
              titleTextStyle: boldTextStyle(),
              onTap: () {
                setState(() {
                  showSkillSetRow = !showSkillSetRow;
                });
              },
              trailing: showSkillSetRow
                  ? Transform.rotate(
                      angle: 3.14 / 2, // Độ xoay 90 độ
                      child: Icon(Icons.arrow_forward_ios_rounded,
                          size: 18, color: context.iconColor))
                  : Icon(Icons.arrow_forward_ios_rounded,
                      size: 18, color: context.iconColor),
            ),
            SizedBox(
              width: 340,
              child: showSkillSetRow
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: candidate.skillSets!.map((e) {
                        return SettingItemWidget(
                          leading: Icon(Icons.star, color: context.iconColor),
                          title: e.name ?? "",
                          titleTextStyle: boldTextStyle(),
                        );
                      }).toList(),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
