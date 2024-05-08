import 'package:carea/store/profile_ob.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  late ProfileOb profi;

  @override
  void initState() {
    super.initState();
    profi = Provider.of<ProfileOb>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ZegoUIKitPrebuiltVideoConference(
          appID: 1247576097,
          appSign:
              '7d6266f0d5e6ce71461df7593e53b9a12c2b0e5faa342a061cc45251dc8c5009',
          userID: localUserID,
          userName: profi.user?.fullName ?? 'user_$localUserID',
          conferenceID: widget.conferenceID,
          config: ZegoUIKitPrebuiltVideoConferenceConfig(
            turnOnCameraWhenJoining: false,
          )),
    );
  }
}
