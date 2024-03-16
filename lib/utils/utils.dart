import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rife_mobile_app/screens/onboarding_screens.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/firebase_services.dart';
import '../services/shared_pref_services.dart';
import 'constants.dart';
import 'globals.dart';

class Utils {
  static showSnackBarMessage ({required String message}){
    final SnackBar snackBar = SnackBar(
      content: Text(message),
      backgroundColor: snackBarBackgroundColor,
      showCloseIcon: true,
      // TODO: Check if the duration is sufficient or increase
    );
    snackbarKey.currentState?.showSnackBar(snackBar);
    return snackBar;
  }

  static updatePlayerSettings() async {
    var playerSettingsData = await FirebaseServices.updatePlayerSettings();
    var defaultDuration = playerSettingsData["defaultDuration"];
    var defaultPlayer = playerSettingsData["defaultPlayer"];
    await SharedPrefServices.savePlayerSettings(defaultDuration: defaultDuration, defaultPlayer: defaultPlayer);
  }

  static navigateToScreen({required Widget screen, required BuildContext context}) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  static getDeviceData() async {
    if(Platform.isAndroid){
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      String platform = 'Android';
      String product = androidInfo.product;
      String id = androidInfo.id;
      String version = androidInfo.version.toString();
      String brand = androidInfo.brand;

      var data = {
        "platform": platform,
        "product": product,
        "id": id,
        "version": version,
        "brand": brand
      };

      return data;
    }
    if(Platform.isIOS){
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      String platform = 'Ios';
      String name = iosInfo.name;
      String model = iosInfo.model;
      String sysVersion = iosInfo.systemVersion;

      var data = {
        "platform": platform,
        "name": name,
        "model": model,
        "sysVersion": sysVersion
      };
      return data;
    }

  }

  static getAppConsentDetails() async {
    var getAppConsentDocumentDetails = await FirebaseServices.getAppConsentDocumentDetails();
    String time = DateTime.now().toString();
    String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    var docId = getAppConsentDocumentDetails["docId"];
    var docVersion = getAppConsentDocumentDetails["docVersion"];

    var data = {
      "time": time,
      "timestamp": timestamp,
      "docVersion": docVersion,
      "docId": docId
    };
    return data;
  }

}

Future<String?> getUserType() async {
  final SharedPreferences userData = await SharedPreferences.getInstance();
  return userData.getString('userType');
}

Future<String?> getUserUID() async {
  final SharedPreferences userData = await SharedPreferences.getInstance();
  return userData.getString('userUID');
}


void navigateToScreen({required Widget builder, required BuildContext context}) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => builder),
  );
}

void getRifeMobileAppSettings() {
  // todo: get data setting from backend;
  // NOTE: if parameter 'lasUpdated' time stamp is different update the seq-list and freq-list; else do not invoke the API call
}

