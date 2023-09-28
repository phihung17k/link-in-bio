import 'package:flutter/widgets.dart';

class AppRouteObserver extends RouteObserver<PageRoute<dynamic>> {
  String? previousRouteName;
  String? currentRouteName;

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    if (previousRoute != null) {
      previousRouteName = previousRoute.settings.name;
      currentRouteName = route.settings.name;
    }
    super.didPop(route, previousRoute);
  }
}
