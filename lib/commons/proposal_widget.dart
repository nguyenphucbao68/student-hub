import 'dart:convert';

import 'package:carea/constants/app_constants.dart';
import 'package:carea/model/proposal.dart';
import 'package:carea/screens/candidate_profile.dart';
import 'package:carea/store/authprovider.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class ProposalWidget extends StatefulWidget {
  Proposal data;

  ProposalWidget({required this.data});

  @override
  State<ProposalWidget> createState() => _ProposalWidgetState();
}

class _ProposalWidgetState extends State<ProposalWidget> {
  late AuthProvider authStore;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    authStore = Provider.of<AuthProvider>(context);
  }

  void onHireHandle() async {
    await http
        .patch(
      Uri.parse(AppConstants.BASE_URL + '/proposal/${widget.data.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ' + authStore.token.toString(),
      },
      body: jsonEncode(<String, int>{
        'statusFlag': 1,
      }),
    )
        .then((response) {
      if (response.statusCode == 200) {
        setState(() {
          widget.data.statusFlag = 1;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(response.statusCode.toString()),
          ),
        );
      }
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Something wrong'),
        ),
      );
    });
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

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CandidateProfileScreen(
              studentId: widget.data.student!.id,
            ),
          ),
        );
      },
      child: Container(
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
                      widget.data.student!.fullname.toString(),
                      style: boldTextStyle(size: 16),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    widget.data.student?.educations != null &&
                            widget.data.student!.educations!.isNotEmpty
                        ? Text(
                            widget.data.student!.educations![0].startYear
                                    .toString() +
                                ' - ' +
                                widget.data.student!.educations![0].endYear
                                    .toString(),
                            style: boldTextStyle(size: 16),
                          )
                        : Text(
                            'No education',
                            style: boldTextStyle(size: 16),
                          ),
                  ],
                )
              ],
            ),
            SizedBox(height: 10),
            Container(
              width: width,
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
                widget.data.statusFlag == 0
                    ? GestureDetector(
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
                          child:
                              Text('Hire', style: boldTextStyle(color: white)),
                        ),
                      )
                    : Container(
                        alignment: Alignment.center,
                        width: width * 0.45,
                        padding: EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text('Sent Hired Offer',
                            style: boldTextStyle(color: white)),
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
