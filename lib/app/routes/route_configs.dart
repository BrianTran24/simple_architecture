import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/splash/presentations/splash_screen.dart';
import 'application_route_name.dart';
import 'observer/inter_admob_observer.dart';
import 'observer/tracking_screen_observer.dart';

GlobalKey<NavigatorState> goRouteKey = GlobalKey<NavigatorState>();

GoRouter routerConfig = GoRouter(
  navigatorKey: goRouteKey,
  observers: [
    screenTracking,
    interAdsObserver,
  ],
  routes: [
    GoRoute(
      path: ApplicationRouteName.splash,
      name: ApplicationRouteName.splash,
      builder: (context, state) => const SplashScreen(),
    ),
  ],
);
