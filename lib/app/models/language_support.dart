import 'package:flutter/material.dart';
List<Locale> languageSupport =  LanguageSupport.values.map((e) => e.locale).toList();

enum LanguageSupport {
  en(1, 'en'),
  pt(2, 'pt'),
  es(3, 'es'),
  hi(4, 'hi'),
  id(5, 'id'),
  tr(6, 'tr');

  const LanguageSupport(this.identify, this.code);

  final String code;
  final int identify;
}

extension LanguageSupportExtension on LanguageSupport {

  String get nativeLanguage => _getNativeLanguage();

  String language(LanguageSupport language) => _getLanguage(language);

  Locale get locale => _getLocale();

  String _getNativeLanguage() {
    switch (this) {
      case LanguageSupport.en:
        return "English";
      case LanguageSupport.pt:
        return 'Português';
      case LanguageSupport.es:
        return 'Español';
      case LanguageSupport.hi:
        return 'हिंदी';
      case LanguageSupport.id:
        return 'Bahasa Indo';
      case LanguageSupport.tr:
        return 'Türkçe';
    }
  }

  String _getLanguage(LanguageSupport language) {
    switch (this) {
      case LanguageSupport.en:
        return "English";
      case LanguageSupport.pt:
        return 'Portuguese Br';
      case LanguageSupport.es:
        return 'Spanish';
      case LanguageSupport.hi:
        return 'Hindi';
      case LanguageSupport.id:
        return 'Indonesian';
      case LanguageSupport.tr:
        return 'Turkish';
    }
  }

  Locale _getLocale() {
    switch (this) {
      case LanguageSupport.en:
        return const Locale('en','US');
      case LanguageSupport.pt:
        return const Locale('pt');
      case LanguageSupport.es:
        return const Locale('es');
      case LanguageSupport.hi:
        return const Locale('hi');
      case LanguageSupport.id:
        return const Locale('id');
      case LanguageSupport.tr:
        return const Locale('tr');
    }
  }

  static LanguageSupport? fromJson(String json){
    switch(json){
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
      case 'en':
        return LanguageSupport.en;

      default: return null;
    }
  }
}
