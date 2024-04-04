import 'package:carea/commons/widgets.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:carea/main.dart';

class CompanyViewProjectDetailScreen extends StatefulWidget {
  const CompanyViewProjectDetailScreen({super.key});

  @override
  State<CompanyViewProjectDetailScreen> createState() =>
      _CompanyViewProjectDetailScreenState();
}

class _CompanyViewProjectDetailScreenState
    extends State<CompanyViewProjectDetailScreen>
    with SingleTickerProviderStateMixin {
  final tabs = [
    Tab(text: "Proposals"),
    Tab(
      text: "Detail",
    ),
    Tab(
      text: "Message",
    ),
    Tab(
      text: "Hired",
    )
  ];

  late final TabController? _tabController;

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  void init() async {
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBarWidget(context, automaticallyImplyLeading: false),
      body: Container(
          padding: EdgeInsets.all(12),
          height: context.height(),
          color:
              appStore.isDarkModeOn ? scaffoldDarkColor : gray.withOpacity(0.1),
          child: Container(
            child: Column(
              children: [
                TabBar(
                  controller: _tabController,
                  indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: Colors.black),
                  indicatorColor: Colors.white,
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.black,
                  tabs: tabs,
                  indicatorSize: TabBarIndicatorSize.tab,
                ),
                Expanded(
                    child: TabBarView(
                  controller: _tabController,
                  children: [
                    Text("this is Proposals view"),
                    Text("this is Detail view"),
                    Text("this is Message view"),
                    Text("this is Hired view")
                  ],
                )),
              ],
            ),
          )),
    );
  }
}