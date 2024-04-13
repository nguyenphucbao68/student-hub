import 'package:carea/commons/widgets.dart';
import 'package:carea/components/upload_file.dart';
import 'package:carea/screens/dashboard_screen.dart';
import 'package:carea/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:carea/main.dart';
import 'package:file_picker/file_picker.dart';
import 'package:open_app_file/open_app_file.dart';

class InputProfileCVScreen extends StatefulWidget {
  const InputProfileCVScreen({super.key});

  @override
  State<InputProfileCVScreen> createState() => _InputProfileCVScreenState();
}

class _InputProfileCVScreenState extends State<InputProfileCVScreen> {
  PlatformFile? file;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBarWidget(
        context,
      ),
      body: Container(
          padding: EdgeInsets.all(20),
          height: context.height(),
          color:
              appStore.isDarkModeOn ? scaffoldDarkColor : gray.withOpacity(0.1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Column(
                  children: [
                    Text(
                      "CV & Transcript",
                      style: boldTextStyle(size: 18),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Tell us about your self and you will be on your way connect with real-world project",
                      style: primaryTextStyle(size: 14),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Resume/CV (*)",
                        style: boldTextStyle(size: 14),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    UploadFile(onTapOverride: pickSingleFile),
                    SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Transcript (*)",
                        style: boldTextStyle(size: 14),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    UploadFile(onTapOverride: pickSingleFile),
                    SizedBox(
                      height: 100,
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //       builder: (context) => RegistrationScreen()),
                  // );
                  HomeScreen().launch(context, isNewTask: true);
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Dialog(
                          backgroundColor: Colors.white,
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: 10.0,
                                left: 20.0,
                                right: 20.0,
                                bottom: 15.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Welcome",
                                  style: boldTextStyle(size: 14),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Text(
                                    "Welcome to StudentHub, a marketplace to connect Student <> Real-world projects"),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text("Next",
                                      style: boldTextStyle(color: black)),
                                ),
                              ],
                            ),
                          ),
                        );
                      });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  // width: MediaQuery.of(context).size.width * 0.4,
                  // margin: EdgeInsets.all(8),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: appStore.isDarkModeOn ? cardDarkColor : Colors.black,
                    borderRadius: BorderRadius.circular(35),
                  ),
                  child: Text('Next', style: boldTextStyle(color: white)),
                ),
              )
            ],
          )),
    );
  }

  Future<void> pickSingleFile() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);

    if (result != null) {
      file = result.files.first;
      file == null ? false : OpenAppFile.open(file!.path.toString());
    }
  }
}
