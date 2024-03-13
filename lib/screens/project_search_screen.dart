import 'package:carea/commons/colors.dart';
import 'package:carea/commons/widgets.dart';
import 'package:carea/components/active_component.dart';
import 'package:carea/main.dart';
import 'package:carea/screens/search_delageate.dart';
import 'package:carea/store/logicprovider.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class ProjectSearchScreen extends StatefulWidget {
  const ProjectSearchScreen({Key? key}) : super(key: key);

  @override
  State<ProjectSearchScreen> createState() => _ProjectSearchScreenState();
}

class _ProjectSearchScreenState extends State<ProjectSearchScreen> {
  late LogicProvider observer;

  @override
  void initState() {
    super.initState();
    observer = LogicProvider();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        FocusScope.of(context).unfocus();
        return true;
      },
      child: Scaffold(
        backgroundColor:
            appStore.isDarkModeOn ? scaffoldDarkColor : editTextBgColor,
        appBar: careaAppBarWidget(
          context,
          titleText: "Search for projects",
          actionWidget: IconButton(
            onPressed: () {
              showSearch(
                context: context,
                delegate: CustomSearchDelegate.initialize(""),
              );
            },
            icon: Icon(Icons.search, color: context.iconColor, size: 25),
          ),
        ),
        body: new ActiveComponent(),
      ),
    );
  }
}
