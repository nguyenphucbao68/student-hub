import 'package:carea/commons/submitted_proposal.dart';
import 'package:carea/commons/widgets.dart';
import 'package:carea/main.dart';
import 'package:carea/screens/project_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:carea/model/proposal.model.dart';

class SendHireOffer extends StatefulWidget {
  const SendHireOffer({super.key});

  @override
  State<SendHireOffer> createState() => _SendHireOfferState();
}

class _SendHireOfferState extends State<SendHireOffer>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  List<ProposalModel> rd2Hire = ProposalModel.getReadyToHireProposals();
  List<ProposalModel> hired = ProposalModel.getHiredProposals();

  final tabs = const [
    Tab(text: 'Proposals'),
    Tab(text: 'Detail'),
    Tab(text: 'Message'),
    Tab(text: 'Hired'),
  ];

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    //
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBarWidget(context, automaticallyImplyLeading: true),
      body: Container(
        padding: EdgeInsets.all(12),

        color:
            appStore.isDarkModeOn ? scaffoldDarkColor : gray.withOpacity(0.1),
        height: context.height(),
        // width: context.width(),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(15),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Senior frontend developer (Fintech)",
                  style: boldTextStyle(size: 16),
                ),
              ),
            ),
            TabBar(
              controller: _tabController,
              indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.black),
              indicatorColor: Colors.white,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.black,
              tabs: tabs,
              // font size
              labelStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
              // font weight
              indicatorSize: TabBarIndicatorSize.tab,
            ),
            Expanded(
                child: TabBarView(
              children: [
                SubmittedProposal(
                  activeData: rd2Hire,
                ),
                ProjectDetailScreen(),
                Placeholder(),
                SubmittedProposal(
                  activeData: hired,
                )
              ],
              controller: _tabController,
            ))
          ],
        ),
      ),
    );
  }
}
