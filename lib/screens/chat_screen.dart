import 'dart:convert';

import 'package:carea/commons/chat_widget.dart';
import 'package:carea/commons/constants.dart';
import 'package:carea/commons/data_provider.dart';
import 'package:carea/commons/widgets.dart';
import 'package:carea/components/chat_message_componet.dart';
import 'package:carea/components/project_filter_component.dart';
import 'package:carea/components/schedule_interview_component.dart';
import 'package:carea/constants/app_constants.dart';
import 'package:carea/main.dart';
import 'package:carea/model/calling_model.dart';
import 'package:carea/model/interview_model.dart';
import 'package:carea/model/user_info.dart';
import 'package:carea/store/logicprovider.dart';
import 'package:carea/store/profile_ob.dart';
import 'package:carea/utils/Date.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'package:carea/model/message.dart';
import 'package:carea/store/authprovider.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

import 'dart:math' as math;

class ChatScreen extends StatefulWidget {
  static String tag = '/ChatScreen';
  final String name;
  final int projectId;
  final int senderId;

  ChatScreen(
      {required this.name, required this.projectId, required this.senderId});

  @override
  ChatScreenState createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  late AuthProvider authStore;
  ScrollController _scrollController = ScrollController();
  TextEditingController _msgController = TextEditingController();
  late ProfileOb profi;
  List<Message> msgList = [];
  late io.Socket _socket;
  bool _isloading = true;
  // int? intervewIdTemp = null;

  FocusNode msgFocusNode = FocusNode();

  // var msgListing = getChatMsgData();
  var personName = '';

  @override
  void initState() {
    super.initState();
    authStore = Provider.of<AuthProvider>(context, listen: false);
    profi = Provider.of<ProfileOb>(context, listen: false);
    _fetchMessage();
    connectToSocket();
    init();
  }

  init() async {
    //
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
    //Add query param to url
    _socket.io.options?['query'] = {'project_id': widget.projectId};

    _socket.connect();

    _socket.onConnect((_) {
      log('Connected to the socket server with project_id ${widget.projectId}');
      log('Listening event ${SOCKET_EVENTS.RECEIVE_MESSAGE.name}');
    });

    _socket.onConnectError((data) => print('$data'));
    _socket.onError((data) => print(data));

    _socket.onDisconnect((_) {
      print('Disconnected from the socket server');
    });

    _socket.on(SOCKET_EVENTS.RECEIVE_MESSAGE.name, (data) {
      var message = data['notification'];

      setState(() {
        msgList.add(Message(
            id: message['message']['id'],
            createdAt: message['message']['createdAt'],
            content: message['message']['content'],
            sender: User().parse(message['sender']),
            receiver: User().parse(message['receiver']),
            interview: message['interview'],
            formatedDate:
                DateHandler.getDate(DateTime.parse(message['createdAt']))));
      });

      scrollDownToBottom();
    });
    // _socket.on(SOCKET_EVENTS.RECEIVE_INTERVIEW.name, (data) {
    //   var message = data['notification'];
    //   int index = msgList
    //       .indexWhere((element) => element.interview?.id == intervewIdTemp);
    //   print(index);
    //   if (intervewIdTemp == null || index != -1)
    //     setState(() {
    //       Interview? updItv = Interview().tryParse(message['interview']);
    //       updItv?.meetingRoom = MettingRroom().tryParse(message['meetingRoom']);
    //       msgList[index].interview = updItv;
    //     });
    //   else
    //     setState(() {
    //       msgList.add(Message(
    //           id: message['message']['id'],
    //           createdAt: message['message']['createdAt'],
    //           content: message['message']['content'],
    //           sender: User().parse(message['sender']),
    //           receiver: User().parse(message['receiver']),
    //           interview: message['interview'],
    //           formatedDate:
    //               DateHandler.getDate(DateTime.parse(message['createdAt']))));
    //     });
    //   intervewIdTemp = null;
    //   scrollDownToBottom();
    // });
  }

