import 'dart:convert';

import 'package:carea/commons/widgets.dart';
import 'package:carea/constants/app_constants.dart';
import 'package:carea/model/experience.dart';
import 'package:carea/screens/input_profile_cv_screen.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:carea/main.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:provider/provider.dart';
import 'package:carea/store/authprovider.dart';
import 'package:http/http.dart' as http;

enum Operation {
  Add,
  Edit,
}

class InputProfileExperience extends StatefulWidget {
  const InputProfileExperience({super.key});

  @override
  State<InputProfileExperience> createState() => _InputProfileExperienceState();
}

class _InputProfileExperienceState extends State<InputProfileExperience> {
  final List<MultiSelectController> _multiSelectControllerList = [];
  late AuthProvider authStore;
  List<Experience> projectList = [
    // Project(
    //     id: '1',
    //     projectName: 'Intelligent Taxi Dispatching system',
    //     period: '9/2020 - 12/2020, 4 months',
    //     description:
    //         'It is the developer of a super-app for ride-hailing, food delivery, and digital payments services on mobile devices that operates in Singapore, Malaysia, ..'),
    // Project(
    //     id: '2',
    //     projectName: 'Intelligent Taxi Dispatching system',
    //     period: '9/2020 - 12/2020, 4 months',
    //     description:
    //         'It is the developer of a super-app for ride-hailing, food delivery, and digital payments services on mobile devices that operates in Singapore, Malaysia, ..'),
  ];

  final TextEditingController _titleFieldController = TextEditingController();
  final TextEditingController _startMonthFieldController =
      TextEditingController();
  final TextEditingController _endMonthFieldController =
      TextEditingController();
  final TextEditingController _descriptionFieldController =
      TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _formKey1 = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  final _formKey3 = GlobalKey<FormState>();

  final FocusNode _focusLanguage = FocusNode();

  bool _isLoading = false;

