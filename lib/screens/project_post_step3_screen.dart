import 'package:carea/commons/widgets.dart';
import 'package:carea/main.dart';
import 'package:carea/screens/project_post_step4_screen%20.dart';
import 'package:carea/store/profile_ob.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class ProjectPostStep3Screen extends StatefulWidget {
  ProjectPostStep3Screen({Key? key, this.isAppbarNeeded, this.appBar})
      : super(key: key);
  bool? isAppbarNeeded;
  final PreferredSizeWidget? appBar;

  @override
  State<ProjectPostStep3Screen> createState() => _ProjectPostStep3ScreenState();
}

class _ProjectPostStep3ScreenState extends State<ProjectPostStep3Screen> {
  late ProfileOb profi;
  final _formKey = GlobalKey<FormState>();
  TextEditingController descriptionController = TextEditingController();
  FocusNode f1 = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    profi = Provider.of<ProfileOb>(context);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        FocusScope.of(context).unfocus();
        return true;
        // Navigator.pop(context);
        // return false;
      },
      child: Scaffold(
        appBar: careaAppBarWidget(
          context,
          titleText: "Poject post",
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
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text("3/4  Next, provide project description",
                        style: boldTextStyle(size: 18)),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(width: 10),
                      Text("-", style: TextStyle(fontSize: 15)),
                      SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                "Clear expectation about your project or deliverables",
                                style: TextStyle(fontSize: 15)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(width: 10),
                      Text("-", style: TextStyle(fontSize: 15)),
                      SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("The skills required for your project ",
                                style: TextStyle(fontSize: 15)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(width: 10),
                      Text("-", style: TextStyle(fontSize: 15)),
                      SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Detail about your project",
                                style: TextStyle(fontSize: 15)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text("Describe your project",
                        style: boldTextStyle(size: 15)),
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    controller: descriptionController,
                    focusNode: f1,
                    minLines: 5,
                    maxLines: 5,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter project description';
                      }
                      return null;
                    },
                    onFieldSubmitted: (v) {
                      f1.unfocus();
                      FocusScope.of(context).requestFocus(f1);
                    },
                    decoration:
                        inputDecoration(context, hintText: "Description"),
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        profi.setProjectDecsription(descriptionController.text);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProjectPostStep4Screen()),
                        );
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
                      child: Text('Review your post',
                          style: boldTextStyle(color: white)),
                    ),
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
