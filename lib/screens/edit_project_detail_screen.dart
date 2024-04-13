import 'dart:convert';
import 'dart:io';

import 'package:carea/commons/widgets.dart';
import 'package:carea/components/manage_project_detail_component.dart';
import 'package:carea/constants/app_constants.dart';
import 'package:carea/main.dart';
import 'package:carea/model/project.dart';
import 'package:carea/screens/manage_project_screen.dart';
import 'package:carea/screens/welcome_screen.dart';
import 'package:carea/store/authprovider.dart';
import 'package:carea/store/profile_ob.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class EditProjectDetailScreen extends StatefulWidget {
  EditProjectDetailScreen({Key? key}) : super(key: key);
  @override
  State<EditProjectDetailScreen> createState() =>
      _EditProjectDetailScreenState();
}

class _EditProjectDetailScreenState extends State<EditProjectDetailScreen> {
  final _formKey = GlobalKey<FormState>();
  late AuthProvider authStore;
  late ProfileOb profi;

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController numbStdController = TextEditingController();

  FocusNode f1 = FocusNode();
  FocusNode f2 = FocusNode();

  final List<String> timeList = [
    "1 to 3 months",
    "3 to 6 months",
  ];
  var time = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    authStore = Provider.of<AuthProvider>(context);
    profi = Provider.of<ProfileOb>(context);
    titleController.text = profi.projectInfo!.title!;
    time = timeList[profi.projectInfo!.projectScopeFlag!];
    numbStdController.text = profi.projectInfo!.numberOfStudents.toString();
    descriptionController.text = profi.projectInfo!.description!;
  }

  void hadleUpdateProject() async {
    final title = titleController.text;
    final scopeFlag = timeList.indexOf(time);
    final numbStd = int.tryParse(numbStdController.text) ?? 1;
    final desc = descriptionController.text;
    int projectID = profi.projectInfo!.id!;
    await http
        .patch(
      Uri.parse(AppConstants.BASE_URL + '/project/$projectID'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ' + authStore.token.toString(),
      },
      body: jsonEncode({
        "title": title,
        "numberOfStudents": numbStd,
        "projectScopeFlag": scopeFlag,
        "description": desc
      }),
    )
        .then((response) {
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        if (data['result'] != null) {
          profi.setProjectInfo(Project.clone(
              id: data['result']['id'],
              createdAt: data['result']['createdAt'],
              updatedAt: data['result']['updatedAt'],
              deletedAt: data['result']['deletedAt'],
              companyId: data['result']['companyId'],
              projectScopeFlag: data['result']['projectScopeFlag'],
              title: data['result']['title'],
              description: data['result']['description'],
              numberOfStudents: data['result']['numberOfStudents'],
              typeFlag: data['result']['typeFlag'],
              proposals: data['result']['proposals'],
              countProposals: data['result']['countProposals'],
              countMessages: data['result']['countMessages'],
              countHired: data['result']['countHired']));
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => ManageProjectScreen(index: 1)),
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
          titleText: "Student Hub",
          actionWidget: IconButton(
              onPressed: () {},
              icon: Icon(Icons.search, color: context.iconColor)),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(16),
            alignment: Alignment.center,
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text("Project title",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15)),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: titleController,
                    focusNode: f1,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your post title';
                      }
                      return null;
                    },
                    onFieldSubmitted: (v) {
                      f1.unfocus();
                      FocusScope.of(context).requestFocus(f1);
                    },
                    decoration: inputDecoration(context,
                        hintText: "Write a title for your post"),
                  ),
                  SizedBox(height: 15),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text("How long will your project take",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15)),
                  ),
                  SizedBox(height: 15),
                  SizedBox(
                    height: timeList.length * (55 + 10),
                    child: ListView.separated(
                      controller: ScrollController(),
                      itemCount: timeList.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 2),
                      itemBuilder: (context, index) => Container(
                        margin: EdgeInsets.only(bottom: 8),
                        decoration: boxDecorationWithRoundedCorners(
                          borderRadius:
                              BorderRadius.all(Radius.circular(defaultRadius)),
                          backgroundColor: Colors.grey.shade200,
                        ),
                        padding: EdgeInsets.symmetric(vertical: 6),
                        child: RadioListTile(
                          visualDensity: VisualDensity(
                              horizontal: VisualDensity.minimumDensity,
                              vertical: VisualDensity.minimumDensity),
                          title: Row(
                            children: [
                              // SizedBox(width: 16),
                              Text(timeList[index], style: primaryTextStyle()),
                            ],
                          ),
                          controlAffinity: ListTileControlAffinity.trailing,
                          value: timeList[index],
                          groupValue: time,
                          activeColor: context.iconColor,
                          hoverColor: Colors.black,
                          onChanged: (value) {
                            setState(() {
                              time = value.toString();
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                        "How many students do you want for this project",
                        style: boldTextStyle(size: 15)),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: numbStdController,
                    focusNode: f2,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter number of student';
                      }
                      return null;
                    },
                    onFieldSubmitted: (v) {
                      f2.unfocus();
                      FocusScope.of(context).requestFocus(f2);
                    },
                    decoration: inputDecoration(context,
                        hintText: "Number of students"),
                  ),
                  SizedBox(height: 15),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text("Description",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15)),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: descriptionController,
                    minLines: 3,
                    maxLines: 3,
                    decoration:
                        inputDecoration(context, hintText: "Description"),
                  ),
                  SizedBox(height: 30),
                  GestureDetector(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        hadleUpdateProject();
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        color: appStore.isDarkModeOn
                            ? cardDarkColor
                            : Colors.white,
                        borderRadius: BorderRadius.circular(45),
                        border: Border.all(
                          color: Colors.black,
                          width: 2,
                        ),
                      ),
                      child: Text('Edit', style: boldTextStyle(color: black)),
                    ),
                  ),
                  SizedBox(height: 8),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        color: appStore.isDarkModeOn
                            ? cardDarkColor
                            : Colors.black,
                        borderRadius: BorderRadius.circular(45),
                      ),
                      child: Text('Cancel', style: boldTextStyle(color: white)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
