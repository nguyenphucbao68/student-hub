import 'package:flutter/material.dart';
import 'package:carea/commons/widgets.dart';

class ProjectFragment extends StatefulWidget {
  const ProjectFragment({super.key});

  @override
  State<ProjectFragment> createState() => _ProjectFragmentState();
}

class _ProjectFragmentState extends State<ProjectFragment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBarWidget(context),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text('This is Project fragment')],
        ),
      ),
    );
  }
}
