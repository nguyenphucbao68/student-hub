import 'package:flutter/material.dart';
import 'package:carea/commons/widgets.dart';

class AlertFragment extends StatefulWidget {
  const AlertFragment({super.key});

  @override
  State<AlertFragment> createState() => _AlertFragmentState();
}

class _AlertFragmentState extends State<AlertFragment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBarWidget(context),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text('This is Alert fragment')],
        ),
      ),
    );
  }
}
