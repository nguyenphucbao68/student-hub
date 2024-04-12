import 'dart:convert';

import 'package:carea/commons/project_widget_dashboard.dart';
import 'package:carea/commons/proposal_widget.dart';
import 'package:carea/model/user_info.dart';
import 'package:carea/store/profile_ob.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:carea/constants/app_constants.dart';
import 'package:carea/model/project.dart';
import 'package:carea/store/authprovider.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class AllProposalScreen extends StatefulWidget {
  Proposal? data = Proposal();
  AllProposalScreen({this.data});
  @override
  _AllProposalScreenState createState() => _AllProposalScreenState();
}

class _AllProposalScreenState extends State<AllProposalScreen> {
  late AuthProvider authStore;
  late ProfileOb profi;

  List<Proposal> proposalData = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    authStore = Provider.of<AuthProvider>(context);
    profi = Provider.of<ProfileOb>(context);
    // profi.addListener()
    init();
  }

  void init() async {
    await getProposals();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  Future<void> getProposals() async {
    if (profi.projectInfo == null) return Navigator.pop(context);
    int? projectID = profi.projectInfo!.id;
    await http.get(
      Uri.parse(AppConstants.BASE_URL + '/proposal/getByProjectId/$projectID'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ' + authStore.token.toString(),
      },
    ).then((response) {
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        if (data['result'] != null) {
          setState(() {
            proposalData = data['result']['items']
                .map<Proposal>((item) => Proposal(
                      id: item['id'],
                      createdAt: item['createdAt'],
                      updatedAt: item['updatedAt'],
                      deletedAt: item['deletedAt'],
                      projectId: item['projectId'],
                      studentId: item['studentId'],
                      coverLetter: item['coverLetter'],
                      statusFlag: item['statusFlag'],
                      disableFlag: item['disableFlag'],
                      student: Student(
                        id: item['student']['id'],
                        createdAt: item['student']['createdAt'],
                        updatedAt: item['student']['updatedAt'],
                        deletedAt: item['student']['deletedAt'],
                        userId: item['student']['userId'],
                        techStackId: item['student']['techStackId'],
                        resume: item['student']['resume'],
                        transcript: item['student']['transcript'],
                        user: (fullname: item['student']['user']['fullname']),
                        educations: item['student']['educations'],
                      ),
                    ))
                .toList();
          });
        } else {
          log('error');
          // show error message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(data['message']),
            ),
          );
        }
      } else {
        // If the server returns an error response, then throw an exception.
        // throw Exception('Something wrong');
        log('Something wrong');
      }
    }).catchError((error) {
      log('Something wrong' + error.toString());
      // show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Something wrong'),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileOb>(builder: (context, profi, child) {
      getProposals();
      return SingleChildScrollView(
          child: Container(
              color: context.scaffoldBackgroundColor,
              padding: EdgeInsets.only(bottom: 16),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: proposalData.length,
                padding: EdgeInsets.only(top: 10),
                itemBuilder: (context, index) {
                  Proposal data = proposalData[index];
                  return ProposalWidget(data: data);
                },
              )));
    });
  }
}
