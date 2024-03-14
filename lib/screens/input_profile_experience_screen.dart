import 'package:carea/commons/widgets.dart';
import 'package:carea/screens/input_profile_cv_screen.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:carea/main.dart';
import 'package:carea/model/project.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

class InputProfileExperience extends StatefulWidget {
  const InputProfileExperience({super.key});

  @override
  State<InputProfileExperience> createState() => _InputProfileExperienceState();
}

class _InputProfileExperienceState extends State<InputProfileExperience> {
  final MultiSelectController _multiSelectController = MultiSelectController();

  List<Project> projectList = [
    Project(
        id: '1',
        projectName: 'Intelligent Taxi Dispatching system',
        period: '9/2020 - 12/2020, 4 months',
        description:
            'It is the developer of a super-app for ride-hailing, food delivery, and digital payments services on mobile devices that operates in Singapore, Malaysia, ..'),
    Project(
        id: '2',
        projectName: 'Intelligent Taxi Dispatching system',
        period: '9/2020 - 12/2020, 4 months',
        description:
            'It is the developer of a super-app for ride-hailing, food delivery, and digital payments services on mobile devices that operates in Singapore, Malaysia, ..'),
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
              dialogWithTitle(context, title: "Projects", childrenWidget: []),
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
                        children: projectList.map((value) {
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
                                        value.projectName,
                                        style: boldTextStyle(size: 14),
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
                                          onPressed: () {},
                                          icon: Icon(Icons.edit_outlined)),
                                      IconButton(
                                          onPressed: () {},
                                          icon: Icon(Icons.delete_outlined))
                                    ],
                                  )
                                ],
                              ),
                              Text(
                                value.description,
                                style: primaryTextStyle(size: 15),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              MultiSelectDropDown(
                                controller: _multiSelectController,
                                onOptionSelected:
                                    (List<ValueItem> selectedOptions) {},
                                options: skillSetList
                                    .map((e) => ValueItem(label: e, value: e))
                                    .toList(),
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
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //       builder: (context) => RegistrationScreen()),
                  // );
                  InputProfileCVScreen().launch(context, isNewTask: true);
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
                  child: Text('Next', style: boldTextStyle(color: white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
