
import 'package:flutter/material.dart';

int _primaryColor = 0xff1c7cfa;
int _failColor = 0xffae271e;
int _warningColor = 0xffae271e;

MaterialColor primaryColor = MaterialColor(
  _primaryColor,
  const {
    50: Color(0xffe8f2ff),
    100: Color(0xffddebfe),
    200: Color(0xffb9d6fd),
    300: Color(0xff1c7cfa),
    400: Color(0xff1970e1),
    500: Color(0xff1663c8),
    600: Color(0xff155dbc),
    700: Color(0xff114a96),
    800: Color(0xff0d3870),
    900: Color(0xff0a2b58),
  },
);

MaterialColor failColor =  MaterialColor(
  _failColor,
  const {
    50: Color(0xfffbeae9),
    100: Color(0xfff9e0de),
    200: Color(0xfff4bfbc),
    300: Color(0xffda3126),
    400: Color(0xffc42c22),
    500: Color(0xffae271e),
    600: Color(0xffa4251d),
    700: Color(0xff831d17),
    800: Color(0xff621611),
    900: Color(0xff4c110d),
  },
);

MaterialColor warningColor =  MaterialColor(
  _warningColor,
  const {
    50: Color(0xfffff7ec),
    100: Color(0xfffff3e3),
    200: Color(0xfffee7c5),
    300: Color(0xfffcb044),
    400: Color(0xffe39e3d),
    500: Color(0xffca8d36),
    600: Color(0xffbd8433),
    700: Color(0xff976a29),
    800: Color(0xff714f1f),
    900: Color(0xff583e18),
  },
);

Color backgroundColor = const Color(0xff373737);
Color strokeBorder = const Color(0xff636363);