  Future<void> _fetchMessage() async {
    await http.get(
        Uri.parse(AppConstants.BASE_URL +
            '/message/${widget.projectId}/user/${widget.senderId}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ' + authStore.token.toString()
        }).then((response) {
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        if (data['result'] != null) {
          log({'pid': widget.projectId, 'sid': widget.senderId});
          List<Message> mappedData = data['result']
              .map<Message>((item) => Message(
                  id: item['id'],
                  createdAt: item['createdAt'],
                  content: item['content'],
                  sender: User().parse(item['sender']),
                  receiver: User().parse(item['receiver']),
                  interview:
                      Interview().tryParseWithMeetingRoom(item['interview']),
                  formatedDate:
                      DateHandler.getDate(DateTime.parse(item['createdAt']))))
              .toList();

          setState(() {
            msgList.clear();
            msgList.addAll(mappedData);
            _isloading = false;
          });

          scrollDownToBottom();
        }
      }
    });
  }

  sendClick() async {
    if (_msgController.text.trim().isNotEmpty) {
      hideKeyboard(context);

      _socket.emit(SOCKET_EVENTS.SEND_MESSAGE.name, {
        "projectId": widget.projectId,
        "content": _msgController.text.trim(),
        "messageFlag": 0,
        "senderId": profi.user?.id,
        "receiverId": widget.senderId
      });

      _msgController.text = '';

      FocusScope.of(context).requestFocus(msgFocusNode);

      await Future.delayed(Duration(seconds: 1));

      // msgListing.insert(0, msgModel1);jj
    } else {
      FocusScope.of(context).requestFocus(msgFocusNode);
    }
    setState(() {});
  }

  createScheduleInterview(Interview data) async {
    String mtRC = math.Random().nextInt(10000).toString();

    await http.post(
      Uri.parse(AppConstants.BASE_URL + '/interview'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ' + authStore.token.toString(),
      },
      body: jsonEncode({
        "title": data.title,
        "content": profi.user!.fullName! + " want to schedule a meeting",
        "startTime": data.startTime,
        "endTime": data.endTime,
        "projectId": widget.projectId,
        "senderId": profi.user?.id,
        "receiverId": widget.senderId,
        "meeting_room_code": mtRC,
        "meeting_room_id": mtRC,
      }),
    );
    await Future.delayed(Duration(seconds: 1));
    _fetchMessage();
    _socket.on(SOCKET_EVENTS.RECEIVE_INTERVIEW.name, (data) {
      var message = data['notification'];
      setState(() {
        msgList.add(Message(
            id: message['message']['id'],
            createdAt: message['message']['createdAt'],
            content: message['message']['content'],
            sender: User().parse(message['sender']),
            receiver: User().parse(message['receiver']),
            interview: message['interview'],
            formatedDate:
                DateHandler.getDate(DateTime.parse(message['createdAt']))));
      });

      scrollDownToBottom();
    });
  }

  updateScheduleInterview(Interview? data) async {
    if (data == null) return;
    print(data.title);
    print(data.startTime);
    print(data.endTime);
    // intervewIdTemp = data.id;
    await http.patch(
      Uri.parse(AppConstants.BASE_URL + '/interview/${data.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ' + authStore.token.toString(),
      },
      body: jsonEncode({
        "title": data.title,
        "startTime": data.startTime,
        "endTime": data.endTime,
      }),
    );
    await Future.delayed(Duration(seconds: 1));
    _fetchMessage();
    // _socket.on(SOCKET_EVENTS.RECEIVE_INTERVIEW.name, (data) {
    //   var message = data['notification'];
    //   int index =
    //       msgList.indexWhere((element) => element.interview?.id == data.id);
    //   setState(() {
    //     Interview? updItv = Interview().tryParse(message['interview']);
    //     updItv?.meetingRoom = MettingRroom().tryParse(message['meetingRoom']);
    //     msgList[index].interview = updItv;
    //   });
    // });
  }

  disableScheduleInterview(Interview? data) async {
    if (data == null) return;
    await http.patch(
      Uri.parse(AppConstants.BASE_URL + '/interview/${data.id}/disable'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ' + authStore.token.toString(),
      },
    );
    print('da disable');
    await Future.delayed(Duration(seconds: 1));
    _fetchMessage();
  }

  deleteScheduleInterview(Interview? data) async {
    if (data == null) return;
    // intervewIdTemp = data.id;
    await http.delete(
      Uri.parse(AppConstants.BASE_URL + '/interview/${data.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ' + authStore.token.toString(),
      },
    );
    await Future.delayed(Duration(seconds: 1));
    _fetchMessage();
    // _socket.on(SOCKET_EVENTS.RECEIVE_INTERVIEW.name, (data) {
    //   int index =
    //       msgList.indexWhere((element) => element.interview?.id == data.id);
    //   setState(() {
    //     msgList[index].interview?.disableFlag = 1;
    //   });
    // });
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

  @override
  void dispose() {
    _socket.disconnect();
    _socket.dispose();
    _scrollController.dispose();
    _msgController.dispose();
    super.dispose();
  }

  void scrollDownToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      log({
        'hasClient': _scrollController.hasClients,
        'maxScrollEvent': _scrollController.position.maxScrollExtent,
        'listView': msgList.length
      });
      if (_scrollController.hasClients) {
        _scrollController.animateTo(_scrollController.position.maxScrollExtent,
            duration: Duration(milliseconds: 100), curve: Curves.easeOut);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.3,
          iconTheme:
              IconThemeData(color: appStore.isDarkModeOn ? white : black),
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(widget.name, style: boldTextStyle(size: 18)),
              // 8.width,
              // Container(
              //   padding: EdgeInsets.all(2),
              //   decoration: boxDecorationWithRoundedCorners(
              //       boxShape: BoxShape.circle, backgroundColor: Colors.blue),
              //   child: Icon(Icons.done, color: white, size: 10),
              // )
            ],
          ),
          actions: [
            // IconButton(
            //     onPressed: () {
            //       launch('tel:${123456789}');
            //     },
            //     icon: Icon(Icons.call, color: context.iconColor, size: 18)),
            IconButton(
              icon: Icon(Icons.more_horiz, color: context.iconColor, size: 26),
              onPressed: () {
                showModalBottomSheet(
                  enableDrag: true,
                  isDismissible: true,
                  isScrollControlled: true,
                  constraints: BoxConstraints(
                    minHeight: height * 0.55,
                    maxHeight: height,
                  ),
                  context: context,
                  builder: (context) {
                    return ScheduleInterviewComponent(
                        scheduleInterviewCallback: createScheduleInterview);
                  },
                );
              },
            ),
          ],
        ),
        body: _isloading
            ? Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Center(
                    child: CircularProgressIndicator(
                  color: darkCyan,
                )))
            : Stack(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 4),
                    child: ListView.separated(
                      separatorBuilder: (_, i) =>
                          Divider(color: Colors.transparent),
                      shrinkWrap: true,
                      reverse: false,
                      controller: _scrollController,
                      itemCount: msgList.length,
                      padding: EdgeInsets.only(
                          top: 8, left: 8, right: 8, bottom: 70),
                      itemBuilder: (_, index) {
                        // BHMessageModel data = msgListing[0];
                        Message msgData = msgList[index];
                        // var isMe = data.senderId == BHSender_id;
                        var isMe = msgData.sender!.id != widget.senderId;

                        return (index == 0 ||
                                msgData.formatedDate !=
                                    msgList[index - 1].formatedDate)
                            ? Column(
                                crossAxisAlignment: isMe
                                    ? CrossAxisAlignment.end
                                    : CrossAxisAlignment.start,
                                children: [
                                  Center(
                                      child: Padding(
                                    child: Text(
                                      msgData.formatedDate!
                                          .replaceAll('-', ' - '),
                                      style: secondaryTextStyle(size: 13),
                                    ),
                                    padding: EdgeInsets.only(top: 5, bottom: 5),
                                  )),
                                  ChatWidget(
                                      isMe: isMe,
                                      msg: msgData,
                                      updateInterviewCallback:
                                          updateScheduleInterview,
                                      disableInterviewCallback:
                                          disableScheduleInterview,
                                      deleteInterviewCallback:
                                          deleteScheduleInterview)
                                ],
                              )
                            : ChatWidget(
                                isMe: isMe,
                                // data: data,
                                msg: msgData,
                                updateInterviewCallback:
                                    updateScheduleInterview,
                                disableInterviewCallback:
                                    disableScheduleInterview,
                                deleteInterviewCallback:
                                    deleteScheduleInterview);
                      },
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      padding: EdgeInsets.only(
                          left: 12, right: 12, top: 8, bottom: 8),
                      decoration: BoxDecoration(
                          color: context.cardColor,
                          boxShadow: defaultBoxShadow()),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.calendar_month_rounded),
                          8.width,
                          TextField(
                            controller: _msgController,
                            focusNode: msgFocusNode,
                            autofocus: false,
                            textCapitalization: TextCapitalization.sentences,
                            textInputAction: TextInputAction.done,
                            decoration: InputDecoration.collapsed(
                              hintText: personName.isNotEmpty
                                  ? 'Write to ${widget.name}'
                                  : 'Type a message',
                              hintStyle: primaryTextStyle(),
                              fillColor: context.cardColor,
                              filled: true,
                            ),
                            onTap: scrollDownToBottom,
                            style: primaryTextStyle(),
                            onSubmitted: (s) {
                              sendClick();
                            },
                          ).expand(),
                          IconButton(
                            icon: Icon(Icons.send, size: 25),
                            onPressed: () async {
                              sendClick();
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
