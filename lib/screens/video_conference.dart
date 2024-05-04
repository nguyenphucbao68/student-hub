// import 'dart:math' as math;
// import 'package:flutter/material.dart';
// import 'package:zego_uikit_prebuilt_video_conference/zego_uikit_prebuilt_video_conference';

// final String localUserID = math.Random().nextInt(10000).toString();

// const String callID = 'group_call_id';

// class VideoConferencePage extends StatefulWidget {
//   final String conferenceID;

//   const VideoConferencePage({
//     super.key,
//     required this.conferenceID,
//   });

//   @override
//   State<StatefulWidget> createState() => VideoConferencePageState();
// }

// class VideoConferencePageState extends State<VideoConferencePage> {
//   final controller = ZegoUIKitPrebuiltVideoConferenceController();

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: ZegoUIKitPrebuiltVideoConference(
//           appID: 1080864601,
//           appSign:
//               "9e3ba169e7b61d512d13b9d6fe63efceac69545a3aec980e446abfe38c8b4534",
//           conferenceID: widget.conferenceID,
//           userID: localUserID,
//           userName: "user_$localUserID",
//           config: ZegoUIKitPrebuiltVideoConferenceConfig(
//             turnOnCameraWhenJoining: false,
//             audioVideoViewConfig:
//                 ZegoPrebuiltAudioVideoViewConfig(showCameraStateOnView: false),
//             topMenuBarConfig: ZegoTopMenuBarConfig(
//               buttons: [ZegoMenuBarButtonName.showMemberListButton],
//             ),
//             bottomMenuBarConfig: ZegoBottomMenuBarConfig(
//               buttons: [
//                 ZegoMenuBarButtonName.toggleMicrophoneButton,
//                 ZegoMenuBarButtonName.leaveButton,
//                 ZegoMenuBarButtonName.switchAudioOutputButton,
//               ],
//             ),
//             avatarBuilder: (BuildContext context, Size size,
//                 ZegoUIKitUser? user, Map extraInfo) {
//               return user != null
//                   ? Container(
//                       decoration: const BoxDecoration(
//                         shape: BoxShape.circle,
//                         image: DecorationImage(
//                           image: NetworkImage(
//                             'https://media.istockphoto.com/id/1302783988/vector/the-embarrassed-man.jpg?s=612x612&w=0&k=20&c=bIPvdEHEGAP0RnSH5n45dvHfsqvZKv8NwG5qjRWCNTg=',
//                           ),
//                         ),
//                       ),
//                     )
//                   : const SizedBox();
//             },
//           )),
//     );
//   }
// }
