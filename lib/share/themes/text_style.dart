import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class TextStyleAbstract {
  double get fontSize;

  double get height;

  TextStyle get regular => TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: fontSize.sp,
      height: (height / fontSize).sp,
      leadingDistribution: TextLeadingDistribution.even);

  TextStyle get medium => TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: fontSize.sp,
      height: (height / fontSize).sp,
      leadingDistribution: TextLeadingDistribution.even);

  TextStyle get semiBold => TextStyle(
      fontWeight: FontWeight.w700,
      fontSize: fontSize.sp,
      height: (height / fontSize).sp,
      leadingDistribution: TextLeadingDistribution.even);

  TextStyle? get bold => TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: fontSize.sp,
        height: (height / fontSize).sp,
        leadingDistribution: TextLeadingDistribution.even,
      );
}

class Caption01TextStyle extends TextStyleAbstract {
  @override
  double get fontSize => 10;

  @override
  double get height => 12;
}

class Caption02TextStyle extends TextStyleAbstract {
  @override
  double get fontSize => 12;

  @override
  double get height => 14.4;
}

class BodyTextStyle extends TextStyleAbstract {
  @override
  double get fontSize => 14;

  @override
  double get height => 16.8;
}

class TitleTextStyle extends TextStyleAbstract {
  @override
  double get fontSize => 16;

  @override
  double get height => 19.2;
}

class Header01TextStyle extends TextStyleAbstract {
  @override
  double get fontSize => 18;

  @override
  double get height => 21.6;
}

class Header02TextStyle extends TextStyleAbstract {
  @override
  double get fontSize => 20;

  @override
  double get height => 24;
}

class Header03TextStyle extends TextStyleAbstract {
  @override
  double get fontSize => 22;

  @override
  double get height => 26.4;
}

class Header04TextStyle extends TextStyleAbstract {
  @override
  double get fontSize => 24;

  @override
  double get height => 28.8;
}

class Header05TextStyle extends TextStyleAbstract {
  @override
  double get fontSize => 28;

  @override
  double get height => 33.6;
}

class Header06TextStyle extends TextStyleAbstract {
  @override
  double get fontSize => 32;

  @override
  double get height => 38.4;
}

class Header07TextStyle extends TextStyleAbstract {
  @override
  double get fontSize => 36;

  @override
  double get height => 43.2;
}

class AppTextStyle {
  static final AppTextStyle _instance = AppTextStyle._internal();

  factory AppTextStyle() {
    return _instance;
  }

  AppTextStyle._internal();

  Caption01TextStyle caption01 = Caption01TextStyle();
  Caption02TextStyle caption02 = Caption02TextStyle();
  BodyTextStyle bodyTextStyle = BodyTextStyle();
  TitleTextStyle titleTextStyle = TitleTextStyle();
  Header01TextStyle header01textStyle = Header01TextStyle();
  Header02TextStyle header02textStyle = Header02TextStyle();
  Header03TextStyle header03textStyle = Header03TextStyle();
  Header04TextStyle header04textStyle = Header04TextStyle();
  Header05TextStyle header05textStyle = Header05TextStyle();
  Header06TextStyle header06textStyle = Header06TextStyle();
  Header07TextStyle header07textStyle = Header07TextStyle();
}
