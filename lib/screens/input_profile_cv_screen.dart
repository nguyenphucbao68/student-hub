import 'package:carea/commons/widgets.dart';
import 'package:carea/components/upload_file.dart';
import 'package:carea/constants/app_constants.dart';
import 'package:carea/screens/dashboard_screen.dart';
import 'package:carea/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:carea/main.dart';
import 'package:file_picker/file_picker.dart';
import 'package:open_app_file/open_app_file.dart';
import 'package:provider/provider.dart';
import 'package:carea/store/authprovider.dart';
import 'package:http/http.dart' as http;

class InputProfileCVScreen extends StatefulWidget {
  const InputProfileCVScreen({super.key});

  @override
  State<InputProfileCVScreen> createState() => _InputProfileCVScreenState();
}

class _InputProfileCVScreenState extends State<InputProfileCVScreen> {
  PlatformFile? _fileCV = null;
  PlatformFile? _fileTranscript = null;
  late AuthProvider authStore;
  bool _isloading = false;

  @override
  Future<void> didChangeDependencies() async {
    log("Hello taaaa");
    authStore = Provider.of<AuthProvider>(context);
    super.didChangeDependencies();
  }

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
                    UploadFile(
                        onTapOverride: () {
                          pickSingleFile().then((file) {
                            setState(() {
                              _fileCV = file;
                            });
                          });
                        },
                        isUploaded: _fileCV != null),
                    if (_fileCV != null)
                      Align(
                          alignment: Alignment.centerLeft,
                          child: GestureDetector(
                            onTap: () {
                              OpenAppFile.open(_fileCV!.path.toString());
                            },
                            child: Padding(
                              padding: EdgeInsets.only(top: 15),
                              child: Text(
                                "${_fileCV!.name} (${(_fileCV!.size / 1024).toStringAsFixed(2)} KB)",
                                style: primaryTextStyle(
                                    size: 14,
                                    decoration: TextDecoration.underline),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          )),
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
                    UploadFile(
                      onTapOverride: () {
                        pickSingleFile().then((file) {
                          setState(() {
                            _fileTranscript = file;
                          });
                        });
                      },
                      isUploaded: _fileTranscript != null,
                    ),
                    if (_fileTranscript != null)
                      Align(
                          alignment: Alignment.centerLeft,
                          child: GestureDetector(
                            onTap: () {
                              OpenAppFile.open(
                                  _fileTranscript!.path.toString());
                            },
                            child: Padding(
                              padding: EdgeInsets.only(top: 15),
                              child: Text(
                                "${_fileTranscript!.name} (${(_fileTranscript!.size / 1024).toStringAsFixed(2)} KB)",
                                style: primaryTextStyle(
                                    size: 14,
                                    decoration: TextDecoration.underline),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          )),
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
                  setState(() {
                    _isloading = true;
                  });
                  _onSubmitAttachments();
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
                  child: _isloading
                      ? CircularProgressIndicator(
                          color: white,
                        )
                      : Text('Next', style: boldTextStyle(color: white)),
                ),
              )
            ],
          )),
    );
  }

  Future<PlatformFile?> pickSingleFile() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);

    if (result != null) {
      PlatformFile file = result.files.first;
      print(file.name);
      print(file.bytes);
      print(file.size);
      print(file.extension);
      print(file.path);

      return file;
      // file == null ? false : OpenAppFile.open(file!.path.toString());
    }
    return null;
  }

  Future<void> _onSubmitAttachments() async {
    var requestCV = await http.MultipartRequest(
      'PUT',
      Uri.parse(AppConstants.BASE_URL +
          "/profile/student/${authStore.student?.id}/resume"),
    );
    requestCV.files
        .add(await http.MultipartFile.fromPath('file', _fileCV!.path!));
    requestCV.headers['Authorization'] = 'Bearer ' + authStore.token.toString();

    var resCV = await requestCV.send();

    var requestTranscript = await http.MultipartRequest(
      'PUT',
      Uri.parse(AppConstants.BASE_URL +
          "/profile/student/${authStore.student?.id}/resume"),
    );
    requestTranscript.files
        .add(await http.MultipartFile.fromPath('file', _fileCV!.path!));
    requestTranscript.headers['Authorization'] =
        'Bearer ' + authStore.token.toString();

    var resTranscript = await requestTranscript.send();

    if (resCV.statusCode == 200 && resTranscript.statusCode == 200) {
      _handleShowDialog();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Failed to upload files"),
        ),
      );
    }

    setState(() {
      _isloading = false;
    });
  }

  void _handleShowDialog() {
    HomeScreen().launch(context, isNewTask: true);

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: Colors.white,
            child: Padding(
              padding: EdgeInsets.only(
                  top: 10.0, left: 20.0, right: 20.0, bottom: 15.0),
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
                    child: Text("Next", style: boldTextStyle(color: black)),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