  @override
  void didChangeDependencies() {
    authStore = Provider.of<AuthProvider>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBarWidget(context),
      body: Container(
        padding: EdgeInsets.all(12),
        height: context.height(),
        color:
            appStore.isDarkModeOn ? scaffoldDarkColor : gray.withOpacity(0.1),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                "Experience",
                style: boldTextStyle(size: 18),
              ),
              SizedBox(height: 20),
              Text(
                "Tell us about your self and you will be on your way connect with real-world project",
                style: primaryTextStyle(size: 14),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 20,
              ),
              dialogWithTitle(context, title: "Projects", beforeDialogOpen: () {
                _titleFieldController.text = '';
                _descriptionFieldController.text = '';
                _startMonthFieldController.text = '';
                _endMonthFieldController.text = '';
              },
                  childrenWidget: _languagueDialogBody(context,
                      operation: Operation.Add, onHandleSubmit: () {
                    _onAddExperience(
                        title: _titleFieldController.text,
                        desc: _descriptionFieldController.text,
                        startMonth: _startMonthFieldController.text,
                        endMonth: _endMonthFieldController.text);
                    _titleFieldController.text = '';
                    _descriptionFieldController.text = '';
                    _startMonthFieldController.text = '';
                    _endMonthFieldController.text = '';
                    Navigator.pop(context);
                  })),
              projectList.length > 0
                  ? Container(
                      margin: EdgeInsets.only(bottom: 16),
                      padding: EdgeInsets.only(
                          left: 10, right: 10, top: 8, bottom: 8),
                      decoration: boxDecorationWithRoundedCorners(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        backgroundColor: context.cardColor,
                      ),
                      child: ListView(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        padding: const EdgeInsets.all(8),
                        children: projectList.asMap().entries.map((entry) {
                          return Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        entry.value.title!,
                                        style: boldTextStyle(size: 14),
                                      ),
                                      Text(
                                        "${entry.value.startMonth} - ${entry.value.endMonth}",
                                        style: secondaryTextStyle(size: 13),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            setState(() {
                                              setState(() {
                                                _titleFieldController.text =
                                                    entry.value.title!;
                                                _descriptionFieldController
                                                        .text =
                                                    entry.value.description!;
                                                _startMonthFieldController
                                                        .text =
                                                    entry.value.startMonth!;
                                                _endMonthFieldController.text =
                                                    entry.value.endMonth!;
                                              });
                                              showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return Dialog(
                                                      backgroundColor:
                                                          Colors.white,
                                                      child: Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top: 10.0,
                                                                  left: 20.0,
                                                                  right: 20.0,
                                                                  bottom: 15.0),
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            children: _languagueDialogBody(
                                                                context,
                                                                operation:
                                                                    Operation
                                                                        .Edit,
                                                                onHandleSubmit:
                                                                    () {
                                                              _onEditExperienceItem(
                                                                  id: entry.key,
                                                                  title:
                                                                      _titleFieldController
                                                                          .text,
                                                                  desc:
                                                                      _descriptionFieldController
                                                                          .text,
                                                                  startMonth:
                                                                      _startMonthFieldController
                                                                          .text,
                                                                  endMonth:
                                                                      _endMonthFieldController
                                                                          .text);
                                                              Navigator.pop(
                                                                  context);
                                                              _titleFieldController
                                                                  .text = '';
                                                              _descriptionFieldController
                                                                  .text = '';
                                                              _startMonthFieldController
                                                                  .text = '';
                                                              _endMonthFieldController
                                                                  .text = '';
                                                            }),
                                                          )),
                                                    );
                                                  });
                                            });
                                          },
                                          icon: Icon(Icons.edit_outlined)),
                                      IconButton(
                                          onPressed: () {
                                            setState(() {
                                              projectList.removeAt(entry.key);
                                              _multiSelectControllerList[
                                                      entry.key]
                                                  .dispose();
                                              _multiSelectControllerList
                                                  .removeAt(entry.key);
                                            });
                                          },
                                          icon: Icon(Icons.delete_outlined))
                                    ],
                                  )
                                ],
                              ),
                              Text(
                                entry.value.description!,
                                style: primaryTextStyle(size: 15),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              MultiSelectDropDown.network(
                                onOptionSelected:
                                    (List<ValueItem> selectedOptions) {},
                                networkConfig: NetworkConfig(
                                    url:
                                        "${AppConstants.BASE_URL}/skillset/getAllSkillSet",
                                    method: RequestMethod.get,
                                    headers: {
                                      'Content-Type': 'application/json',
                                    }),
                                selectionType: SelectionType.multi,
                                chipConfig: ChipConfig(
                                    wrapType: WrapType.wrap,
                                    backgroundColor: appStore.isDarkModeOn
                                        ? cardDarkColor
                                        : Colors.black),
                                dropdownHeight: 250,
                                optionTextStyle: TextStyle(fontSize: 14),
                                selectedOptionIcon: Icon(Icons.check_circle),
                                selectedOptionTextColor: Colors.black,
                                dropdownMargin: 20.5,
                                searchEnabled: true,
                                borderWidth: 1,
                                controller:
                                    _multiSelectControllerList[entry.key],
                                responseParser: (response) {
                                  final list =
                                      (response["result"] as List<dynamic>)
                                          .map<ValueItem>((e) {
                                    final item = e as Map<String, dynamic>;
                                    return ValueItem(
                                      label: item["name"],
                                      value: item["id"],
                                    );
                                  }).toList();

                                  return Future.value(list);
                                },
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Divider(
                                thickness: 0.4,
                              )
                            ],
                          );
                        }).toList(),
                      ),
                    )
                  : Container(
                      height: 0,
                    ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _isLoading = true;
                  });
                  _handleSubmitForm();
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  // width: MediaQuery.of(context).size.width * 0.4,
                  // margin: EdgeInsets.all(8),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: appStore.isDarkModeOn ? cardDarkColor : Colors.black,
                    borderRadius: BorderRadius.circular(35),
                  ),
                  child: _isLoading
                      ? CircularProgressIndicator()
                      : Text('Next', style: boldTextStyle(color: white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onAddExperience(
      {required String title,
      required String desc,
      required String startMonth,
      required String endMonth}) {
    setState(() {
      projectList.add(Experience(
          title: title,
          description: desc,
          startMonth: startMonth,
          endMonth: endMonth));
      _multiSelectControllerList.add(MultiSelectController());
    });
  }

  List<Widget> _languagueDialogBody(BuildContext context,
      {required Operation operation, required VoidCallback onHandleSubmit}) {
    return [
      Text(
        "${operation.name} experience",
        style: boldTextStyle(),
      ),
      SizedBox(
        height: 15,
      ),
      Align(
        alignment: Alignment.centerLeft,
        child: Text(
          "Project title",
          style: primaryTextStyle(),
        ),
      ),
      SizedBox(
        height: 10,
      ),
      Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _titleFieldController,
                focusNode: _focusLanguage,
                decoration: inputDecoration(context,
                    hintText: "Intelligent Taxi Dispatching system"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              )
            ],
          )),
      SizedBox(
        height: 15,
      ),
      Align(
        alignment: Alignment.centerLeft,
        child: Text(
          "Description",
          style: primaryTextStyle(),
        ),
      ),
      SizedBox(
        height: 10,
      ),
      Form(
          key: _formKey1,
          child: TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            controller: _descriptionFieldController,
            decoration: inputDecoration(context,
                hintText: "Enter description of the project"),
          )),
      SizedBox(
        height: 15,
      ),
      Align(
        alignment: Alignment.centerLeft,
        child: Text(
          "Start month",
          style: primaryTextStyle(),
        ),
      ),
      SizedBox(
        height: 10,
      ),
      Form(
          key: _formKey2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _startMonthFieldController,
                decoration: inputDecoration(context, hintText: "06/2023"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              )
            ],
          )),
      SizedBox(
        height: 15,
      ),
      Align(
        alignment: Alignment.centerLeft,
        child: Text(
          "End month",
          style: primaryTextStyle(),
        ),
      ),
      SizedBox(
        height: 10,
      ),
      Form(
          key: _formKey3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _endMonthFieldController,
                decoration: inputDecoration(context, hintText: "08/2023"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              )
            ],
          )),
      TextButton(
          onPressed: () {
            if (_formKey.currentState!.validate() &&
                _formKey1.currentState!.validate() &&
                _formKey2.currentState!.validate() &&
                _formKey3.currentState!.validate()) {
              onHandleSubmit();
            }
          },
          child: Text(
            operation.name,
            style: primaryTextStyle(),
          ))
    ];
  }

  void _onEditExperienceItem(
      {required int id,
      required String title,
      required String desc,
      required String startMonth,
      required String endMonth}) {
    setState(() {
      projectList[id].title = title;
      projectList[id].description = desc;
      projectList[id].startMonth = startMonth;
      projectList[id].endMonth = endMonth;
    });
  }

  Future<void> _handleSubmitForm() async {
    log(jsonEncode({
      "experience": projectList
          .asMap()
          .entries
          .map((entry) => {
                "title": entry.value.title,
                "startMonth": entry.value.startMonth,
                "endMonth": entry.value.endMonth,
                "description": entry.value.description,
                "skillSets": _multiSelectControllerList[entry.key]
                    .selectedOptions
                    .map((item) => item.value)
                    .toList()
              })
          .toList()
    }));

    await http
        .put(
            Uri.parse(AppConstants.BASE_URL +
                "/experience/updateByStudentId/${authStore.student?.id}"),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'Authorization': 'Bearer ' + authStore.token.toString(),
            },
            body: jsonEncode({
              "experience": projectList
                  .asMap()
                  .entries
                  .map((entry) => {
                        "title": entry.value.title,
                        "startMonth": entry.value.startMonth,
                        "endMonth": entry.value.endMonth,
                        "description": entry.value.description,
                        "skillSets": _multiSelectControllerList[entry.key]
                            .selectedOptions
                            .map((item) => item.value)
                            .toList()
                      })
                  .toList()
            }))
        .then((response) {
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Profile experience updated successfully"),
          ),
        );
        InputProfileCVScreen().launch(context, isNewTask: true);
      }
    });

    setState(() {
      _isLoading = false;
    });
  }
}
