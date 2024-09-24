import 'package:flutter/foundation.dart';

class TrackingKey {

  /// [Document](https://docs.google.com/spreadsheets/d/1qjVBlFWgbqV3zq0CxYj2Hl77gEK8Vy-kW3AxKy-N8y4/edit#gid=0)

  static String get platform {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return 'andr';
      case TargetPlatform.fuchsia:
        return 'fuchsia';
      case TargetPlatform.iOS:
        return 'ios';
      case TargetPlatform.linux:
        return 'linux';
      case TargetPlatform.macOS:
        return 'macOS';
      case TargetPlatform.windows:
        return 'windows';
    }
  }

  static  String chooseLang = '${platform}_choose_lang';
  static  String welcomeScreenStartNow = '${platform}_welcome_screen_start_now';
  static  String welcomeScreenLogIn = '${platform}_welcome_screen_log_in';
  static  String skipAnimation = '${platform}_skip_animation';
  static  String startNow = '${platform}_start_now';
  static  String chooseTarget = '${platform}_choose_target';
  static  String trial1stCourse = '${platform}_1st_trial_course';
  static  String trial1stLesson = '${platform}_1st_trial_lesson';
  static  String end1stTrialLesson = '${platform}_end_1st_trial_lesson';
  static  String clickPopupSignUp = '${platform}_click_popup_signup';
  static  String signUpSuccess = '${platform}_signup_success';
  static  String review1st = '${platform}_1st_review';
  static  String wordLv41st = '${platform}_1st_word_lv4';

  /// =====================================================
  static  String showTrialCourseList = '${platform}_show_trial_course_list';

  /// ====================== Purchase =======================================

  static  String showPopup3TrialLesson = '${platform}_show_popup_3_trial_lesson';

  static  String showPopupUpgrade = '${platform}_show_popup_upgrade';

  static  String clickPopup3TrialLesson = '${platform}_click_popup_3_trial_lesson';

  static  String clickPopupUpgrade = '${platform}_click_popup_upgrade';

  static  String clickBannerPurchase = '${platform}_click_banner_purchase';

  static  String clickBuy = '${platform}_click_buy';

  static  String clickSubcribe = '${platform}_click_subcribe';

  static  String purchasing = '${platform}_purchasing';

  static  String purchasedPayment = '${platform}_purchased';

  static String pendingPayment = '${platform}_pending' ;

  static String cancelPayment = '${platform}_user_cancel' ;

  static String errorPayment = '${platform}_error' ;

  static  String restored = '${platform}_restored';

  static  String deferred = '${platform}_deferred';

  static  String callApi = '${platform}_call_api';

  static  String paidUser = '${platform}_paid_user';

  static String unspecifiedState = '${platform}_unspecified_state';


}
