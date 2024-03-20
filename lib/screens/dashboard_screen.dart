import 'package:carea/fragments/dashboard_fragment.dart';
import 'package:carea/fragments/inbox_fragment.dart';
import 'package:carea/fragments/message_fragment.dart';
import 'package:carea/fragments/orders_fragment.dart';
import 'package:carea/fragments/projects_fragment.dart';
import 'package:carea/fragments/alert_fragment.dart';
import 'package:carea/fragments/saved_projects_fragment.dart';
import 'package:carea/fragments/setting_fragment.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  var _pages = <Widget>[
    SavedProjectsFragment(),
    // DashBoardFragment(),
    // MessageFragment(),
    // OrderFragment(),
    DashBoardFragment(),
    InboxFragment(),
    // AlertFragment(),
    SettingFragment(),
  ];

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
            label: 'Projects'),
        BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_outlined),
            activeIcon: Icon(Icons.dashboard),
            label: 'Dashboard'),
        BottomNavigationBarItem(
            icon: Icon(Icons.message_outlined),
            activeIcon: Icon(Icons.message_sharp),
            label: 'Message'),
        BottomNavigationBarItem(
          icon: Icon(Icons.notifications_active_outlined),
          activeIcon: Icon(Icons.notifications_active),
          label: 'Alert',
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
