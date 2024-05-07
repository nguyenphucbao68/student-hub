import 'package:carea/commons/widgets.dart';
import 'package:carea/components/all_project_component.dart';
import 'package:carea/main.dart';
import 'package:carea/screens/project_post_step1_screen.dart';
import 'package:carea/screens/switch_account_screen.dart';
import 'package:carea/store/authprovider.dart';
import 'package:carea/store/profile_ob.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

class DashBoardFragment extends StatefulWidget {
  @override
  _DashBoardFragmentState createState() => _DashBoardFragmentState();
}

class _DashBoardFragmentState extends State<DashBoardFragment>
    with SingleTickerProviderStateMixin {
  late double width;
  // late AuthProvider authStore;
  late ProfileOb profi;

  TabController? tabController;

  final tabs = const [
    Tab(text: 'All projects'),
    Tab(text: 'Working'),
    Tab(text: 'Archieved'),
  ];
  final tabsVi = const [
    Tab(text: "Tất cả dự án"),
    Tab(text: "Đang hoạt động"),
    Tab(text: "Đã lưu trữ"),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // authStore = Provider.of<AuthProvider>(context);
    // log('current Role' + authStore.authSignUp.name);
    // log(authStore.authSignUp.name);
    // log(UserRole.COMPANY.name);
    profi = Provider.of<ProfileOb>(context);
    width = MediaQuery.of(context).size.width;
    init();
  }

  void init() async {
    tabController = TabController(length: 3, vsync: this);
    // await checkRole();
  }

  @override
  void dispose() {
    tabController?.dispose();
    super.dispose();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  // Future<void> checkRole() async {
  //   if(profi.currentRole != null) return;
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
  //         // authStore.setCompany(data['result']['company']);
  //         // profi.setUserInfoCompany(data['result']['company']);
  //         // if (profi.userInfo?.currentRole == null)
  //           profi.setUserCurrentRole(data['result']['roles'][0]);
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
            automaticallyImplyLeading: false,
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
            title: Text(appStore.dashboard, style: boldTextStyle(size: 18)),
            elevation: 0.0,
          ),
          body: SingleChildScrollView(
              child: Container(
                  padding: EdgeInsets.all(12),
                  alignment: Alignment.center,
                  child: Column(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(appStore.yourProject, style: boldTextStyle()),
                        profi.currentRole == UserRole.COMPANY
                            ? customButton(
                                txt: appStore.postAProject,
                                wid: 120,
                                color: appStore.buttonPrimaryColor,
                                txtcolor: appStore.txtPrimaryColor,
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
                        color: appStore.appColorPrimaryLightColor,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Column(children: [
                        TabBar(
                          controller: tabController,
                          indicator: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              color: appStore.iconColor),
                          indicatorColor: appStore.txtPrimaryColor,
                          labelColor: appStore.txtPrimaryColor,
                          unselectedLabelColor: appStore.textPrimaryColor,
                          tabs: appStore.isVi ? tabsVi : tabs,
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
