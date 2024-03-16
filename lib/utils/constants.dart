import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// // NOTE: Constants used in OnboardingScressn()

const String assetBackgroundTexture = 'assets/texture/background_texture.svg';
const expandingDotsEffectDotColor = Color(0x800080f3);
const floatingActionButtonBgColor = Color(0xff0080f3);
const expandingDotsEffectActiveDotColor = Color(0xff0080f3);

Color snackBarBackgroundColor = const Color(0xff99cc33);
Color blueIconColor = const Color(0xff0080f3);
Color greyIconColor = const Color(0xffaaaaaa);
Color iconBgColor = const Color(0xffeeeeee);//
double PHASE_DIFFERENCE = 120.0;
double PLAYER_HEIGHT = 126.0;

const double heightBottomNavigationBarMedium = 72.0;
const double heightBottomNavigationBarSmall = 64.0;
const double toolBarHeightAppBar = 96.0;

Color faqTitleBgColor = const Color(0xffeeeeee);//
Color freqCardBgColor = const Color(0xffeeeeee);//
Color freqCardSelectedBgColor = const Color(0xff0080f3);//,

Color issueSelectedBgColor = const Color(0xffdddddd);

Color redTextButtonColor = const Color(0xffff3951); //


const String RIFE_SHOPPING_WEB_URL = "https://realrifemachines.com/";

const String APP_CONSENT_DOC_URL = "https://firebasestorage.googleapis.com/v0/b/rife-mobile-app.appspot.com/o/public%2Fdocs%2Fuser_app_consent_form_v01.md?alt=media";

// SCAFFOLD BG TEXTURE URL:

const BG_TEXTURE_URL = "assets/texture/bg_texture.svg"; // For Mobile Screens TODO: Use 'background_texture.svg' for iPad screens.
const RIFE_LOGO_PNG = "assets/images/rife_logo.png";
Color scaffoldGreyBgColor = const Color(0xffeeeeee); //

// APP BAR:
var appBarTextStyle = GoogleFonts.nunito(
    fontSize: 19,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.bold
);

var titleMediumTextStyle = const TextStyle( fontSize: 24,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w600);
var bodyMediumTextStyle = const TextStyle(
    fontFamily: 'Nunito',
    fontSize: 16.0
);