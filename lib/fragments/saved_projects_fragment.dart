import 'dart:convert';

import 'package:carea/commons/colors.dart';
import 'package:carea/components/active_component.dart';
import 'package:carea/constants/app_constants.dart';
import 'package:carea/main.dart';
import 'package:carea/model/project.dart';
import 'package:carea/screens/project_search_screen.dart';
import 'package:carea/store/authprovider.dart';
import 'package:carea/store/profile_ob.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class SavedProjectsFragment extends StatefulWidget {
  const SavedProjectsFragment({Key? key}) : super(key: key);

  @override
  _SavedProjectsFragmentState createState() => _SavedProjectsFragmentState();
}

class _SavedProjectsFragmentState extends State<SavedProjectsFragment> {
  TabController? tabController;
  late AuthProvider authStore;
  late ProfileOb profi;
  List<Project> projects = [];

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    authStore = Provider.of<AuthProvider>(context);
    profi = Provider.of<ProfileOb>(context);
    getFavoriteProjects();
  }

  void init() async {}

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  Future<void> getFavoriteProjects() async {
    if (profi.user?.student == null) return;

    await http.get(
      Uri.parse(AppConstants.BASE_URL +
          '/favoriteProject/' +
          profi.user!.student!.id.toString()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ' + authStore.token.toString(),
      },
    ).then((response) {
      log(response.body);
      if (response.statusCode == 200) {
        // If the server returns an OK response, then parse the JSON.
        var data = jsonDecode(response.body);
        log("response.body" + response.body);
        if (data['result'] != null) {
          setState(() {
            projects = data['result']
                .map<Project>((item) => Project().parse(item['project']))
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
        // throw Exception('Failed to login');
        log('Failed to login 2');
      }
    }).catchError((error) {
      log('Failed to login' + error.toString());
      // show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to login'),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          appStore.isDarkModeOn ? scaffoldDarkColor : editTextBgColor,
      appBar: AppBar(
        backgroundColor: context.scaffoldBackgroundColor,
        leading: Transform.scale(
          scale: 0.7,
          child: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: context.iconColor),
            onPressed: () {
              finish(context);
            },
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProjectSearchScreen()),
              );
            },
            icon: Icon(Icons.search, color: context.iconColor),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.chat, color: context.iconColor),
          ),
        ],
        title: Text(appStore.favoriteProjects, style: boldTextStyle(size: 18)),
        elevation: 0.0,
      ),
      body: new ActiveComponent(
        data: projects,
      ),
    );
  }
}
