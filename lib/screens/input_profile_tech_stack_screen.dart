import 'package:carea/commons/widgets.dart';
import 'package:carea/main.dart';
import 'package:carea/screens/input_profile_experience_screen.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:carea/model/language.dart';
import 'package:carea/model/education.dart';

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
  final List<String> items = [
    'Front-end Engineer',
    'Back-end Engineer',
    'Fullstack Engineer',
    'Java Engineer',
    'Quality Engineer',
    'Business Analyst',
    'Scrum Master',
    'Principal Engineer',
  ];

  final List<String> skillSetList = [
    'iOS Developer',
    'C',
    'C++',
    'Java',
    'Kubernetes',
    'PostgreSQL',
    'Redis',
    'Android',
    'NodeJS',
    'Objective-C',
    'React Native',
    'React',
    'Video',
    'Microservices',
  ];

  List<Language> languageList = [];
  List<Education> educationList = [];

  String? selectedValue;
  final TextEditingController textEditingController = TextEditingController();
  final MultiSelectController _multiSelectController = MultiSelectController();
  final TextEditingController _languagesTextEdittingController =
      TextEditingController();

  final TextEditingController _educationTextEditingController =
      TextEditingController();
  final TextEditingController _periodTextEdittingController =
      TextEditingController();

  final FocusNode _focusLanguage = FocusNode();
  final FocusNode _focusEducation = FocusNode();

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                      .items
                      .map((value) => DropdownMenuItem(
                            value: value,
                            child: Text(
                              value,
                              style: primaryTextStyle(),
                            ),
                          ))
                      .toList(),
                  value: selectedValue,
                  onChanged: (value) {
                    setState(() {
                      selectedValue = value.toString();
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
                        return item.value
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
                MultiSelectDropDown(
                  controller: _multiSelectController,
                  onOptionSelected: (List<ValueItem> selectedOptions) {},
                  options: skillSetList
                      .map((e) => ValueItem(label: e, value: e))
                      .toList(),
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
                ),
                SizedBox(
                  height: 15,
                ),
                dialogWithTitle(context, title: "Languages",
                    beforeDialogOpen: () {
                  _languagesTextEdittingController.text = "";
                },
                    childrenWidget: _languagueDialogBody(context,
                        operation: Operation.Add, onHandleLanguageSkill: () {
                      _onAddEnglighSkill(_languagesTextEdittingController.text);
                      Navigator.pop(context);
                      _languagesTextEdittingController.text = "";
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
                          children: languageList.map((value) {
                            return Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      value.text,
                                      style: primaryTextStyle(size: 14),
                                    ),
                                    Row(
                                      children: [
                                        IconButton(
                                            onPressed: () {
                                              setState(() {
                                                _languagesTextEdittingController
                                                    .text = value.text;
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
                                                                  _languagesTextEdittingController
                                                                      .text,
                                                                  value.id);
                                                              Navigator.pop(
                                                                  context);
                                                              _languagesTextEdittingController
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
                                                languageList.removeWhere(
                                                    (element) =>
                                                        element.id == value.id);
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
                          children: educationList.map((value) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      value.schoolName,
                                      style: primaryTextStyle(size: 14),
                                    ),
                                    Text(
                                      value.period,
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
                                                .text = value.schoolName;
                                            _periodTextEdittingController.text =
                                                value.period;
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
                                                          _onEditEducation(
                                                              value.id,
                                                              _educationTextEditingController
                                                                  .text,
                                                              _periodTextEdittingController
                                                                  .text);
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
                                            educationList.removeWhere(
                                                (element) =>
                                                    element.id == value.id);
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
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) => RegistrationScreen()),
                    // );
                    InputProfileExperience().launch(context, isNewTask: true);
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
                    child: Text('Next', style: boldTextStyle(color: white)),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  void _onAddEnglighSkill(String value) {
    setState(() {
      languageList.add(Language(
          id: DateTime.now().millisecondsSinceEpoch.toString(), text: value));
    });
  }

  void _onEditEnglishSkill(String value, String id) {
    setState(() {
      languageList = languageList.map((e) {
        if (e.id == id) {
          e.text = value;
        }
        return e;
      }).toList();
    });
  }

  void _onAddEducation(String schoolName, String period) {
    setState(() {
      educationList.add(Education(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          schoolName: schoolName,
          period: period));
    });
  }

  void _onEditEducation(String id, String schoolName, String period) {
    setState(() {
      educationList = educationList.map((e) {
        if (e.id == id) {
          e.period = period;
          e.schoolName = schoolName;
        }
        return e;
      }).toList();
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
      TextFormField(
        controller: _languagesTextEdittingController,
        focusNode: _focusLanguage,
        decoration:
            inputDecoration(context, hintText: "English: Native or Bilingual"),
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
      TextFormField(
        controller: _educationTextEditingController,
        focusNode: _focusEducation,
        decoration: inputDecoration(context,
            hintText: "School name: Le Hong Phong High School"),
      ),
      SizedBox(
        height: 15,
      ),
      TextFormField(
        controller: _periodTextEdittingController,
        decoration: inputDecoration(context, hintText: "Period: 2014-2016"),
      ),
      TextButton(
          onPressed: onHandleEducation,
          child: Text(
            "Add",
            style: primaryTextStyle(),
          ))
    ];
  }
}
