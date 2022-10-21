import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:jitsi_meet/feature_flag/feature_flag.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:zoom_clone_tutorial/resources/auth_methods.dart';
import 'package:zoom_clone_tutorial/resources/firestore_methods.dart';

class JitsiMeetMethods {
  final AuthMethods _authMethods = AuthMethods();
  final FirestoreMethods _firestoreMethods = FirestoreMethods();

  void createMeeting({
    required String roomName,
    required bool isAudioMuted,
    required bool isVideoMuted,
    String username = '',
  }) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user!=null){
    try {
      FeatureFlag featureFlag = FeatureFlag();
      featureFlag.welcomePageEnabled = false;
      featureFlag.resolution = FeatureFlagVideoResolution
          .MD_RESOLUTION; // Limit video resolution to 360p
      String name;
       

      if (username.isEmpty) {
        name =user.displayName!;
      } else {
        name = username;
      }
      var options = JitsiMeetingOptions(room: roomName)
        ..userDisplayName = name
        ..userEmail = user.email
        ..userAvatarURL = user.photoURL
        ..audioMuted = isAudioMuted
        ..videoMuted = isVideoMuted;

      _firestoreMethods.addToMeetingHistory(roomName);
      await JitsiMeet.joinMeeting(options);
    } catch (error) {
      log("error: $error");
    }}
  }
}
