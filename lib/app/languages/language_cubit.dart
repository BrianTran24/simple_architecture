import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../app/routes/route_configs.dart';
import '../models/language_support.dart';

class LanguageCubit extends Cubit<LanguageSupport>{
  LanguageCubit() : super(LanguageSupport.en);

  void changeLanguage(LanguageSupport language){
    emit(language);
  }




  Future<LanguageSupport> load() async{

    SharedPreferences localStorage = await SharedPreferences.getInstance();
    String languageCode = localStorage.getString('language') ?? '';
    LanguageSupport? language = LanguageSupportExtension.fromJson(languageCode);
    language ??= _loadLanguageCurrentOfSystem();

    return language;
  }

  LanguageSupport _loadLanguageCurrentOfSystem() {
    var context = routerConfig.routerDelegate.navigatorKey.currentContext!;
     Locale myLocale = Localizations.localeOf(context);
    String languageCode =  myLocale.languageCode.split('-').first;
    switch(languageCode){
      case 'es':
        return LanguageSupport.es;
      case 'hi':
        return LanguageSupport.hi;
      case 'id':
        return LanguageSupport.id;
      case 'pt':
        return LanguageSupport.pt;
      case 'tr':
        return LanguageSupport.tr;
      default:
        return LanguageSupport.en;
    }
  }

}