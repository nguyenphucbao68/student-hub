import 'package:carea/commons/widgets.dart';
import 'package:carea/components/calling_component.dart';
import 'package:carea/components/chat_component.dart';
import 'package:carea/main.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class MeetScreen extends StatefulWidget {
  @override
  _MeetScreenState createState() => _MeetScreenState();
}

class _MeetScreenState extends State<MeetScreen>
    with SingleTickerProviderStateMixin {
  TabController? tabController;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    tabController = new TabController(length: 2, vsync: this);
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: careaAppBarWidget(
          context,
          titleText: "Video call",
          actionWidget: IconButton(
            onPressed: () {
              //
            },
            icon: Icon(Icons.pending_outlined,
                color: context.iconColor, size: 30),
          ),
        ),
        body: Column(
          children: [
            SizedBox(
              width: width,
              height: height * 0.4,
              child: Container(
                padding: EdgeInsets.all(16),
                margin: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: Icon(
                        Icons.mic_off,
                        size: 30,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(top: 15),
                        child: Image.asset("assets/car9.png",
                            color: context.iconColor,
                            height: 40,
                            width: 40,
                            alignment: Alignment.center,
                            fit: BoxFit.cover),
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      "Alex Xu",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: width,
              height: height * 0.4,
              child: Container(
                padding: EdgeInsets.all(16),
                margin: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: Icon(
                        Icons.mic_off,
                        size: 30,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(top: 15),
                        child: Image.asset("assets/car8.png",
                            color: context.iconColor,
                            height: 40,
                            width: 40,
                            alignment: Alignment.center,
                            fit: BoxFit.cover),
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      "Luis Pham",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: width,
              height: height * 0.1,
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.mic,
                      size: 40,
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Icon(
                      Icons.videocam,
                      size: 40,
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Icon(
                      Icons.phone_disabled,
                      size: 40,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
