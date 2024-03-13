import 'package:carea/commons/colors.dart';
import 'package:carea/commons/constants.dart';
import 'package:carea/commons/data_provider.dart';
import 'package:carea/commons/widgets.dart';
import 'package:carea/main.dart';
import 'package:carea/model/calling_model.dart';
import 'package:carea/store/logicprovider.dart';
import 'package:carea/store/search_delagete_ob.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';

class ProjectFilterComponent extends StatefulWidget {
  @override
  _ProjectFilterComponentState createState() => _ProjectFilterComponentState();
}

class _ProjectFilterComponentState extends State<ProjectFilterComponent> {
  LogicProvider logi = LogicProvider();
  TextEditingController? _studentsNeededController;

  List searchlist = [];

  SearchDelegateOb ob = SearchDelegateOb();
  SearchDelegateOb ob1 = SearchDelegateOb();
  SearchDelegateOb ob2 = SearchDelegateOb();
  SearchDelegateOb ob3 = SearchDelegateOb();

  List<CallingModel> carBrandData = carBrandList();
  List<CallingModel> carConditionData = carConditionList();
  List<CallingModel> carRattingData = carRattingList();

  String? selectedIndex;

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

  int selectedOption = 1;
  bool isIconTrue = false;
  FocusNode f2 = FocusNode();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: context.scaffoldBackgroundColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40), topRight: Radius.circular(40)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16),
            Center(
                child: Text('Sort & Filter',
                    style: boldTextStyle(size: 20),
                    textAlign: TextAlign.center)),
            SizedBox(height: 16),
            Padding(
                padding: EdgeInsets.all(8.0),
                child: Divider(color: primaryColor)),
            Padding(
              padding: EdgeInsets.only(left: 8),
              child: Text(
                textAlign: TextAlign.start,
                'Project length',
                style: boldTextStyle(),
              ),
            ),
            // List of radio buttons to choose project length: Less than one month, 1-3 months, 3-6 months, More than 6 months

            SizedBox(height: 16),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                RadioListTile(
                  title: Text('Less than one month'),
                  value: 1,
                  groupValue: selectedOption,
                  onChanged: (val) {
                    setState(() {
                      selectedOption = val as int;
                    });
                  },
                  tileColor: appStore.isDarkModeOn ? white : cardDarkColor,
                ),
                RadioListTile(
                  title: Text('1-3 months'),
                  value: 2,
                  groupValue: selectedOption,
                  onChanged: (val) {
                    setState(() {
                      selectedOption = val as int;
                    });
                  },
                  tileColor: appStore.isDarkModeOn ? white : cardDarkColor,
                ),
                RadioListTile(
                  title: Text('3-6 months'),
                  value: 3,
                  groupValue: selectedOption,
                  onChanged: (val) {
                    setState(() {
                      selectedOption = val as int;
                    });
                  },
                  tileColor: appStore.isDarkModeOn ? white : cardDarkColor,
                ),
                RadioListTile(
                  title: Text('More than 6 months'),
                  value: 4,
                  groupValue: selectedOption,
                  onChanged: (val) {
                    setState(() {
                      selectedOption = val as int;
                    });
                  },
                  tileColor: appStore.isDarkModeOn ? white : cardDarkColor,
                ),
              ],
            ),
            SizedBox(height: 16),

            Padding(
                padding: EdgeInsets.only(left: 8),
                child: Text('Students needed', style: boldTextStyle())),
            SizedBox(height: 16),
            TextFormField(
              focusNode: f2,
              controller: _studentsNeededController,
              decoration: inputDecoration(context,
                  prefixIcon: Icons.people, hintText: ""),
            ),

            SizedBox(height: 16),
            Padding(
                padding: EdgeInsets.only(left: 8),
                child: Text('Proposals less than', style: boldTextStyle())),
            SizedBox(height: 8),
            TextFormField(
              focusNode: f2,
              controller: _studentsNeededController,
              decoration: inputDecoration(context,
                  prefixIcon: Icons.send, hintText: ""),
            ),
            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    finish(context);
                  },
                  child: Container(
                    width: context.width() * 0.35,
                    padding: EdgeInsets.symmetric(vertical: 12),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: appStore.isDarkModeOn
                          ? dividerDarkColor
                          : primaryColor.shade300,
                      borderRadius: BorderRadius.circular(45),
                    ),
                    child: Text(
                      "Reset",
                      style: boldTextStyle(
                          color: appStore.isDarkModeOn
                              ? white
                              : gray.withOpacity(0.6)),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                GestureDetector(
                  onTap: () {
                    finish(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Apply Filter Successful!'),
                      ),
                    );
                  },
                  child: Container(
                    width: context.width() * 0.35,
                    padding: EdgeInsets.symmetric(vertical: 12),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: appStore.isDarkModeOn ? cardDarkColor : black,
                      borderRadius: BorderRadius.circular(45),
                    ),
                    child: Text("Apply", style: boldTextStyle(color: white)),
                  ),
                ),
              ],
            ),
            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
