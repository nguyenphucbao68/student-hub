import 'package:carea/commons/widgets.dart';
import 'package:flutter/material.dart';

class MessageFragment extends StatefulWidget {
  const MessageFragment({super.key});

  @override
  State<MessageFragment> createState() => _MessageFragmentState();
}

class _MessageFragmentState extends State<MessageFragment> {
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: commonAppBarWidget(context),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text('This is Message fragment')],
        ),
      ),
    );
  }
}