import 'package:carea/commons/constants.dart';
import 'package:carea/commons/images.dart';
import 'package:carea/main.dart';
import 'package:carea/model/proposal.model.dart';
import 'package:carea/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:carea/commons/route_transition.dart';

class SubmittedProposalWidget extends StatefulWidget {
  ProposalModel data;

  SubmittedProposalWidget({required this.data});

  @override
  State<SubmittedProposalWidget> createState() =>
      _SubmittedProposalWidgetState();
}

class _SubmittedProposalWidgetState extends State<SubmittedProposalWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 16),
      decoration: boxDecorationWithRoundedCorners(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        backgroundColor: context.cardColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image(
                width: 70,
                height: 70,
                image: AssetImage(student_asset),
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.data.studentName,
                    // 'Hung Le',
                    style: boldTextStyle(size: 14),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    widget.data.yearInfo,
                    style: primaryTextStyle(size: 14),
                  ),
                ],
              )
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            children: [
              Container(
                  padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  decoration: boxDecorationWithRoundedCorners(
                      backgroundColor: appStore.isDarkModeOn
                          ? scaffoldDarkColor
                          : gray.withOpacity(0.3)),
                  child: Row(
                    children: [
                      Image(
                        image: AssetImage(user_role),
                        width: 25,
                        height: 25,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        widget.data.role,
                        style: boldTextStyle(size: 14),
                      ),
                    ],
                  )),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                decoration: boxDecorationWithRoundedCorners(
                    backgroundColor:
                        appStore.isDarkModeOn ? scaffoldDarkColor : black),
                child: Row(
                  children: [
                    Image(
                      image: AssetImage(rank),
                      width: 25,
                      height: 25,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      widget.data.skill,
                      style: boldTextStyle(size: 14, color: white),
                    )
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Column(
              children: <Widget>[
                Text(
                  widget.data.coverLetter,
                  // "I have gone through your project and it seem like a great project. I will commit for your project...",
                  style: secondaryTextStyle(),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(createRoute(ChatScreen(
                      name: this.widget.data.studentName,
                      projectId: this.widget.data.id.toInt(),
                      senderId: 1)));
                },
                child: Text("Message", style: boldTextStyle(color: grey)),
              ),
              if (widget.data.hireStatus != HIRE_STATUS.hired)
                ElevatedButton(
                  onPressed:
                      widget.data.hireStatus == HIRE_STATUS.sent_hire_status
                          ? null
                          : () {
                              _onHireHandleBtn(context);
                            },
                  child: Text(
                      widget.data.hireStatus == HIRE_STATUS.sent_hire_status
                          ? "Sent hired offer"
                          : "Hire",
                      style: boldTextStyle(color: grey)),
                ),
            ],
          )
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
      widget.data.hireStatus = HIRE_STATUS.sent_hire_status;
    });
  }
}
