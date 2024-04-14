import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:carea/main.dart';

class UploadFile extends StatelessWidget {
  const UploadFile({super.key, required this.onTapOverride, required this.isUploaded});

  final Function onTapOverride;
  final bool isUploaded;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        this.onTapOverride();
      },
      child: DottedBorderWidget(
          // padding: EdgeInsets.all(20.0),
          color: appStore.isDarkModeOn ? cardDarkColor : Colors.black,
          radius: 20,
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Container(
              width: context.width(),
              height: 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.drive_folder_upload,
                    size: 25,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    this.isUploaded ? "Update other file" : "Select File",
                    style: boldTextStyle(size: 16),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
