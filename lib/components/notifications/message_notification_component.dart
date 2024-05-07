import 'package:carea/utils/Date.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:carea/model/notification_model.dart' as Noti;

class MessageNotificationWdiget extends StatefulWidget {
  final Noti.Notification notification;

  MessageNotificationWdiget({required this.notification});

  @override
  State<MessageNotificationWdiget> createState() =>
      _MessageNotificationWdigetState();
}

class _MessageNotificationWdigetState extends State<MessageNotificationWdiget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: context.cardColor, borderRadius: BorderRadius.circular(20)),
      child: ListTile(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(widget.notification.title!, style: boldTextStyle()),
            SizedBox(height: 10),
            Text(
              widget.notification.content!,
              style: secondaryTextStyle(size: 14),
            ),
            SizedBox(height: 10),
            Text(
              DateHandler.getDateTimeDifference(
                  DateTime.parse(widget.notification.createdAt!)),
              style: secondaryTextStyle(size: 14),
            ),
          ],
        ),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(200),
          child: Container(
            height: 50,
            width: 50,
            color: Colors.black,
            child: IconButton(
              onPressed: () {},
              icon:
                  const Icon(Icons.chat_bubble, color: Colors.white, size: 18),
            ),
          ),
        ),
      ),
    );
  }
}
