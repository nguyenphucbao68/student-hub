import 'dart:convert';

import 'package:carea/commons/widgets.dart';
import 'package:carea/constants/app_constants.dart';
import 'package:carea/main.dart';
import 'package:carea/model/skill_set.dart';
import 'package:carea/screens/input_profile_experience_screen.dart';
import 'package:carea/store/authprovider.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:carea/model/language.dart';
import 'package:carea/model/education.dart';
import 'package:carea/model/tech_stack.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

enum Operation {
  Add,
  Edit,
}

class InputProfileTechStackScreen extends StatefulWidget {
  const InputProfileTechStackScreen({super.key});

  @override
  State<InputProfileTechStackScreen> createState() =>
      _InputProfileTechStackScreenState();
}

class _InputProfileTechStackScreenState
    extends State<InputProfileTechStackScreen> {
  late AuthProvider authStore;
  final List<TechStack> _techStackItems = [];

  List<Language> languageList = [];
  List<Education> educationList = [];

  TechStack? selectedValue;
  final TextEditingController textEditingController = TextEditingController();
  final MultiSelectController _multiSelectController = MultiSelectController();
  final TextEditingController _firstFieldController = TextEditingController();
  final TextEditingController _secondFieldController = TextEditingController();
  DateRangePickerController _datePickerController = DateRangePickerController();

  final TextEditingController _educationTextEditingController =
      TextEditingController();
  final TextEditingController _periodTextEdittingController =
      TextEditingController();

  final FocusNode _focusLanguage = FocusNode();
  final FocusNode _focusEducation = FocusNode();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    getTechStackItems();
  }

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    authStore = Provider.of<AuthProvider>(context);
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  Future<void> getTechStackItems() async {
    await http.get(
      Uri.parse(AppConstants.BASE_URL + "/techstack/getAllTechStack"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    ).then((response) {
      var data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        setState(() {
          List<TechStack> mappedData = data["result"].map<TechStack>((item) {
            return TechStack(name: item["name"], id: item["id"]);
          }).toList();
          _techStackItems.addAll(mappedData);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    authStore = Provider.of<AuthProvider>(context);
    // _skillSetItems.forEach((element) {
    //   log(element.name);
    // });

    return Scaffold(
        appBar: commonAppBarWidget(
          context,
        ),
        body: Container(
          padding: EdgeInsets.all(12),
          height: context.height(),
          color:
              appStore.isDarkModeOn ? scaffoldDarkColor : gray.withOpacity(0.1),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  "Welcome to Student Hub",
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
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Techstack",
                    style: boldTextStyle(size: 14),
                    textAlign: TextAlign.left,
                  ),
                ),
                DropdownButtonHideUnderline(
                    child: DropdownButton2(
                  isExpanded: true,
                  hint: Text(
                    "Select your main techstack",
                    style: primaryTextStyle(),
                  ),
                  items: this
                      ._techStackItems
                      .map((value) => DropdownMenuItem<TechStack>(
                            value: value,
                            child: Text(
                              value.name!,
                              style: primaryTextStyle(),
                            ),
                          ))
                      .toList(),
                  value: selectedValue,
                  onChanged: (value) {
                    setState(() {
                      selectedValue = value as TechStack?;
                    });
                  },
                  buttonStyleData: ButtonStyleData(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    height: 40,
                    width: 500,
                  ),
                  dropdownStyleData: const DropdownStyleData(
                    maxHeight: 200,
                  ),
                  menuItemStyleData: const MenuItemStyleData(
                    height: 40,
                  ),
                  dropdownSearchData: DropdownSearchData(
                      searchController: textEditingController,
                      searchInnerWidgetHeight: 50,
                      searchInnerWidget: Container(
                        height: 50,
                        padding: EdgeInsets.only(
                          top: 8,
                          bottom: 4,
                          right: 8,
                          left: 8,
                        ),
                        child: TextFormField(
                          expands: true,
                          maxLines: null,
                          controller: textEditingController,
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 8,
                            ),
                            hintText: 'Search for an item...',
                            hintStyle: const TextStyle(fontSize: 12),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                      searchMatchFn: (item, searchValue) {
                        return (item.value as TechStack)
                            .name
                            .toString()
                            .toLowerCase()
                            .contains(searchValue.toLowerCase());
                      }),
                )),
                SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Skillset",
                    style: boldTextStyle(size: 14),
                    textAlign: TextAlign.left,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                MultiSelectDropDown.network(
                  onOptionSelected: (List<ValueItem> selectedOptions) {},
                  networkConfig: NetworkConfig(
                      url: "${AppConstants.BASE_URL}/skillset/getAllSkillSet",
                      method: RequestMethod.get,
                      headers: {
                        'Content-Type': 'application/json',
                      }),
                  selectionType: SelectionType.multi,
                  chipConfig: ChipConfig(
                      wrapType: WrapType.wrap,
                      backgroundColor:
                          appStore.isDarkModeOn ? cardDarkColor : Colors.black),
                  dropdownHeight: 250,
                  optionTextStyle: TextStyle(fontSize: 14),
                  selectedOptionIcon: Icon(Icons.check_circle),
                  selectedOptionTextColor: Colors.black,
                  dropdownMargin: 20.5,
                  searchEnabled: true,
                  borderWidth: 1,
                  controller: _multiSelectController,
                  responseParser: (response) {
                    final list = (response["result"] as List<dynamic>)
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
                  height: 15,
                ),
                dialogWithTitle(context, title: "Languages",
                    beforeDialogOpen: () {
                  _firstFieldController.text = "";
                  _secondFieldController.text = "";
                },
                    childrenWidget: _languagueDialogBody(context,
                        operation: Operation.Add, onHandleLanguageSkill: () {
                      _onAddEnglighSkill(_firstFieldController.text,
                          _secondFieldController.text);
                      Navigator.pop(context);
                      _firstFieldController.text = "";
                      _secondFieldController.text = "";
                    })),
                languageList.length > 0
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
                          children: languageList.asMap().entries.map((entry) {
                            return Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "${entry.value.languageName!}: ${entry.value.level}",
                                      style: primaryTextStyle(size: 14),
                                    ),
                                    Row(
                                      children: [
                                        IconButton(
                                            onPressed: () {
                                              setState(() {
                                                _firstFieldController.text =
                                                    entry.value.languageName!;
                                                _secondFieldController.text =
                                                    entry.value.level!;
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
                                                                onHandleLanguageSkill:
                                                                    () {
                                                              _onEditEnglishSkill(
                                                                  id: entry.key,
                                                                  name:
                                                                      _firstFieldController
                                                                          .text,
                                                                  level:
                                                                      _secondFieldController
                                                                          .text);
                                                              Navigator.pop(
                                                                  context);
                                                              _firstFieldController
                                                                  .text = "";
                                                              _secondFieldController
                                                                  .text = "";
                                                            }),
                                                          )),
                                                    );
                                                  });
                                            },
                                            icon: Icon(Icons.edit_outlined)),
                                        IconButton(
                                            onPressed: () {
                                              setState(() {
                                                languageList
                                                    .removeAt(entry.key);
                                              });
                                            },
                                            icon: Icon(Icons.delete_outlined))
                                      ],
                                    ),
                                  ],
                                ),
                                Divider(
                                  thickness: 0.3,
                                )
                              ],
                            );
                          }).toList(),
                        ),
                      )
                    : Container(
                        height: 0,
                      ),
                SizedBox(
                  height: 15,
                ),
                dialogWithTitle(title: "Education", context,
                    beforeDialogOpen: () {
                  _educationTextEditingController.text = "";
                  _periodTextEdittingController.text = "";
                },
                    childrenWidget: _educationDialogBody(context,
                        operation: Operation.Add, onHandleEducation: () {
                      _onAddEducation(_educationTextEditingController.text,
                          _periodTextEdittingController.text);
                      Navigator.pop(context);
                      _educationTextEditingController.text = "";
                      _periodTextEdittingController.text = "";
                    })),
                educationList.length > 0
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
                          children: educationList.asMap().entries.map((entry) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      entry.value.schoolName!,
                                      style: primaryTextStyle(size: 14),
                                    ),
                                    Text(
                                      "${entry.value.startYear}-${entry.value.endYear}",
                                      style: secondaryTextStyle(size: 13),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          setState(() {
                                            _educationTextEditingController
                                                .text = entry.value.schoolName!;
                                            // _periodTextEdittingController.text =
                                            //     value.period;
                                          });
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return Dialog(
                                                  backgroundColor: Colors.white,
                                                  child: Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 10.0,
                                                          left: 20.0,
                                                          right: 20.0,
                                                          bottom: 15.0),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children:
                                                            _educationDialogBody(
                                                                context,
                                                                operation:
                                                                    Operation
                                                                        .Edit,
                                                                onHandleEducation:
                                                                    () {
                                                          // _onEditEducation(
                                                          //     value.id,
                                                          //     _educationTextEditingController
                                                          //         .text,
                                                          //     _periodTextEdittingController
                                                          //         .text);
                                                          Navigator.pop(
                                                              context);
                                                          _educationTextEditingController
                                                              .text = "";
                                                          _periodTextEdittingController
                                                              .text = "";
                                                        }),
                                                      )),
                                                );
                                              });
                                        },
                                        icon: Icon(Icons.edit_outlined)),
                                    IconButton(
                                        onPressed: () {
                                          setState(() {
                                            educationList.removeAt(entry.key);
                                            // educationList.removeWhere(
                                            //     (element) =>
                                            //         element.id == value.id);
                                          });
                                        },
                                        icon: Icon(Icons.delete_outlined))
                                  ],
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
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) => RegistrationScreen()),
                    // );
