// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

const Color kPrimaryColor = Color.fromARGB(255, 77, 157, 223);
const Color kDarkPrimaryColor = Color.fromARGB(255, 1, 201, 184);
const Color kSecondaryColor = Color(0xFFE5E5E5);
const Color kSecondarydarkColor = Color.fromARGB(255, 17, 17, 17);
const Color klightgreyColor = Color(0xFFE5E5E5);
const Color kdarkgreyColor = Color(0xFFBDBDBD);
const Color kblackColor = Color(0xFF000000);
const Color kwhiteColor = Color(0xFFFFFFFF);
const Color kredColor = Color(0xFFFF0000);
const Color kgreenColor = Color(0xFF15BE78);
const Color korangeColor = Color.fromARGB(255, 255, 157, 0);
const Color kyellowColor = Color(0xFFFFD700);

const ColorScheme kColorScheme = ColorScheme(
  primary: kPrimaryColor,
  secondary: kSecondaryColor,
  surface: kwhiteColor,
  background: kwhiteColor,
  error: kredColor,
  onPrimary: kwhiteColor,
  onSecondary: kwhiteColor,
  onSurface: kblackColor,
  onBackground: kblackColor,
  onError: kwhiteColor,
  brightness: Brightness.light,
);

const ColorScheme kDarkColorScheme = ColorScheme(
  primary: kDarkPrimaryColor,
  secondary: kSecondaryColor,
  surface: kblackColor,
  background: kblackColor,
  error: kredColor,
  onPrimary: kwhiteColor,
  onSecondary: kwhiteColor,
  onSurface: kwhiteColor,
  onBackground: kwhiteColor,
  onError: kwhiteColor,
  brightness: Brightness.dark,
);

//  make random seven color list
List<Color> randomColors = [
  const Color(0xFFE57373),
  const Color(0xFF81C784),
  const Color(0xFFFFD54F),
  const Color(0xFF9575CD),
  const Color(0xFF4DB6AC),
  const Color(0xFFFF8A65),
];

//  make random seven title list
List<String> mainTitles = [
  'Note Book',
  'Image Editor',
  'Doc Manager',
  'Calculator',
  'Timer',
  'QR Code Maker',
];

//  make random seven icon list
List<String> mainIcons = [
  'assets/notebook.png',
  'assets/imageeditor.png',
  'assets/docmanager.png',
  'assets/calculator.png',
  'assets/timer.png',
  'assets/videotrimmer.png',
];
