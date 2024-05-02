import 'dart:convert';

import 'package:carea/commons/data_provider.dart';
import 'package:carea/constants/app_constants.dart';
import 'package:carea/main.dart';
import 'package:carea/model/calling_model.dart';
import 'package:carea/model/project.dart';
import 'package:carea/model/user_info.dart';
import 'package:carea/screens/chat_screen.dart';
import 'package:carea/store/profile_ob.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:carea/store/authprovider.dart';
import 'package:carea/model/message.dart';
import 'package:carea/utils/Date.dart';
import 'package:carea/commons/route_transition.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class ChatComponent extends StatefulWidget {
  @override
  _ChatComponentState createState() => _ChatComponentState();
}

class _ChatComponentState extends State<ChatComponent> {
  late AuthProvider authStore;
  late ProfileOb profi;
  List<CallingModel> chatData = chatDataList();
  List<Message> messageData = [];
  bool _isloading = true;
  late io.Socket _socket;

  @override
  void initState() {
    super.initState();
    authStore = Provider.of<AuthProvider>(context, listen: false);
    profi = Provider.of<ProfileOb>(context, listen: false);
    getMessage();
    connectToSocket();
    init();
  }

  void init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    init();
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
      var message = data['notification'];
      log('LOG: ${message['title']}');
      getMessage();
    });

    _socket.on("ERROR", (data) => print(data));
  }

  @override
  void dispose() {
    // _socket.disconnect();
    // _socket.dispose();
    super.dispose();
  }

  Future<void> getMessage() async {
    await http.get(Uri.parse(AppConstants.BASE_URL + '/message'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ' + authStore.token.toString()
        }).then((response) {
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        if (data['result'] != null) {
          setState(() {
            messageData.clear();

            data['result'].forEach((item) {
              messageData.add(Message(
                  id: item['id'],
                  createdAt: item['createdAt'],
                  content: item['content'],
                  sender: User().parse(item['sender']),
                  receiver: User().parse(item['receiver']),
                  project: Project().parse(item['project'])));
            });

            messageData.sort((a, b) {
              DateTime aDate = DateTime.parse(a.createdAt!);
              DateTime bDate = DateTime.parse(b.createdAt!);

              return bDate.compareTo(aDate);
            });

            _isloading = false;
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isloading
        ? Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Center(
                child: CircularProgressIndicator(
              color: darkCyan,
            )))
        : ListView.builder(
            shrinkWrap: true,
            itemCount: messageData.length,
            padding: EdgeInsets.only(left: 0, bottom: 70, right: 0, top: 8),
            itemBuilder: (context, index) {
              Message message = messageData[index];

              return Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          margin: EdgeInsets.only(top: 15),
                          child: CircleAvatar(
                            child: Text(
                                message.sender!.fullName!.split(' ').last[0]),
                          )),
                      16.width,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(message.sender!.fullName.validate(),
                              style: boldTextStyle()),
                          2.height,
                          Text(message.project!.title.validate(),
                              style: secondaryTextStyle()),
                          8.height,
                          Text(message.content.validate(),
                              style: primaryTextStyle()),
                        ],
                      ).expand(),
                      Text(
                          DateHandler.getDateTimeDifference(
                              DateTime.parse(message.createdAt!)),
                          style: secondaryTextStyle()),
                    ],
                  ).paddingSymmetric(vertical: 8, horizontal: 16).onTap(
                    () {
                      Navigator.of(context).push(createRoute(ChatScreen(
                        name: message.sender!.fullName.validate(),
                        projectId: message.project!.id!,
                        senderId: message.sender!.id! == profi.user!.id
                            ? message.receiver!.id!
                            : message.sender!.id!,
                      )));
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Divider(
                      thickness: 0.2,
                    ),
                  )
                ],
              );
            },
          );
  }
}
