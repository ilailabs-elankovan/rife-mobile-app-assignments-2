import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rife_mobile_app/utils/constants.dart';



final ThemeData myTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.blue,
    brightness: Brightness.light,
  ),
  scaffoldBackgroundColor: scaffoldGreyBgColor,
  textTheme: TextTheme(
    displayLarge: const TextStyle(
      fontSize: 72,
      fontWeight: FontWeight.bold,
    ),
    // DEFINE; USED IN ISSUE SELECTOR FORM;
    displaySmall: GoogleFonts.nunito(
      fontSize: 36,
      fontWeight: FontWeight.w600,
      letterSpacing: 1.0
    ),
    // DEFINED; USED IN LOGIN HOME; SIGNUP HOME; MY-LOGO-CARD
    titleLarge: GoogleFonts.nunito(
        fontSize: 26,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w800
    ),
    // DEFINED: USED IN ONBOARDING SCREENS; TITLE
    titleMedium: GoogleFonts.nunito(
        fontSize: 24,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w600
    ),
    titleSmall: GoogleFonts.nunito(
      fontSize: 18.0,
      fontWeight: FontWeight.w700
    ),
    // DEFINED; USED IN LOGIN HOME - BODY TEXT
    // ONBOARDING SCREENS - TEXT DESCRIPTION;
    bodyMedium: GoogleFonts.nunito(
      fontSize: 16.0,
    ),
    bodySmall: GoogleFonts.nunito(
      fontSize: 14.0,
    ),
  ),
);
