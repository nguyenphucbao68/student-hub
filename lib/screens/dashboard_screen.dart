import 'dart:convert';

import 'package:carea/components/chat_component.dart';
import 'package:carea/constants/app_constants.dart';
import 'package:carea/fragments/dashboard_fragment.dart';
import 'package:carea/fragments/projects_fragment.dart';
import 'package:carea/main.dart';
import 'package:carea/model/user_info.dart';
import 'package:carea/store/authprovider.dart';
import 'package:carea/store/profile_ob.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:carea/screens/notification_screen.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:carea/model/notification.dart' as noti;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, this.defaultPage = 0}) : super(key: key);

  final int defaultPage;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  int _messageCounter = 0;
  int _alertCounter = 0;

  var _pages = <Widget>[
    ProjectsFragment(),
    DashBoardFragment(),
    ChatComponent(),
    NotificationScreen(),
  ];
  late AuthProvider authStore;
  late ProfileOb profi;
  late io.Socket _socket;

  @override
  void initState() {
    super.initState();
  }

  void connectToSocket() {
    _socket = io.io(
        AppConstants.SOCKET_URL,
        io.OptionBuilder()
            .setTransports(['websocket'])
            .disableAutoConnect()
            .build());

    //Add authorization to header
    _socket.io.options?['extraHeaders'] = {
      'Authorization': 'Bearer ${authStore.token}',
    };

    _socket.disconnect().connect();

    _socket.onConnect((_) {
      log('Connected to the socket server [ALL APP]');
      log('Listening event ${SOCKET_EVENTS.NOTI.name}_${profi.user!.id}');
    });

    _socket.onConnectError((data) => print('$data'));
    _socket.onError((data) => print(data));

    _socket.onDisconnect((_) {
      print('Disconnected from the socket server [ALL APP]');
    });

    _socket.on('${SOCKET_EVENTS.NOTI.name}_${profi.user!.id}', (data) {
      setState(() {
        _alertCounter++;
      });
      noti.Notification notification =
          noti.Notification().parse(data["notification"]);

      if (notification.typeNotifyFlag == NOTIFICATION_TYPE.CHAT) {
        setState(() {
          _messageCounter++;
        });
      }
    });

    _socket.on("ERROR", (data) => print(data));
  }

  @override
  void dispose() {
    _socket.disconnect();
    _socket.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    authStore = Provider.of<AuthProvider>(context);
    profi = Provider.of<ProfileOb>(context);
    connectToSocket();
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
            icon: _messageCounter != 0
                ? Badge(
                    label: Text(_messageCounter.toString()),
                    child: Icon(Icons.message_outlined),
                  )
                : Icon(Icons.message_outlined),
            activeIcon: Icon(Icons.message_sharp),
            label: appStore.message),
        BottomNavigationBarItem(
            icon: _alertCounter != 0
                ? Badge(
                    label: Text(_alertCounter.toString()),
                    child: Icon(Icons.notifications_active_outlined),
                  )
                : Icon(Icons.notifications_active_outlined),
            activeIcon: Icon(Icons.notifications_active),
            label: appStore.alert),
      ],
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      if (index == 2) {
        _messageCounter = 0;
      }

      if (index == 3) {
        _alertCounter = 0;
      }

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
