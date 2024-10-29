// lib/utils/app_colors.dart

import 'package:flutter/material.dart';

Map<int, Color> _swatchOpacity = {
  50: const Color.fromRGBO(237, 141, 76, .1),
  100: const Color.fromRGBO(237, 141, 76, .2),
  200: const Color.fromRGBO(237, 141, 76, .3),
  300: const Color.fromRGBO(237, 141, 76, .4),
  400: const Color.fromRGBO(237, 141, 76, .5),
  500: const Color.fromRGBO(237, 141, 76, .6),
  600: const Color.fromRGBO(237, 141, 76, .7),
  700: const Color.fromRGBO(237, 141, 76, .8),
  800: const Color.fromRGBO(237, 141, 76, .9),
  900: const Color.fromRGBO(237, 141, 76, 1),
};

abstract class AppColors {
  static const Color primary = Color.fromRGBO(237, 141, 76, 1);
  static const Color primaryLight = Color(0xFF726AB4);
  static const Color primaryDark = Color.fromRGBO(255, 255, 255, 1);
  static const Color primaryText = Colors.white;
  static const Color grey = Color(0XFFF2F2F2);
  static const Color lightGrey = Color(0XFFFCFCFC);
  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color error = Colors.redAccent;
  static const Color hoverActive = Color.fromRGBO(114, 106, 180, 1);
  static const Color buttonPrimary = Color(0xFFED8D4C);
  static const Color buttonSecondary = Color(0xFF9472FF);

  static MaterialColor primarySwatchColor =
      MaterialColor(0xFF726AB4, _swatchOpacity);
}
