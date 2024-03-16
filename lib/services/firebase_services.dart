import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:rife_mobile_app/services/shared_pref_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/utils.dart';

class FirebaseServices {
  static updatePlayerSettings() async {
    var db = FirebaseFirestore.instance;
    final rifeMobileAppSettingsDoc = await db
        .collection("rifeMobileAppSettings")
        .doc("userDefaultAppSettings")
        .get();
    final rifeMobileAppSettingsData = rifeMobileAppSettingsDoc.data();
    final playerSettingsData = rifeMobileAppSettingsData!["playerSettings"];
    SharedPrefServices.savePlayerSettings(
        defaultPlayer: playerSettingsData["defaultPlayer"],
        defaultDuration: playerSettingsData["defaultDuration"]);
    // TODO: Modify the code; if user have updated from settings do not override the settings;
  }

  static updateSequencesMasterList() async {
    // TODO: Set a timestamp flag; if mismatch update the data to client device;
    var db = FirebaseFirestore.instance;
    // final rifeMobileAppSettingsDoc = await db.collection("rifeMobileAppSettings").doc("userDefaultAppSettings").get();
    // final rifeMobileAppSettingsData = rifeMobileAppSettingsDoc.data();
    // final playerSettingsData = rifeMobileAppSettingsData!["playerSettings"];
    // SharedPrefServices.savePlayerSettings(defaultPlayer: playerSettingsData["defaultPlayer"], defaultDuration: playerSettingsData["defaultDuration"]);
  }

  static logoutFirebaseUser() async {
    try {
      await FirebaseAuth.instance.signOut();
      print("User logged out successfully.");
      return true;
    } catch (e) {
      print("Error logging out: $e");
      return false;
      // Handle error as needed
    }
  }

  static loginWithEmailPassword(
      {required String email, required String password}) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      var userUID = userCredential.user!.uid;
      await SharedPrefServices.saveUserData(userUID: userUID);
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('***No user found for that email.***');
        Utils.showSnackBarMessage(message: "No user found for given email!");
      } else if (e.code == 'wrong-password') {
        print('***Wrong password provided for that user.***');
        Utils.showSnackBarMessage(message: "Incorrect password!");
      } else {
        Utils.showSnackBarMessage(message: "Invalid login credentials!");
      }
      return false;
    }
  }

  static signupWithEmailPassword(
      {required String email, required String password}) async {
    try {
      UserCredential userCredential =
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
          email: email,
          password: password);

      await userCredential.user!.sendEmailVerification();

      var userUID = userCredential.user!.uid;


      await SharedPrefServices.saveUserData(userUID: userUID);
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('***No user found for that email.***');
        Utils.showSnackBarMessage(message: "No user found for given email!");
      } else if (e.code == 'wrong-password') {
        print('***Wrong password provided for that user.***');
        Utils.showSnackBarMessage(message: "Incorrect password!");
      } else {
        Utils.showSnackBarMessage(message: "Invalid login credentials!");
      }
      return false;
    }
  }

  static loginSignupWithFacebook() async {
    try {
      var _auth = FirebaseAuth.instance;
      final _instance = FacebookAuth.instance;
      final result = await _instance.login();
      if (result.status == LoginStatus.success) {
        final OAuthCredential credential =
            FacebookAuthProvider.credential(result.accessToken!.token);
        final a = await _auth.signInWithCredential(credential);
        await _instance.getUserData().then((userData) async {
          await _auth.currentUser!.updateEmail(userData['email']);
        });
        var userUID = _auth.currentUser!.uid; // Extracting userUID
        await SharedPrefServices.saveUserData(userUID: userUID);
        await SharedPrefServices.saveUserData(userType: "userMobile");
        return true;
      } else if (result.status == LoginStatus.cancelled) {
        print('...Login cancelled...');
        return false;
      } else {
        print('...Error...');
        return false;
      }
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  static loginSignupWithGoogle() async {
    try {
      final FirebaseAuth _auth = FirebaseAuth.instance;
      GoogleAuthProvider _googleAuthProvider = GoogleAuthProvider();
      _auth.signInWithProvider(_googleAuthProvider);

      return true;
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      return false;
    }
  }

  static Future<void> addNewKeyValuePairToDocument({
    required String collectionName,
    required String documentID,
    required String newKey,
    required dynamic newValue,
  }) async {
    try {
      var db = FirebaseFirestore.instance;
      var documentReference = db.collection(collectionName).doc(documentID);

      var documentSnapshot = await documentReference.get();
      var existingData = documentSnapshot.data();

      print(existingData.toString());

      existingData![newKey] = newValue;

      await documentReference.update(existingData);
      print("New key-value pair added successfully to the document.");
      print(existingData.toString());

    } catch (e) {
      print("Error adding new key-value pair: $e");
    }
  }

  static saveMobileUserData({
    required String firstName,
    required String lastName,
    required String userEmail,
    required String countryCode,
    required String phoneNumber,
    required String userIssues,
    required String userType,
    required String userUID,
  }) async {
    var db = FirebaseFirestore.instance;
    var userDocs = await db.collection("userMobile");
    {
      await userDocs.doc(userUID).set({
        "userUID": userUID,
        "firstName": firstName,
        "lastName": lastName,
        "userEmail": userEmail,
        "countryCode": countryCode,
        "phoneNumber": phoneNumber,
        "userType": userType,
        "userIssues": userIssues
      });
    }
  }

  static saveFranchiseUserData({
    required String firstName,
    required String lastName,
    required String userEmail,
    required String countryCode,
    required String phoneNumber,
    required String userIssues,
    required String franchiseLocation,
    required String userType,
    required String userUID,
  }) async {
    var db = FirebaseFirestore.instance;
    var userDocs = db.collection("userFranchise");

    await userDocs.doc(userUID).set({
      "userUID": userUID,
      "firstName": firstName,
      "lastName": lastName,
      "userEmail": userEmail,
      "countryCode": countryCode,
      "phoneNumber": phoneNumber,
      "userType": userType,
      "userIssues": userIssues,
      "franchiseLocation": franchiseLocation
    });
  }

  static saveAdminUserData({
    required String userEmail,
    required String userType,
    required String userUID,
  }) async {
    var db = FirebaseFirestore.instance;
    var userDocs = db.collection("userAdmin");

    await userDocs.doc(userUID).set({
      "userUID": userUID,
      "userEmail": userEmail,
      "userType": userType
    });
  }

  static Future<Map<String, dynamic>?> getUserData(
      {required String userUID}) async {
    try {
      var db = FirebaseFirestore.instance;

      final userDataDocMobile =
          await db.collection("userMobile").doc(userUID).get();
      if (userDataDocMobile.exists) {
        return userDataDocMobile.data();
      }

      final userDataDocFranchise =
          await db.collection("userFranchise").doc(userUID).get();
      if (userDataDocFranchise.exists) {
        return userDataDocFranchise.data();
      }
      return null;
    } catch (e) {
      print("Error getting userData: $e");
      return null;
    }
  }

  static getAppConsentDocumentDetails() async {
    try {
      var db = FirebaseFirestore.instance;

      final rifeMobileAppSettingsDoc = await db
          .collection("rifeMobileAppSettings")
          .doc("userDefaultAppSettings")
          .get();

      final rifeMobileAppSettingsData = rifeMobileAppSettingsDoc.data();
      final appConsentDocDetails = rifeMobileAppSettingsData!["appConsentDocDetails"];
      return appConsentDocDetails;
    } catch (e) {
      print("Error getting userData: $e");
      return null;
    }
  }
}
