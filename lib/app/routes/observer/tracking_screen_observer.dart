import 'package:flutter/cupertino.dart';

import '../../tracking/tracking_service.dart';

RouterObserver screenTracking = RouterObserver();
class RouterObserver extends RouteObserver<ModalRoute<dynamic>> {


  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    TrackingService.shared.trackScreen(route.settings.name ?? "");
    debugPrint('router observer:  ${route.settings.name} ->  ${previousRoute?.settings.name}');
  }


  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    TrackingService.shared.trackScreen(newRoute?.settings.name ?? "");
    debugPrint('router didReplace:  ${oldRoute?.settings.name} ->  ${newRoute?.settings.name}');
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    debugPrint('router didPop:  ${previousRoute?.settings.name} ->  ${route.settings.name}');
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    debugPrint('router didRemove:  ${previousRoute?.settings.name} ->  ${route.settings.name}');
  }

  @override
  void didStartUserGesture(Route<dynamic> route, Route<dynamic>? previousRoute) {
    debugPrint('router route:  ${previousRoute?.settings.name} ->  ${route.settings.name}');
  }

  @override
  void didStopUserGesture() {
    debugPrint('didStopUserGesture:');
  }
}