<<<<<<< Updated upstream
                    InputProfileExperience().launch(context, isNewTask: true);
=======
>>>>>>> Stashed changes
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    // width: MediaQuery.of(context).size.width * 0.4,
                    // margin: EdgeInsets.all(8),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color:
                          appStore.isDarkModeOn ? cardDarkColor : Colors.black,
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
        ));
  }

  void _onAddEnglighSkill(String name, String level) {
    setState(() {
      languageList.add(Language(
          studentId: authStore.student.id, languageName: name, level: level));
    });
  }

  void _onEditEnglishSkill(
      {required int id, required String name, required String level}) {
    setState(() {
      languageList[id].languageName = name;
      languageList[id].level = level;
    });
  }

  void _onAddEducation(String schoolName, String period) {
    setState(() {
      educationList.add(Education(
          schoolName: schoolName,
          startYear: _datePickerController.selectedRange?.startDate?.year,
          endYear: _datePickerController.selectedRange?.endDate?.year));
    });
  }

  void _onEditEducation(int id, String schoolName, String period) {
    setState(() {
      educationList[id].schoolName = schoolName;
<<<<<<< Updated upstream
      // educationList[id].schoolName = schoolName;
      // educationList = educationList.map((e) {
      //   if (e.id == id) {
      //     e.period = period;
      //     e.schoolName = schoolName;
      //   }
      //   return e;
      // }).toList();
=======
      educationList[id].startYear = startYear;
      educationList[id].endYear = endYear;
>>>>>>> Stashed changes
    });
  }

  List<Widget> _languagueDialogBody(BuildContext context,
      {required Operation operation,
      required VoidCallback onHandleLanguageSkill}) {
    return [
      Text(
        "${operation.name} language",
        style: boldTextStyle(),
      ),
      SizedBox(
        height: 15,
      ),
      Align(
        alignment: Alignment.centerLeft,
        child: Text(
          "Language",
          style: primaryTextStyle(),
        ),
      ),
      SizedBox(
        height: 10,
      ),
      TextFormField(
        controller: _firstFieldController,
        focusNode: _focusLanguage,
        decoration: inputDecoration(context, hintText: "English, Germany, etc"),
      ),
      SizedBox(
        height: 15,
      ),
      Align(
        alignment: Alignment.centerLeft,
        child: Text(
          "Skill level",
          style: primaryTextStyle(),
        ),
      ),
      SizedBox(
        height: 10,
      ),
      TextFormField(
        controller: _secondFieldController,
        decoration: inputDecoration(context, hintText: "Beginner, Medium, etc"),
      ),
      TextButton(
          onPressed: onHandleLanguageSkill,
          child: Text(
            operation.name,
            style: primaryTextStyle(),
          ))
    ];
  }

  List<Widget> _educationDialogBody(BuildContext context,
      {required Operation operation, required VoidCallback onHandleEducation}) {
    return [
      Text(
        "${operation.name} education",
        style: boldTextStyle(),
      ),
      SizedBox(
        height: 15,
      ),
      Align(
        alignment: Alignment.centerLeft,
        child: Text(
          "School name",
          style: primaryTextStyle(),
        ),
      ),
      SizedBox(
        height: 10,
      ),
      TextFormField(
        controller: _educationTextEditingController,
        focusNode: _focusEducation,
        decoration: inputDecoration(context,
            hintText: "Le Hong Phong, Bui Thi Xuan, etc"),
      ),
      SizedBox(
        height: 15,
      ),
      Align(
        alignment: Alignment.centerLeft,
        child: Text(
          "Period",
          style: primaryTextStyle(),
        ),
      ),
      SizedBox(
        height: 10,
      ),
      SfDateRangePicker(
        controller: _datePickerController,
        view: DateRangePickerView.decade,
        selectionMode: DateRangePickerSelectionMode.range,
        allowViewNavigation: false,
      ),
      TextButton(
<<<<<<< Updated upstream
          onPressed: onHandleEducation,
=======
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              if (_datePickerController.selectedRange?.startDate == null ||
                  _datePickerController.selectedRange?.endDate == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Please select the valid range"),
                  ),
                );
              } else if (_datePickerController.selectedRange!.endDate!.year >
                  DateTime.now().year) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                        "End year should be less than or equal to current year"),
                  ),
                );
              } else {
                onHandleEducation();
              }
            }
          },
