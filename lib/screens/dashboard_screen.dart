import 'dart:convert';

import 'package:carea/constants/app_constants.dart';
import 'package:carea/fragments/alert_fragment.dart';
import 'package:carea/fragments/dashboard_fragment.dart';
import 'package:carea/fragments/inbox_fragment2.dart';
import 'package:carea/fragments/projects_fragment.dart';
import 'package:carea/main.dart';
import 'package:carea/model/user_info.dart';
import 'package:carea/store/authprovider.dart';
import 'package:carea/store/profile_ob.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, this.defaultPage = 0}) : super(key: key);

  final int defaultPage;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  var _pages = <Widget>[
    // SavedProjectsFragment(),
    ProjectsFragment(),
    DashBoardFragment(),
    InboxFragment(),
    // OrderFragment(),
    AlertFragment(),
    // SettingFragment(),
  ];
  late AuthProvider authStore;
  late ProfileOb profi;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    authStore = Provider.of<AuthProvider>(context);
    profi = Provider.of<ProfileOb>(context);
    init();
  }

  void init() async {
    log("defaultPage: ${widget.defaultPage}");
    if (widget.defaultPage != 0) {
      _selectedIndex = widget.defaultPage;
    }
    await initData();
  }

  Future<void> initData() async {
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
          profi.setUser(User().parse(data['result']));
          if (profi.currentRole == null ||
              !data['result']['roles']
                  .contains(profi.currentRole == UserRole.STUDENT ? 1 : 0))
            profi.setUserCurrentRole(data['result']['roles'][0]);
          setState(() {});
        }
      }
    });
  }

  Widget _bottomTab() {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
      type: BottomNavigationBarType.fixed,
      selectedLabelStyle: TextStyle(color: context.iconColor),
      selectedItemColor: context.iconColor,
      unselectedLabelStyle: TextStyle(color: gray),
      iconSize: 20,
      unselectedItemColor: gray,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            icon: Icon(Icons.list_alt_outlined),
            activeIcon: Icon(Icons.list),
            label: appStore.project),
        BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_outlined),
            activeIcon: Icon(Icons.dashboard),
            label: appStore.dashboard),
        BottomNavigationBarItem(
            icon: Icon(Icons.message_outlined),
            activeIcon: Icon(Icons.message_sharp),
            label: appStore.message),
        BottomNavigationBarItem(
          icon: Icon(Icons.notifications_active_outlined),
          activeIcon: Icon(Icons.notifications_active),
          label: appStore.alert,
        ),
      ],
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DoublePressBackWidget(
      child: Scaffold(
        bottomNavigationBar: _bottomTab(),
        body: Center(child: _pages.elementAt(_selectedIndex)),
      ),
    );
  }
}
