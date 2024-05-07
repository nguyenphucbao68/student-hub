import 'dart:convert';
import 'package:carea/constants/app_constants.dart';
import 'package:carea/fragments/dashboard_fragment.dart';
import 'package:carea/fragments/inbox_fragment2.dart';
import 'package:carea/fragments/projects_fragment.dart';
import 'package:carea/model/user_info.dart';
import 'package:carea/store/authprovider.dart';
import 'package:carea/store/profile_ob.dart';
import 'package:carea/store/socket_service.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:carea/screens/notification_screen.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:carea/model/notification_model.dart' as NotificationModel;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, this.defaultPage = 0}) : super(key: key);

  final int defaultPage;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  // var _pages = <Widget>[
  //   ProjectsFragment(),
  //   DashBoardFragment(),
  //   InboxFragment(),
  //   NotificationScreen()
  // ];
  NotificationModel.Notification? _newNotification = null;
  late AuthProvider authStore;
  late ProfileOb profi;
  late io.Socket _socket;
  late SocketService socketService;

  @override
  void initState() {
    super.initState();
    authStore = Provider.of<AuthProvider>(context, listen: false);
    profi = Provider.of<ProfileOb>(context, listen: false);
    socketService = Provider.of<SocketService>(context, listen: false);
    connectToSocket();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
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

  void connectToSocket() {
    socketService.authSocket(userToken: authStore.token!);

    _socket = socketService.socket;

    _socket.connect();

    _socket.onConnect((_) {
      log('Connected to the socket server');
      log('Listening event ${SOCKET_EVENTS.NOTI.name}_${profi.user!.id}');
    });

    _socket.onConnectError((data) => print('$data'));
    _socket.onError((data) => print(data));

    _socket.onDisconnect((_) {
      print('Disconnected from the socket server NOTIFICATION');
    });

    _socket.on('${SOCKET_EVENTS.NOTI.name}_${profi.user!.id}', (data) {
      var noti = data['notification'];
      log('LOG: ${noti['title']}');

      setState(() {
        _newNotification = NotificationModel.Notification().parse(noti);
        log({_newNotification?.title});
      });
    });

    _socket.on("ERROR", (data) => print(data));
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
          label: 'Notification',
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
        body: Center(
            child: IndexedStack(
          index: _selectedIndex,
          children: [
            ProjectsFragment(),
            DashBoardFragment(),
            InboxFragment(),
            NotificationScreen(
               newNotification: _newNotification,
            )
          ],
        )),
      ),
    );
  }
}
