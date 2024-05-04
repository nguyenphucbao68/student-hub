import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_video_conference/zego_uikit_prebuilt_video_conference.dart';

final String localUserID = math.Random().nextInt(10000).toString();

const String callID = '982343240';

class VideoConferencePage extends StatefulWidget {
  final String conferenceID;

  const VideoConferencePage({
    super.key,
    required this.conferenceID,
  });

  @override
  State<StatefulWidget> createState() => VideoConferencePageState();
}

class VideoConferencePageState extends State<VideoConferencePage> {
  final controller = ZegoUIKitPrebuiltVideoConferenceController();

  @override
  Widget build(BuildContext context) {
    print('da  toi');
    try {
      return Container();

      // return SafeArea(
      //   child: ZegoUIKitPrebuiltVideoConference(
      //     appID: 1080864601,
      //     appSign:
      //         "9e3ba169e7b61d512d13b9d6fe63efceac69545a3aec980e446abfe38c8b4534",
      //     userID: localUserID,
      //     userName: 'user_$localUserID',
      //     conferenceID: "conferenceID",
      //     config: ZegoUIKitPrebuiltVideoConferenceConfig(),
      //   ),
      // );
    } catch (e) {
      print('Error: $e');
      return Container();
    }
  }
}
