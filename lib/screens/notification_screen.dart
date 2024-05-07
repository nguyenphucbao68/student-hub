import 'dart:convert';

import 'package:carea/commons/widgets.dart';
import 'package:carea/components/notifications/interview_notification_component.dart';
import 'package:carea/components/notifications/message_notification_component.dart';
import 'package:carea/components/notifications/offer_notification_component.dart';
import 'package:carea/components/notifications/submitted_notification_component.dart';
import 'package:carea/constants/app_constants.dart';
import 'package:carea/main.dart';
import 'package:carea/store/authprovider.dart';
import 'package:carea/store/profile_ob.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:carea/model/notification_model.dart' as NotificationModel;

class NotificationScreen extends StatefulWidget {
  NotificationScreen({this.newNotification});

  NotificationModel.Notification? newNotification;

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  late AuthProvider authStore;
  late ProfileOb profi;
  bool _isLoading = true;
  List<NotificationModel.Notification> notificationList = [];
  ScrollController _scrollController = ScrollController();
  
  @override
  void didChangeDependencies() {
    log('State change: ${widget.newNotification?.title}');
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    authStore = Provider.of<AuthProvider>(context, listen: false);
    profi = Provider.of<ProfileOb>(context, listen: false);
    getNotification();
  }

  Future<void> getNotification() async {
    await http.get(
        Uri.parse(AppConstants.BASE_URL +
            '/notification/getByReceiverId/${profi.user?.id}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ' + authStore.token.toString()
        }).then((response) {
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        if (data['result'] != null) {
          List<NotificationModel.Notification> mappedData = data['result']
              .map<NotificationModel.Notification>(
                  (item) => NotificationModel.Notification().parse(item))
              .toList();

          setState(() {
            notificationList.clear();
            notificationList.addAll(mappedData);
            _isLoading = false;
          });
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (_scrollController.hasClients) {
              _scrollController.jumpToBottom();
            }
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: careaAppBarWidget(context,
          titleText: "Notification", leadingIcon: false),
      body: _isLoading
          ? Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Center(
                  child: CircularProgressIndicator(
                color: darkCyan,
              )))
          : Container(
              padding: EdgeInsets.all(5),
              height: context.height(),
              color: appStore.isDarkModeOn
                  ? scaffoldDarkColor
                  : gray.withOpacity(0.1),
              child: ListView.separated(
                reverse: true,
                controller: _scrollController,
                shrinkWrap: true,
                itemCount: notificationList.length,
                separatorBuilder: (BuildContext context, int index) => SizedBox(
                  height: 10,
                ),
                padding: EdgeInsets.only(left: 0, right: 0, top: 8),
                itemBuilder: (context, index) {
                  return getNotificationScreen(notificationList[index]);
                },
              )).paddingSymmetric(vertical: 8, horizontal: 16),
    );
  }

  Widget getNotificationScreen(
      NotificationModel.Notification notificationInfo) {
    switch (notificationInfo.typeNotifyFlag) {
      case NOTIFICATION_TYPE.CHAT:
        return MessageNotificationWdiget(notification: notificationInfo);
      case NOTIFICATION_TYPE.INTERVIEW:
        return InterviewNotificationWdiget(notification: notificationInfo);
      case NOTIFICATION_TYPE.OFFER:
        return OfferNotificationWdiget(notification: notificationInfo);
      case NOTIFICATION_TYPE.SUBMITTED:
        return SubmittedNotificationWdiget(notification: notificationInfo);
      default:
        return SizedBox();
    }
  }
}
