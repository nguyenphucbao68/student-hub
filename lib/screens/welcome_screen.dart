import 'package:flutter/material.dart';
import 'package:carea/commons/widgets.dart';
import 'package:carea/commons/widgets.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBarWidget(context),
      body: Container(
        child: Column(
          children: [
            Text('Welcome Hai!'),
            Text('Let\'s start with your first project post'),
            customButton(txt: 'Get started!')
          ],
        ),
      ),
    );
  }
}
