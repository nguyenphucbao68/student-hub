import 'dart:convert';

import 'package:carea/commons/widgets.dart';
import 'package:carea/constants/app_constants.dart';
import 'package:carea/main.dart';
import 'package:carea/screens/welcome_screen.dart';
import 'package:carea/store/authprovider.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class ProfileInputNhapScreen extends StatefulWidget {
  ProfileInputNhapScreen({Key? key, this.isAppbarNeeded, this.appBar})
      : super(key: key);
  bool? isAppbarNeeded;
  final PreferredSizeWidget? appBar;

  @override
  State<ProfileInputNhapScreen> createState() => _ProfileInputNhapScreenState();
}

class _ProfileInputNhapScreenState extends State<ProfileInputNhapScreen> {
  late AuthProvider authStore;

  final _formKey = GlobalKey<FormState>();
  FocusNode f1 = FocusNode();
  TextEditingController companyNameController = TextEditingController();
  TextEditingController websiteController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  final List<String> compSizeList = [
    "It's just me",
    "2-9 employees",
    "10-99 employees",
    "100-1000 employees",
    "More than 1000 employees",
  ];
  var compSize = '';
  final List<int> compSizeListInt = [1, 5, 55, 555, 1001];

  @override
  void initState() {
    super.initState();
    compSize = compSizeList[0];
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    authStore = Provider.of<AuthProvider>(context);
  }

  void hadleCreateCompany() async {
    final name = companyNameController.text;
    final size = compSizeListInt[compSizeList.indexOf(compSize)];
    final web = websiteController.text;
    final desc = descriptionController.text;

    await http
        .post(
      Uri.parse(AppConstants.BASE_URL + '/profile/company'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ' + authStore.token.toString(),
      },
      body: jsonEncode({
        "companyName": name,
        "size": size,
        "website": web,
        "description": desc
      }),
    )
        .then((response) {
      if (response.statusCode == 201) {
        var data = jsonDecode(response.body);
        if (data['result'] != null) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => WelcomeScreen()),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(data['message']),
            ),
          );
        }
      } else {
        print(response.statusCode);
      }
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.toString()),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        FocusScope.of(context).unfocus();
        return true;
      },
      child: Scaffold(
        appBar: careaAppBarWidget(
          context,
          titleText: "Company Profile",
          actionWidget: IconButton(
              onPressed: () {},
              icon: Icon(Icons.person, color: context.iconColor)),
        ),
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
                      alignment: Alignment.center,
                      child: Text(
                        'Tell us about your company and you will be on your way connect with high-skilled students',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(height: 25),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text('How many people are in your company?',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15))),
                    SizedBox(height: 15),
                    SizedBox(
                      height: 350,
                      child: ListView.separated(
                        controller: ScrollController(),
                        itemCount: compSizeList.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 10),
                        itemBuilder: (context, index) => Container(
                          margin: EdgeInsets.only(bottom: 8),
                          decoration: boxDecorationWithRoundedCorners(
                            borderRadius: BorderRadius.all(
                                Radius.circular(defaultRadius)),
                            backgroundColor: Colors.grey.shade200,
                          ),
                          padding: EdgeInsets.symmetric(vertical: 6),
                          child: RadioListTile(
                            visualDensity: VisualDensity(
                                horizontal: VisualDensity.minimumDensity,
                                vertical: VisualDensity.minimumDensity),
                            title: Row(
                              children: [
                                SizedBox(width: 16),
                                Text(compSizeList[index],
                                    style: primaryTextStyle()),
                              ],
                            ),
                            controlAffinity: ListTileControlAffinity.trailing,
                            value: compSizeList[index],
                            groupValue: compSize,
                            activeColor: context.iconColor,
                            hoverColor: Colors.black,
                            onChanged: (value) {
                              setState(() {
                                compSize = value.toString();
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text("Company name",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15)),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: companyNameController,
                      focusNode: f1,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter company name';
                        }
                        return null;
                      },
                      onFieldSubmitted: (v) {
                        f1.unfocus();
                        FocusScope.of(context).requestFocus(f1);
                      },
                      decoration:
                          inputDecoration(context, hintText: "Company name"),
                    ),
                    SizedBox(height: 15),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text("Website",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15)),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: websiteController,
                      decoration: inputDecoration(context, hintText: "Website"),
                    ),
                    SizedBox(height: 15),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text("Description",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15)),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: descriptionController,
                      minLines: 3,
                      maxLines: 3,
                      decoration:
                          inputDecoration(context, hintText: "Description"),
                    ),
                    SizedBox(height: 15),
                    GestureDetector(
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          hadleCreateCompany();
                        }
                      },
                      child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                          color: appStore.isDarkModeOn
                              ? cardDarkColor
                              : Colors.black,
                          borderRadius: BorderRadius.circular(45),
                        ),
                        child: Text('Continue',
                            style: boldTextStyle(color: white)),
                      ),
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
