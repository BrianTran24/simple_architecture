
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension BuilderContextExtension on BuildContext{
  AppLocalizations? get languages => AppLocalizations.of(this);

  double get widthScreen => MediaQuery.of(this).size.width;

  double get heightScreen => MediaQuery.of(this).size.height;
  double get paddingTop => MediaQuery.of(this).padding.top;
  double get paddingBottom => MediaQuery.of(this).padding.bottom;

  double get ratioMobile => MediaQuery.of(this).size.width / 375.0;
  double get ratioTablet => MediaQuery.of(this).size.width / 768.0;
  bool get isTablet => MediaQuery.of(this).size.width >500;
}