>>>>>>> Stashed changes
          child: Text(
            "Add",
            style: primaryTextStyle(),
          ))
    ];
  }

<<<<<<< Updated upstream
  int getStudentId() {
    return authStore.student.id!;
=======
  Future<void> _handleSubmitForm() async {
    log(_multiSelectController.selectedOptions);
    log({"techStackId": selectedValue?.id});
    log({
      "skillSets": _multiSelectController.selectedOptions
          .map((item) => item.value)
          .toList()
    });

    log({
      "languages": languageList
          .map((item) =>
              {"languageName": item.languageName, "level": item.level})
          .toList()
    });
    log({
      "education": educationList
          .map((item) => {
                "schoolName": item.schoolName,
                "startYear": item.startYear,
                "endYear": item.endYear
              })
          .toList()
    });
    await http
        .post(Uri.parse(AppConstants.BASE_URL + "/profile/student"),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'Authorization': 'Bearer ' + authStore.token.toString(),
            },
            body: jsonEncode({
              "techStackId": selectedValue?.id,
              "skillSets": _multiSelectController.selectedOptions
                  .map((item) => item.value)
                  .toList()
            }))
        .then((response) {
      if (response.statusCode == 422) {
        // Role  student existed
        log({"studentId": authStore.student?.id});
        http
            .put(
                Uri.parse(AppConstants.BASE_URL +
                    "/profile/student/${authStore.student?.id}"),
                headers: <String, String>{
                  'Content-Type': 'application/json; charset=UTF-8',
                  'Authorization': 'Bearer ' + authStore.token.toString(),
                },
                body: jsonEncode({
                  "techStackId": selectedValue?.id,
                  "skillSets": _multiSelectController.selectedOptions
                      .map((item) => item.value)
                      .toList()
                }))
            .then((response) {
          if (response.statusCode != 200) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Can't update profile. Something went wrong"),
              ),
            );
          }
        });
      }
    });

    await http
        .put(
            Uri.parse(AppConstants.BASE_URL +
                "/language/updateByStudentId/${authStore.student?.id}"),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'Authorization': 'Bearer ' + authStore.token.toString(),
            },
            body: jsonEncode({
              "languages": languageList
                  .map((item) =>
                      {"languageName": item.languageName, "level": item.level})
                  .toList(),
            }))
        .then((response) {
      if (response.statusCode != 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:
                Text("Can't update profile of languague. Something went wrong"),
          ),
        );
      }
    });

    await http
        .put(
            Uri.parse(AppConstants.BASE_URL +
                "/education/updateByStudentId/${authStore.student?.id}"),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'Authorization': 'Bearer ' + authStore.token.toString(),
            },
            body: jsonEncode({
              "education": educationList
                  .map((item) => {
                        "schoolName": item.schoolName,
                        "startYear": item.startYear,
                        "endYear": item.endYear
                      })
                  .toList(),
            }))
        .then((response) {
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Profile techstack updated successfully"),
          ),
        );
        InputProfileExperience().launch(context, isNewTask: true);
      } else if (response.statusCode != 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:
                Text("Can't update profile of education. Something went wrong"),
          ),
        );
      }
    });
    setState(() {
      _isLoading = false;
    });
>>>>>>> Stashed changes
  }
}
