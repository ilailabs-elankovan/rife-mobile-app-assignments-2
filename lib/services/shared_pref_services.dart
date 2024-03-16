import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefServices {
  static savePlayerSettings({required int defaultDuration, required String defaultPlayer}) async {
    final SharedPreferences userData = await SharedPreferences.getInstance();
    userData.setInt("defaultDuration", defaultDuration);
    userData.setString("defaultPlayer", defaultPlayer);
  }

  static saveUserData({
    String? userEmail,
    bool? rememberMe,
    String? userUID,
    String? userType,
    bool? isFirstTimeUser,
    List? favPlaylistIdsList,
    List? favSeqIdsList,
    List? userIssuesList,
  }) async {
    final SharedPreferences userData = await SharedPreferences.getInstance();

    if (userEmail != null) userData.setString("userEmail", userEmail);
    if (rememberMe != null) userData.setBool("rememberMe", rememberMe);
    if (userUID != null) userData.setString("userUID", userUID);
    if (userType != null) userData.setString("userType", userType);
    if (favPlaylistIdsList!=null) userData.setStringList("favPlaylistIdsList", []);
    if (favSeqIdsList!=null) userData.setStringList("favSeqIdsList", []);
    if (userIssuesList!=null) userData.setStringList("userIssuesList", []);
  }

  static getPlayingIndex () async {
    final SharedPreferences userData = await SharedPreferences.getInstance();
    int? playingIndex = userData.getInt('playingIndex');
    return playingIndex;
  }

  static getSecondsRemaining () async {
    final SharedPreferences userData = await SharedPreferences.getInstance();
    int? playingIndex = userData.getInt('secondsRemaining');
    return playingIndex;
  }

  static getUserData({
    bool userUID = false,
    bool userType = false,
    bool userEmail = false,
    bool rememberMe = false,
    bool appConsentName = false,
    bool userIssuesList = false,
  }) async {
    final SharedPreferences userData = await SharedPreferences.getInstance();
    if(userUID){
      return userData.getString("userUID");
    }
    if(userType){
      return userData.getString("userType");
    }if(userEmail){
      return userData.getString("userEmail");
    }
    if(rememberMe){
      return userData.getBool("rememberMe");
    }
    if(appConsentName){
      return userData.getString("appConsentName");
    }
    else {
      return "";
    }
  }

  static savePlayerStatus({required String id, required int index, required int secRemaining}) async {
    final SharedPreferences userData = await SharedPreferences.getInstance();
    userData.setString("id", id);
    userData.setInt("playingIndex", index);
    userData.setInt("secondsRemaining", secRemaining);
  }

}