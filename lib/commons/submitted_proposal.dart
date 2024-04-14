import 'package:carea/commons/data_provider.dart';
import 'package:carea/commons/project_widget.dart';
import 'package:carea/commons/submitted_proposal_widget.dart';
import 'package:carea/model/calling_model.dart';
import 'package:flutter/material.dart';
import 'package:carea/model/proposal.model.dart';

class SubmittedProposal extends StatefulWidget {
  List<ProposalModel> activeData;


  SubmittedProposal({required this.activeData});

  @override
  _SubmittedProposalState createState() => _SubmittedProposalState();
}

class _SubmittedProposalState extends State<SubmittedProposal> {
  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: widget.activeData.length,
      padding: EdgeInsets.only(left: 5, bottom: 16, right: 5, top: 24),
      itemBuilder: (context, index) {
        ProposalModel data = widget.activeData[index];

        return SubmittedProposalWidget(data: data,);
      },
    );
  }
}
