import 'package:carea/screens/profile_input_nhap_screen.dart';
import 'package:flutter/material.dart';
import 'package:carea/screens/profile_input_nhap_screen.dart';

class SwitchAccountScreen extends StatefulWidget {
  SwitchAccountScreen({Key? key, this.isAppbarNeeded, this.appBar})
      : super(key: key);
  bool? isAppbarNeeded;
  final PreferredSizeWidget? appBar;

  @override
  State<SwitchAccountScreen> createState() => _SwitchAccountScreenState();
}

class _SwitchAccountScreenState extends State<SwitchAccountScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController accountController = TextEditingController();

  bool isListVisible = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        FocusScope.of(context).unfocus();
        return true;
      },
      child: Scaffold(
        // appBar: (widget.isAppbarNeeded == null)
        // ? careaAppBarWidget(context, titleText: "Fill Your Profile")
        // : widget.appBar,
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(16),
            alignment: Alignment.center,
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        isListVisible = !isListVisible;
                      });
                    },
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          Icon(Icons.person, color: Colors.black, size: 38),
                          SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Hai Pham', // Text lớn
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              Text(
                                'Company', // Text nhỏ
                                style: TextStyle(
                                    fontSize: 14, color: Colors.grey[800]),
                              ),
                            ],
                          ),
                          SizedBox(width: 150),
                          Icon(
                            Icons.keyboard_arrow_up,
                            size: 38,
                            color: Colors.black,
                          )
                        ],
                      ),
                    ),
                  ),
                  if (isListVisible) ...[
                    SizedBox(
                      height: 200,
                      width: 340,
                      child: ListView(
                        children: [
                          ListTile(
                            leading: Icon(Icons.person), // Icon
                            title: Text('Hai Pham Student 1'), // Text 1
                            subtitle: Text('Student'), // Text 2
                          ),
                          Divider(
                            color: Colors.black,
                            indent: 30,
                            endIndent: 30,
                          ),
                          ListTile(
                            leading: Icon(Icons.person), // Icon
                            title: Text('Hai Pham Student 3'), // Text 1
                            subtitle: Text('Student'), // Text 2
                          ),
                        ],
                      ),
                    ),
                  ],
                  Divider(
                    color: Colors.black,
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProfileInputNhapScreen()),
                      );
                    },
                    icon: Icon(Icons.person),
                    label: Text(
                        'Profiles                                                          '),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 30),
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0)),
                      padding: EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                  Divider(
                    color: Colors.black,
                    indent: 30,
                    endIndent: 30,
                  ),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.settings),
                    label: Text(
                        'Settings                                                          '),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 30),
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0)),
                      padding: EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                  Divider(
                    color: Colors.black,
                    indent: 30,
                    endIndent: 30,
                  ),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.logout),
                    label: Text(
                        'Log out                                                          '),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 30),
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0)),
                      padding: EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                  Divider(
                    color: Colors.black,
                    indent: 30,
                    endIndent: 30,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
