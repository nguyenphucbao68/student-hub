import 'dart:convert';

import 'package:carea/commons/constants.dart';
import 'package:carea/commons/data_provider.dart';
import 'package:carea/commons/images.dart';
import 'package:carea/components/active_component.dart';
import 'package:carea/components/project_filter_component.dart';
import 'package:carea/constants/app_constants.dart';
import 'package:carea/main.dart';
import 'package:carea/model/calling_model.dart';
import 'package:carea/model/project.dart';
import 'package:carea/store/authprovider.dart';
import 'package:carea/store/logicprovider.dart';
import 'package:carea/store/search_delagete_ob.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../commons/colors.dart';

class CustomSearchDelegate extends SearchDelegate {
  LogicProvider logi = LogicProvider();

  SearchDelegateOb ob = SearchDelegateOb();
  SearchDelegateOb ob1 = SearchDelegateOb();
  SearchDelegateOb ob2 = SearchDelegateOb();
  SearchDelegateOb ob3 = SearchDelegateOb();
  late AuthProvider authStore;
  Map<String, Object> filters = {};

  String textFromUser = "";

  CustomSearchDelegate.initialize(this.textFromUser) {
    query = textFromUser;
  }

  Future<List<Project>> searchProjects(
      String token, Map<String, Object> filters) async {
    List<Project> projects = [];
    filters["title"] = query;

    log("filter" + filters.toString());

    final uri = Uri.parse(AppConstants.BASE_URL + '/project').replace(
      queryParameters: filters,
    );

    final response = await http.get(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ' + token,
      },
    );
    log(response.body);
    if (response.statusCode == 200) {
      // If the server returns an OK response, then parse the JSON.
      var data = jsonDecode(response.body);
      log(data);

      if (data['result'] != null) {
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
        return projects;
      } else {
        log('error');
        // show error message
        return [];
      }
    } else {
      // If the server returns an error response, then throw an exception.
      // throw Exception('Failed to login');
      log('Failed to login 2');
      return [];
    }
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return [
      IconButton(
        icon: Icon(Icons.filter_list_alt, color: context.iconColor, size: 30),
        onPressed: () {
          showModalBottomSheet(
            enableDrag: true,
            isDismissible: true,
            isScrollControlled: true,
            constraints: BoxConstraints(
                maxHeight: height * 0.88,
                maxWidth: width,
                minHeight: height * 0.6,
                minWidth: width),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(60), topRight: Radius.circular(60)),
            ),
            context: context,
            builder: (context2) {
              return ProjectFilterComponent(
                  updateSearchResults: (data) {
                    filters = data;
                    query = query;
                    showResults(context);
                  },
                  defaultFilters: filters);
            },
          );
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.search, color: context.iconColor, size: 30),
      onPressed: () {
        close(context, null);
      },
    );
  }

  Future<List<Project>> projectsData = Future.value([]);

  @override
  Widget buildResults(BuildContext context) {
    log("query: $query");
    authStore = Provider.of<AuthProvider>(context);
    double width = MediaQuery.of(context).size.width;
    if (query != " " && !query.contains(" ")) {
      logi.searclist.add(query);
    }
    projectsData = searchProjects(authStore.token ?? "", filters);
    return FutureBuilder<List<Project>>(
        future: projectsData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }
          log(snapshot.data);
          if (snapshot.data?.length == 0) {
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: width * 0.15),
                Image(
                    height: width * 0.65,
                    width: width * 0.65,
                    fit: BoxFit.fitHeight,
                    image: AssetImage(wrongkeyword)),
                Text('Not Found',
                    style: TextStyle(
                        color: primaryBlackColor,
                        fontSize: 26,
                        fontWeight: FontWeight.bold)),
                SizedBox(height: width * 0.07),
                Text(
                  textAlign: TextAlign.center,
                  "Sorry, The Keyword you enter cannot be \nfond. please check again or search with \nanother keyword",
                  style: TextStyle(fontSize: 14),
                )
              ],
            ));
          }

          return SingleChildScrollView(
            child: Container(
              color:
                  appStore.isDarkModeOn ? scaffoldDarkColor : editTextBgColor,
              child: new ActiveComponent(
                data: snapshot.data ?? [],
              ),
            ),
          );
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    // Creating For Result List Of Items
    List txt = projectNames
        .where((element) => element.startsWith(query.toString()))
        .toList();
    // Nothing Found Screen
    if (txt.isEmpty) {
      return SingleChildScrollView(
        child: Container(
          color: context.scaffoldBackgroundColor,
          child: Column(
            children: [
              ListTile(
                minVerticalPadding: 0,
                title: Text("Recent", style: primaryTextStyle()),
                trailing: GestureDetector(
                  onTap: () {
                    logi.searclist
                        .removeWhere((element) => logi.searclist[0] != null);
                  },
                  child: Text('Clear all', style: primaryTextStyle()),
                ),
              ),
              Divider(height: 0.0),
              Observer(
                builder: (context) => ListView.builder(
                  reverse: true,
                  shrinkWrap: true,
                  padding: EdgeInsets.all(0),
                  itemCount: logi.searclist.length,
                  itemBuilder: (context, index) {
                    return Container(
                      width: width,
                      margin: EdgeInsets.only(bottom: 8),
                      alignment: Alignment.topLeft,
                      child: Observer(
                        builder: (context) => ListTile(
                          title: Text(
                              style: primaryTextStyle(),
                              "${logi.searclist[index]}"),
                          trailing: IconButton(
                            onPressed: () {
                              logi.removeElementToSearchList(index);
                            },
                            padding: EdgeInsets.all(4),
                            icon: Icon(Icons.cancel, size: 18),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      );
    }
    // Resent Screen
    if (query.length < 2) {
      return SingleChildScrollView(
        child: Container(
          color: context.scaffoldBackgroundColor,
          height: context.height(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              /* ListTile(
                title: Text('Result for "$query"', style: boldTextStyle(size: 18)),
                trailing: Text("0 found", style: boldTextStyle(size: 18)),
              ),*/
              SizedBox(height: width * 0.15),
              Image(
                  height: width * 0.65,
                  width: width * 0.65,
                  fit: BoxFit.fitHeight,
                  image: AssetImage(wrongkeyword)),
              Center(child: Text('Not Found', style: boldTextStyle(size: 22))),
              SizedBox(height: 16),
              Center(
                child: Text(
                  textAlign: TextAlign.center,
                  "Sorry, The Keyword you enter cannot be \nfond. please check again or search with \nanother keyword",
                  style: secondaryTextStyle(),
                ),
              )
            ],
          ),
        ),
      );
    }
    // Result Screen
    return Container(
      color: context.scaffoldBackgroundColor,
      alignment: Alignment.topCenter,
      padding: EdgeInsets.all(8),
      child: ListView.builder(
        itemCount: txt.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Divider(
                    height: 0.0,
                    color:
                        appStore.isDarkModeOn ? white : primaryColor.shade300),
                16.height,
                Text(txt[index], style: primaryTextStyle()),
                if (index == txt.length - 1) ...[
                  16.height,
                  Divider(
                      height: 0.0,
                      color:
                          appStore.isDarkModeOn ? white : primaryColor.shade300)
                ]
              ],
            ),
            onTap: () {
              query = txt[index];
              showResults(context);
            },
          );
        },
      ),
    );
  }
}
