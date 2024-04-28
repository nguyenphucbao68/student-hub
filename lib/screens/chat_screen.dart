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
import 'package:carea/model/user_info.dart';
import 'package:carea/store/logicprovider.dart';
import 'package:carea/utils/Date.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'package:carea/model/message.dart';
import 'package:carea/store/authprovider.dart';

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
  ScrollController scrollController = ScrollController();
  TextEditingController msgController = TextEditingController();
  List<Message> msgList = [];
  bool _isloading = true;

  FocusNode msgFocusNode = FocusNode();

  void createScheduleMeeting(BHMessageModel data) async {
    msgListing.insert(0, data);
    if (mounted) scrollController.animToTop();
    FocusScope.of(context).requestFocus(msgFocusNode);
    setState(() {});

    await Future.delayed(Duration(seconds: 1));
    if (mounted) scrollController.animToTop();
    setState(() {});
  }

  var msgListing = getChatMsgData();
  var personName = '';

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    //
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
        msgList.clear();
        if (data['result'] != null) {
          log({'pid': widget.projectId, 'sid': widget.senderId});
          setState(() {
            data['result'].forEach((item) {
              msgList.add(Message(
                  id: item['id'],
                  createdAt: item['createdAt'],
                  content: item['content'],
                  sender: User().parse(item['sender']),
                  receiver: User().parse(item['receiver']),
                  interview: item['interview'],
                  formatedDate:
                      DateHandler.getDate(DateTime.parse(item['createdAt']))));
            });

            _isloading = false;
          });
        }
      }
    });
  }

  sendClick() async {
    DateFormat formatter = DateFormat('hh:mm a');

    if (msgController.text.trim().isNotEmpty) {
      hideKeyboard(context);
      var msgModel = BHMessageModel();
      msgModel.msg = msgController.text.toString();
      msgModel.time = formatter.format(DateTime.now());
      msgModel.senderId = BHSender_id;
      hideKeyboard(context);
      msgListing.insert(0, msgModel);

      // var msgModel1 = BHMessageModel();
      // msgModel1.msg = msgController.text.toString();
      // msgModel1.time = formatter.format(DateTime.now());
      // msgModel1.senderId = BHReceiver_id;

      msgController.text = '';

      if (mounted) scrollController.animToTop();
      FocusScope.of(context).requestFocus(msgFocusNode);
      setState(() {});

      await Future.delayed(Duration(seconds: 1));

      // msgListing.insert(0, msgModel1);jj

      if (mounted) scrollController.animToTop();
    } else {
      FocusScope.of(context).requestFocus(msgFocusNode);
    }
    setState(() {});
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    authStore = Provider.of<AuthProvider>(context);
    _fetchMessage();
    init();
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
              Text(widget.name!, style: boldTextStyle(size: 18)),
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
            IconButton(
                onPressed: () {
                  launch('tel:${123456789}');
                },
                icon: Icon(Icons.call, color: context.iconColor, size: 18)),
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
                        scheduleMeetingCallback: createScheduleMeeting);
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
                      controller: scrollController,
                      itemCount: msgList.length,
                      padding: EdgeInsets.only(
                          top: 8, left: 8, right: 8, bottom: 70),
                      itemBuilder: (_, index) {
                        BHMessageModel data = msgListing[0];
                        Message msgData = msgList[index];
                        // var isMe = data.senderId == BHSender_id;
                        var isMe = msgData.sender!.id != widget.senderId;

                        return (index == 0 ||
                                msgData.formatedDate !=
                                    msgList[index - 1].formatedDate)
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                      isMe: isMe, data: data, msg: msgData)
                                ],
                              )
                            : ChatWidget(
                                isMe: isMe,
                                data: data,
                                msg: msgData,
                              );
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
                            controller: msgController,
                            focusNode: msgFocusNode,
                            autofocus: true,
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
