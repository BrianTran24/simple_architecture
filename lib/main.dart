import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:simple_clean_architure/share/components/app_toast.dart';
import 'package:simple_clean_architure/share/themes/light_mode.dart';
import 'package:simple_clean_architure/share/utils/extentions/language_extension.dart';
import 'package:toastification/toastification.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'app/app_configs.dart';
import 'app/bussiness/bloc/business_manage_cubit.dart';
import 'app/bussiness/bloc/bussiness_state.dart';
import 'app/bussiness/repositories/business_rep_imp.dart';
import 'app/languages/language_cubit.dart';
import 'app/models/language_support.dart';
import 'app/routes/route_configs.dart';
import 'app/tracking/tracking_service.dart';
import 'share/components/unfocus.dart';

void main() async {
//Setting SystmeUIMode

  runZonedGuarded<Future<void>>(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      MobileAds.instance.initialize();
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
      ]);

      await Firebase.initializeApp();

      AppConfigs app = AppConfigs();

      await app.setup();
      Bloc.observer = const AppBlocObserver();
      runApp(
        MyApp(app: app),
      );
    },
    (error, stack) {
      TrackingService.recordError(error, stack);
    },
  );
}


class MyApp extends StatefulWidget {
  const MyApp({required this.app, super.key});

  final AppConfigs app;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    _initBrightness();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LanguageCubit>(
          create: (BuildContext context) => LanguageCubit(),
        ),
        BlocProvider<BusinessManageCubit>(
          lazy: false,
          create: (BuildContext context) => BusinessManageCubit(repository: BusinessRepositoryImp()),
        ),
      ],
      child: ToastificationWrapper(
        child: ScreenUtilInit(
          designSize: const Size(360, 800),
          minTextAdapt: true,
          splitScreenMode: true,
          child: BlocConsumer<BusinessManageCubit, BusinessManageState>(
            builder: (BuildContext context, state) {
              return BlocBuilder<LanguageCubit, LanguageSupport>(
                builder: (context, locale) {
                  return MaterialApp.router(
                    routerConfig: routerConfig,
                    title: context.languages?.app_name??'',
                    theme: lightModeTheme,
                    themeMode: ThemeMode.dark,
                    supportedLocales: languageSupport,
                    locale: locale.locale,
                    localizationsDelegates: const [
                      AppLocalizations.delegate,
                      GlobalMaterialLocalizations.delegate,
                      GlobalWidgetsLocalizations.delegate,
                      GlobalCupertinoLocalizations.delegate,
                    ],
                    builder: (context, child) {
                      return UnFocus(
                        child: child!,
                      );
                    },
                  );
                },
              );
            },
            listener: (BuildContext context, BusinessManageState state) {
              var context = routerConfig.routerDelegate.navigatorKey.currentContext!;
              if (state is BusinessManageLoaded && state.licenseState is HasLicense) {
                AppConfigs().admobConfig.setEnable(false);
                if (state.backToHome) {
                  try {
                    do {
                      routerConfig.pop();
                    } while (routerConfig.canPop());
                  } catch (e) {
                    print('Loi home ${e.toString()}');
                  } finally {
                    AppToast.showCustomInfo(context, context.languages?.purchase_success ?? '',
                        alignment: Alignment.topCenter);
                  }
                }
                return;
              }
              AppConfigs().admobConfig.setEnable(true);
            },
          ),
        ),
      ),
    );
  }

  void _initBrightness() async {}
}

class AppBlocObserver extends BlocObserver {
  /// {@macro app_bloc_observer}
  const AppBlocObserver();

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    if (bloc is Cubit) print(change);
  }

  @override
  void onTransition(
    Bloc<dynamic, dynamic> bloc,
    Transition<dynamic, dynamic> transition,
  ) {
    super.onTransition(bloc, transition);
    print(transition);
  }
}
