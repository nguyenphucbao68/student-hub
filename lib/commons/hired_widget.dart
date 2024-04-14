import 'package:carea/commons/constants.dart';
import 'package:carea/commons/images.dart';
import 'package:carea/main.dart';
import 'package:carea/model/user_info.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

// ignore: must_be_immutable
class HiredWidget extends StatefulWidget {
  Proposal data;

  HiredWidget({required this.data});

  @override
  State<HiredWidget> createState() => _HiredWidgetState();
}

class _HiredWidgetState extends State<HiredWidget> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      // padding: EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 16),

      padding: EdgeInsets.symmetric(vertical: 8),
      decoration: boxDecorationWithRoundedCorners(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        backgroundColor: Colors.grey.shade200,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.person_2_outlined, size: 60),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.data.student!.user!.fullname.toString(),
                    style: boldTextStyle(size: 16),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              )
            ],
          ),
          SizedBox(height: 10),
          Container(
            width: width * 0.8,
            child: Column(
              children: <Widget>[
                Text(
                  widget.data.coverLetter!,
                  style: secondaryTextStyle(size: 14),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}