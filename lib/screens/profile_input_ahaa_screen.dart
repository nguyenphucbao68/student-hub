import 'package:flutter/material.dart';

class ProfileInputAhaaScreen extends StatefulWidget {
  ProfileInputAhaaScreen({Key? key, this.isAppbarNeeded, this.appBar})
      : super(key: key);
  bool? isAppbarNeeded;
  final PreferredSizeWidget? appBar;

  @override
  State<ProfileInputAhaaScreen> createState() => _ProfileInputAhaaScreenState();
}

class _ProfileInputAhaaScreenState extends State<ProfileInputAhaaScreen> {
  final _formKey = GlobalKey<FormState>();

  FocusNode f1 = FocusNode();
  FocusNode f2 = FocusNode();
  FocusNode f3 = FocusNode();

  String? selectedOption;

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
        //     ? careaAppBarWidget(context, titleText: "Fill Your Profile")
        //     : widget.appBar,
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
                    SizedBox(height: 15),
                    Text(
                      'Welcome to Student Hub',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 25),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Company name',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    TextFormField(
                      // controller: userNameController,
                      focusNode: f1,
                      onFieldSubmitted: (v) {
                        f1.unfocus();
                        FocusScope.of(context).requestFocus(f2);
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                        contentPadding: new EdgeInsets.symmetric(
                            vertical: 0, horizontal: 1.0),
                      ),
                    ),
                    SizedBox(height: 15),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Website',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    TextFormField(
                      // controller: userNickNameController,
                      focusNode: f2,
                      onFieldSubmitted: (v) {
                        f2.unfocus();
                        FocusScope.of(context).requestFocus(f3);
                      },
                      decoration: InputDecoration(
                        alignLabelWithHint: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                        contentPadding: new EdgeInsets.symmetric(
                            vertical: 1.0, horizontal: 1.0),
                      ),
                    ),
                    SizedBox(height: 15),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Description',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    TextFormField(
                      minLines: 3,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: InputDecoration(
                        alignLabelWithHint: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                        contentPadding: new EdgeInsets.symmetric(
                            vertical: 2.0, horizontal: 1.0),
                      ),
                    ),
                    SizedBox(height: 15),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'How many people are in your company',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    RadioListTile<String>(
                      title: Text("It's just me"),
                      value: "It's just me",
                      groupValue: selectedOption,
                      onChanged: (value) {
                        setState(() {
                          selectedOption = value;
                        });
                      },
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
