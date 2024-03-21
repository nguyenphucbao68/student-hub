import 'package:carea/commons/colors.dart';
import 'package:carea/components/active_component.dart';
import 'package:carea/components/completed_component.dart';
import 'package:carea/main.dart';
import 'package:carea/screens/project_search_screen.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class ProjectsFragment extends StatefulWidget {
  @override
  _ProjectsFragmentState createState() => _ProjectsFragmentState();
}

class _ProjectsFragmentState extends State<ProjectsFragment>
    with SingleTickerProviderStateMixin {
  TabController? tabController;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    tabController = new TabController(length: 2, vsync: this);
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor:
            appStore.isDarkModeOn ? scaffoldDarkColor : editTextBgColor,
        appBar: AppBar(
          backgroundColor: context.scaffoldBackgroundColor,
          leading: Transform.scale(
            scale: 0.7,
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: context.iconColor),
              onPressed: () {
                finish(context);
              },
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProjectSearchScreen()),
                );
              },
              icon: Icon(Icons.search, color: context.iconColor),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.chat, color: context.iconColor),
            ),
          ],
          title: Text("Saved Projects", style: boldTextStyle(size: 18)),
          elevation: 0.0,
        ),
        body: new ActiveComponent(),
      ),
    );
  }
}
