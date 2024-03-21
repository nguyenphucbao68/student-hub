import 'package:carea/commons/AppTheme.dart';
import 'package:carea/commons/colors.dart';
import 'package:carea/commons/constants.dart';
import 'package:carea/commons/widgets.dart';
import 'package:carea/main.dart';
import 'package:carea/model/calling_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';

class ScheduleInterviewComponent extends StatefulWidget {
  const ScheduleInterviewComponent({
    Key? key,
    required this.scheduleMeetingCallback,
  }) : super(key: key);

  final Function scheduleMeetingCallback;

  @override
  _ScheduleInterviewComponentState createState() =>
      _ScheduleInterviewComponentState();
}

class _ScheduleInterviewComponentState
    extends State<ScheduleInterviewComponent> {
  TextEditingController titleController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  TextEditingController startTimeController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();

  FocusNode f1 = FocusNode();
  FocusNode f2 = FocusNode();
  FocusNode f3 = FocusNode();
  FocusNode f4 = FocusNode();
  FocusNode f5 = FocusNode();

  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  void selectDate(
      BuildContext context, TextEditingController controller) async {
    await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(3000),
      builder: (_, child) {
        return Theme(
          data: appStore.isDarkModeOn
              ? ThemeData.dark()
              : AppThemeData.lightTheme,
          child: child!,
        );
      },
    ).then((date) async {
      if (date != null) {
        selectedDate = date;
        controller.text =
            "${formatDate(selectedDate.toString(), format: DATE_FORMAT_3)}";
      }
    }).catchError((e) {
      toast(e.toString());
    });
  }

  void selectTime(
      BuildContext context, TextEditingController controller) async {
    await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (_, child) {
        return Theme(
          data: appStore.isDarkModeOn
              ? ThemeData.dark()
              : AppThemeData.lightTheme,
          child: child!,
        );
      },
    ).then((time) async {
      if (time != null) {
        selectedTime = time;
        controller.text = selectedTime.toString().splitBetween("(", ")");
      }
    }).catchError((e) {
      toast(e.toString());
    });
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    DateFormat formatter = DateFormat('hh:mm a');
    return SingleChildScrollView(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: context.scaffoldBackgroundColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40), topRight: Radius.circular(40)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 5),
            Center(
                child: Text('Schedule a video interview',
                    style: boldTextStyle(size: 19))),
            SizedBox(height: 5),
            Padding(
                padding: EdgeInsets.all(8.0),
                child: Divider(color: primaryColor)),
            Padding(
              padding: EdgeInsets.only(left: 8),
              child: Text(
                textAlign: TextAlign.start,
                'Title',
                style: boldTextStyle(),
              ),
            ),
            TextFormField(
              focusNode: f1,
              controller: titleController,
              decoration: inputDecoration(context, hintText: "Interview title"),
            ),
            SizedBox(height: 16),
            Padding(
                padding: EdgeInsets.only(left: 8),
                child: Text('Start time', style: boldTextStyle())),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: context.width() * 0.45,
                  alignment: Alignment.centerLeft,
                  child: TextFormField(
                    controller: startDateController,
                    focusNode: f1,
                    readOnly: true,
                    onTap: () {
                      selectDate(context, startDateController);
                    },
                    onFieldSubmitted: (v) {
                      f1.unfocus();
                      FocusScope.of(context).requestFocus(f1);
                    },
                    decoration: inputDecoration(
                      context,
                      hintText: "Start date",
                      suffixIcon: Icon(Icons.calendar_month_rounded,
                          size: 16,
                          color: appStore.isDarkModeOn ? white : gray),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Text(
                  "/",
                  style: primaryTextStyle(size: 30),
                ),
                SizedBox(width: 8),
                Container(
                  width: context.width() * 0.35,
                  alignment: Alignment.bottomRight,
                  child: TextFormField(
                    controller: startTimeController,
                    focusNode: f2,
                    readOnly: true,
                    onTap: () {
                      selectTime(context, startTimeController);
                    },
                    onFieldSubmitted: (v) {
                      f2.unfocus();
                      FocusScope.of(context).requestFocus(f2);
                    },
                    decoration: inputDecoration(
                      context,
                      hintText: "Start time",
                      suffixIcon: Icon(Icons.access_time,
                          size: 16,
                          color: appStore.isDarkModeOn ? white : gray),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Padding(
                padding: EdgeInsets.only(left: 8),
                child: Text('End time', style: boldTextStyle())),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: context.width() * 0.45,
                  alignment: Alignment.centerLeft,
                  child: TextFormField(
                    controller: endDateController,
                    focusNode: f3,
                    readOnly: true,
                    onTap: () {
                      selectDate(context, endDateController);
                    },
                    onFieldSubmitted: (v) {
                      f3.unfocus();
                      FocusScope.of(context).requestFocus(f3);
                    },
                    decoration: inputDecoration(
                      context,
                      hintText: "End date",
                      suffixIcon: Icon(Icons.calendar_month_rounded,
                          size: 16,
                          color: appStore.isDarkModeOn ? white : gray),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Text(
                  "/",
                  style: primaryTextStyle(size: 30),
                ),
                SizedBox(width: 8),
                Container(
                  width: context.width() * 0.35,
                  alignment: Alignment.bottomRight,
                  child: TextFormField(
                    controller: endTimeController,
                    focusNode: f4,
                    readOnly: true,
                    onTap: () {
                      selectTime(context, endTimeController);
                    },
                    onFieldSubmitted: (v) {
                      f4.unfocus();
                      FocusScope.of(context).requestFocus(f4);
                    },
                    decoration: inputDecoration(
                      context,
                      hintText: "End time",
                      suffixIcon: Icon(Icons.access_time,
                          size: 16,
                          color: appStore.isDarkModeOn ? white : gray),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Padding(
                padding: EdgeInsets.only(left: 8),
                child: Text('Duration: 60 minutes',
                    style:
                        TextStyle(fontSize: 15, fontStyle: FontStyle.italic))),
            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: context.width() * 0.45,
                    padding: EdgeInsets.symmetric(vertical: 12),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: appStore.isDarkModeOn
                          ? dividerDarkColor
                          : primaryColor.shade300,
                      borderRadius: BorderRadius.circular(45),
                    ),
                    child: Text(
                      "Cancel",
                      style: boldTextStyle(
                          color:
                              appStore.isDarkModeOn ? white : Colors.black54),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                GestureDetector(
                  onTap: () {
                    var meetingModel = MeetingModel();
                    meetingModel.scheduleTitle = titleController.text;
                    meetingModel.startTime = startDateController.text +
                        " " +
                        startTimeController.text;
                    meetingModel.endTime =
                        endDateController.text + " " + endTimeController.text;

                    var msgModel = BHMessageModel();
                    msgModel.msg = "A meeting was scheduled";
                    msgModel.time = formatter.format(DateTime.now());
                    msgModel.senderId = BHSender_id;
                    msgModel.meetingInfo = meetingModel;
                    widget.scheduleMeetingCallback(msgModel);
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: context.width() * 0.45,
                    padding: EdgeInsets.symmetric(vertical: 12),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: appStore.isDarkModeOn ? cardDarkColor : black,
                      borderRadius: BorderRadius.circular(45),
                    ),
                    child:
                        Text("Send Invite", style: boldTextStyle(color: white)),
                  ),
                ),
              ],
            ),
            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
