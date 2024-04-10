import 'dart:convert';

import 'package:carea/commons/colors.dart';
import 'package:carea/components/active_component.dart';
import 'package:carea/constants/app_constants.dart';
import 'package:carea/main.dart';
import 'package:carea/model/project.dart';
import 'package:carea/screens/search_delageate.dart';
import 'package:carea/store/authprovider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

class ProjectsFragment extends StatefulWidget {
  @override
  _ProjectsFragmentState createState() => _ProjectsFragmentState();
}

class _ProjectsFragmentState extends State<ProjectsFragment>
    with SingleTickerProviderStateMixin {
  TabController? tabController;
  late AuthProvider authStore;

  // list projects
  List<Project> projects = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    authStore = Provider.of<AuthProvider>(context);
    init();
  }

  void init() async {
    tabController = new TabController(length: 2, vsync: this);
    await getProjects(); // Call getProjects() when the widget is initialized
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  Future<void> getProjects() async {
    await http.get(
      Uri.parse(AppConstants.BASE_URL + '/project'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ' + authStore.token.toString(),
      },
    ).then((response) {
      log(response.body);
      if (response.statusCode == 200) {
        // If the server returns an OK response, then parse the JSON.
        var data = jsonDecode(response.body);

        if (data['result'] != null) {
          setState(() {
            projects = data['result']
                .map<Project>((item) => Project(
                    id: item['id'],
                    createdAt: item['createdAt'],
                    updatedAt: item['updatedAt'],
                    deletedAt: item['deletedAt'],
                    companyId: item['companyId'],
                    projectScopeFlag: item['projectScopeFlag'],
                    title: item['title'],
                    description: item['description'],
                    numberOfStudents: item['numberOfStudents'],
                    typeFlag: item['typeFlag'],
                    countProposals: item['countProposals'],
                    isFavorite: item['isFavorite']))
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

  // call getProjects()
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor:
            appStore.isDarkModeOn ? scaffoldDarkColor : editTextBgColor,
        appBar: AppBar(
          backgroundColor: context.scaffoldBackgroundColor,
          actions: [
            IconButton(
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: CustomSearchDelegate.initialize(""),
                );
              },
              icon: Icon(Icons.search, color: context.iconColor),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.favorite, color: context.iconColor),
            ),
          ],
          title: Text("StudentHub", style: boldTextStyle(size: 18)),
          elevation: 0.0,
        ),
        body: new ActiveComponent(
          data: projects,
        ),
      ),
    );
  }
}
