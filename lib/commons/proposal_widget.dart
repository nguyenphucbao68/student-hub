import 'package:carea/commons/constants.dart';
import 'package:carea/commons/images.dart';
import 'package:carea/main.dart';
import 'package:carea/model/user_info.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

// ignore: must_be_immutable
class ProposalWidget extends StatefulWidget {
  Proposal data;

  ProposalWidget({required this.data});

  @override
  State<ProposalWidget> createState() => _ProposalWidgetState();
}

class _ProposalWidgetState extends State<ProposalWidget> {
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {},
                child: Container(
                  alignment: Alignment.center,
                  width: width * 0.45,
                  padding: EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: Colors.black,
                      width: 2,
                    ),
                  ),
                  child: Text('Message', style: boldTextStyle(color: black)),
                ),
              ),
              SizedBox(height: 8),
              GestureDetector(
                onTap: () {
                  _onHireHandleBtn(context);
                },
                child: Container(
                  alignment: Alignment.center,
                  width: width * 0.45,
                  padding: EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text('Hire', style: boldTextStyle(color: white)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _onHireHandleBtn(BuildContext context) {
    Widget cancelBtn = ElevatedButton(
      onPressed: () {
        context.pop();
      },
      child: Text("Cancel", style: boldTextStyle(color: grey)),
    );

    Widget sendBtn = ElevatedButton(
      onPressed: () {
        onHireHandle();
        context.pop();
      },
      child: Text("Send", style: boldTextStyle(color: grey)),
    );

    AlertDialog alert = AlertDialog(
      title: Text(
        "Hired offer",
        style: boldTextStyle(size: 14),
      ),
      content: Text(
        "Do you really want to send hired offer for student to do this project?",
        style: primaryTextStyle(size: 13),
      ),
      actions: [cancelBtn, sendBtn],
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        });
  }

  void onHireHandle() {
    setState(() {
      // widget.data.hireStatus = HIRE_STATUS.sent_hire_status;
    });
  }
}
