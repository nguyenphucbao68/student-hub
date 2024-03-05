import 'package:carea/fragments/dashboard_fragment.dart';
import 'package:carea/fragments/inbox_fragment.dart';
import 'package:carea/fragments/orders_fragment.dart';
import 'package:carea/fragments/setting_fragment.dart';
import 'package:carea/fragments/wallet_fragment.dart';
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
    DashBoardFragment(),
    OrderFragment(),
    InboxFragment(),
    WalletFragment(),
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
        BottomNavigationBarItem(icon: Icon(Icons.home_outlined), activeIcon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.shopping_cart_outlined), activeIcon: Icon(Icons.shopping_cart), label: 'Orders'),
        BottomNavigationBarItem(icon: Icon(Icons.message_outlined), activeIcon: Icon(Icons.message_sharp), label: 'Inbox'),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_balance_wallet_outlined),
          activeIcon: Icon(Icons.account_balance_wallet),
          label: 'Wallet',
        ),
        BottomNavigationBarItem(icon: Icon(Icons.person_outline), activeIcon: Icon(Icons.person), label: 'Profile'),
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
