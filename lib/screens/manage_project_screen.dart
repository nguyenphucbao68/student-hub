import 'package:carea/components/all_hired_commponent.dart';
import 'package:carea/components/all_proposal_component.dart';
import 'package:carea/components/manage_project_detail_component.dart';
import 'package:carea/main.dart';
import 'package:carea/screens/switch_account_screen.dart';
import 'package:carea/store/authprovider.dart';
import 'package:carea/store/profile_ob.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class ManageProjectScreen extends StatefulWidget {
  int? index = 0;
  int? tabIndex = 0;

  ManageProjectScreen({this.index, this.tabIndex});
  @override
  _ManageProjectScreenState createState() => _ManageProjectScreenState();
}

class _ManageProjectScreenState extends State<ManageProjectScreen>
    with SingleTickerProviderStateMixin {
  late double width;
  late AuthProvider authStore;
  late ProfileOb profi;

  TabController? tabController;
  // late TabController _tabController;

  final tabs = const [
    Tab(text: 'Proposals'),
    Tab(text: 'Details'),
    Tab(text: 'Message'),
    Tab(text: 'Hired'),
  ];

  @override
  void initState() {
    super.initState();
    tabController =
        TabController(length: 4, vsync: this, initialIndex: widget.index ?? 0);
    tabController?.index = widget.tabIndex ?? 0;
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
    // await checkRole();
  }

  @override
  void dispose() {
    tabController!.dispose();
    super.dispose();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  // Future<void> checkRole() async {
  //   await http.get(
  //     Uri.parse(AppConstants.BASE_URL + '/auth/me'),
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //       'Authorization': 'Bearer ' + authStore.token.toString(),
  //     },
  //   ).then((response) {
  //     if (response.statusCode == 200) {
  //       var data = jsonDecode(response.body);
  //       if (data['result'] != null) {
  //         profi.setUserInfoCompany(data['result']['company']);
  //         if (profi.userInfo?.currentRole == null)
  //           profi.setUserInfoCurrentRole(data['result']['roles'][0]);
  //         setState(() {});
  //       }
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileOb>(builder: (context, profi, child) {
      // checkRole();
      return Scaffold(
          appBar: AppBar(
            backgroundColor: context.scaffoldBackgroundColor,
            iconTheme: IconThemeData(color: context.iconColor),
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
            title: Text("Project information", style: boldTextStyle(size: 18)),
            elevation: 0.0,
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(8),
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height -
                  MediaQuery.of(context).padding.top,
              // height: 500,
              // decoration: BoxDecoration(
              //   color: Colors.white,
              //   borderRadius: BorderRadius.circular(8.0),
              // ),
              child: Column(children: [
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text("  " + profi.projectInfo!.title.toString(),
                        style: boldTextStyle(size: 18))),
                SizedBox(height: 16),
                Container(
                  decoration: BoxDecoration(
                    color: appStore.appColorPrimaryLightColor,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: TabBar(
                    controller: tabController,
                    indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: appStore.iconColor),
                    labelColor: appStore.txtPrimaryColor,
                    unselectedLabelColor: appStore.textPrimaryColor,
                    tabs: tabs,
                    labelStyle:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                    indicatorSize: TabBarIndicatorSize.tab,
                    // isScrollable: true,
                    // padding: EdgeInsets.only(right: -50),
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: tabController,
                    children: [
                      AllProposalComponent(),
                      ManageProjectDetailComponent(),
                      SizedBox(),
                      AllHiredComponent(),
                      // AllProjectComponents(titleProject: "all"),
                      // AllProjectComponents(titleProject: "working"),
                      // AllProjectComponents(titleProject: "archieved"),
                      // AllProjectComponents(titleProject: "archieved"),
                    ],
                  ),
                ),
              ]),
            ),
          ));
    });
  }
}
