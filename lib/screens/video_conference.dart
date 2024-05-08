// import 'dart:math' as math;
// import 'package:flutter/material.dart';
// import 'package:zego_uikit_prebuilt_video_conference/zego_uikit_prebuilt_video_conference.dart';

// final String localUserID = math.Random().nextInt(10000).toString();

// const String callID = '982343240';

// class VideoConferencePage extends StatefulWidget {
//   final String conferenceID;

//   const VideoConferencePage({
//     Key? key,
//     required this.conferenceID,
//   }) : super(key: key);

//   @override
//   State<StatefulWidget> createState() => VideoConferencePageState();
// }

// class VideoConferencePageState extends State<VideoConferencePage> {
//   final controller = ZegoUIKitPrebuiltVideoConferenceController();

//   @override
//   Widget build(BuildContext context) {
//     print('da  toi');
//     try {
//       // return Container();

//       return SafeArea(
//         child: ZegoUIKitPrebuiltVideoConference(
//           appID: 1080864601,
//           appSign:
//               "9e3ba169e7b61d512d13b9d6fe63efceac69545a3aec980e446abfe38c8b4534",
//           userID: localUserID,
//           userName: 'user_$localUserID',
//           conferenceID: "conferenceID",
//           config: ZegoUIKitPrebuiltVideoConferenceConfig(),
//         ),
//       );
//     } catch (e) {
//       print('Error: $e');
//       return Container();
//     }
//   }
// }
// Flutter imports:

import 'package:flutter/material.dart';

import 'package:zego_uikit_prebuilt_video_conference/zego_uikit_prebuilt_video_conference.dart';

import 'dart:math' as math;

final String localUserID = math.Random().nextInt(10000).toString();

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
    return SafeArea(
      child: ZegoUIKitPrebuiltVideoConference(
          appID: 1247576097,
          appSign:
              '7d6266f0d5e6ce71461df7593e53b9a12c2b0e5faa342a061cc45251dc8c5009',
          userID: localUserID,
          userName: "user_$localUserID",
          conferenceID: widget.conferenceID,
          config: ZegoUIKitPrebuiltVideoConferenceConfig(
            turnOnCameraWhenJoining: false,
          )),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:zego_uikit_prebuilt_video_conference/zego_uikit_prebuilt_video_conference.dart';

// class VideoConferencePage extends StatelessWidget {
//   final String conferenceID;

//   const VideoConferencePage({
//     Key? key,
//     required this.conferenceID,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: ZegoUIKitPrebuiltVideoConference(
//         appID: 1247576097,
//         appSign:
//             "7d6266f0d5e6ce71461df7593e53b9a12c2b0e5faa342a061cc45251dc8c5009",
//         userID: 'user_id',
//         userName: 'user_name',
//         conferenceID: conferenceID,
//         config: ZegoUIKitPrebuiltVideoConferenceConfig(),
//       ),
//     );
//   }
// }
