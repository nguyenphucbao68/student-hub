import 'dart:convert';

import 'package:carea/commons/colors.dart';
import 'package:carea/commons/constants.dart';
import 'package:carea/commons/widgets.dart';
import 'package:carea/components/all_project_component.dart';
import 'package:carea/constants/app_constants.dart';
import 'package:carea/model/project.dart';
import 'package:carea/screens/project_post_step1_screen.dart';
import 'package:carea/screens/switch_account_screen.dart';
import 'package:carea/store/authprovider.dart';
import 'package:carea/store/profile_ob.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

class DashBoardFragment extends StatefulWidget {
  @override
  _DashBoardFragmentState createState() => _DashBoardFragmentState();
}

class _DashBoardFragmentState extends State<DashBoardFragment>
    with SingleTickerProviderStateMixin {
  late double width;
  late AuthProvider authStore;
  late ProfileOb profi;

  List<Project> projects = [];

  TabController? tabController;
  // late TabController _tabController;

  final tabs = const [
    Tab(text: 'All projects'),
    Tab(text: 'Working'),
    Tab(text: 'Archieved'),
  ];

  List textColor = List.generate(
    listOfCarName.length,
    (index) => primaryBlackColor,
  ).toList();

  List bgColor = List.generate(
    listOfCarName.length,
    (index) => primaryWhiteColor,
  ).toList();

  @override
  void initState() {
    super.initState();
    tabController?.addListener(() {});
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    authStore = Provider.of<AuthProvider>(context);
    profi = Provider.of<ProfileOb>(context);
    width = MediaQuery.of(context).size.width;
    init();
  }

  void init() async {
    tabController = TabController(length: 3, vsync: this);
    await checkRole();
  }

  @override
  void dispose() {
    tabController?.dispose();
    super.dispose();
  }

  void changeColor(Color bgColor, Color textColor, int index) {
    for (int i = 0; i < this.bgColor.length; i++) {
      this.bgColor[i] = primaryWhiteColor;
      this.textColor[i] = primaryBlackColor;
    }
    this.bgColor[index] = primaryBlackColor;
    this.textColor[index] = primaryWhiteColor;
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  Future<void> checkRole() async {
    await http.get(
      Uri.parse(AppConstants.BASE_URL + '/auth/me'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ' + authStore.token.toString(),
      },
    ).then((response) {
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        if (data['result'] != null) {
          profi.setUserInfoCompany(data['result']['company']);
          if (profi.userInfo?.currentRole == null)
            profi.setUserInfoCurrentRole(data['result']['roles'][0]);
          setState(() {});
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileOb>(builder: (context, profi, child) {
      // checkRole();
      return Scaffold(
          appBar: AppBar(
            backgroundColor: context.scaffoldBackgroundColor,
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SwitchAccountScreen()),
                  );
                },
                icon: Icon(Icons.person, color: context.iconColor),
              ),
            ],
            title: Text("Dashboard", style: boldTextStyle(size: 18)),
            elevation: 0.0,
          ),
          body: SingleChildScrollView(
              child: Container(
                  padding: EdgeInsets.all(16),
                  alignment: Alignment.center,
                  child: Column(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Your projects', style: boldTextStyle()),
                        profi.userInfo!.currentRole == 1
                            ? customButton(
                                txt: 'Post a project',
                                wid: 120,
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ProjectPostStep1Screen()),
                                  );
                                },
                              )
                            : SizedBox(),
                      ],
                    ),
                    SizedBox(height: 10),
                    Container(
                      height: MediaQuery.of(context).size.height -
                          MediaQuery.of(context).padding.top,
                      // height: 500,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Column(children: [
                        TabBar(
                          controller: tabController,
                          indicator: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              color: Colors.black),
                          indicatorColor: Colors.white,
                          labelColor: Colors.white,
                          unselectedLabelColor: Colors.black,
                          tabs: tabs,
                          // font size
                          labelStyle: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w500),
                          // font weight

                          indicatorSize: TabBarIndicatorSize.tab,
                        ),
                        Expanded(
                          child: TabBarView(
                            controller: tabController,
                            children: [
                              AllProjectComponents(titleProject: "all"),
                              AllProjectComponents(titleProject: "working"),
                              AllProjectComponents(titleProject: "archieved"),
                            ],
                          ),
                        ),
                      ]),
                    ),
                  ]))));
    });
  }
}
