import 'package:flutter/material.dart';
import 'package:testwebapp/screens/login_screen.dart';
import 'package:testwebapp/utils/common_widgets/invalid_route.dart';
import 'package:testwebapp/values/app_routes.dart';

class Routes {
  const Routes._();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    Route<dynamic> getRoute({
      required Widget widget,
      bool fullScreenDialog = false,
    }) {
      return MaterialPageRoute(
        builder: (context) => widget,
        settings: settings,
        fullscreenDialog: fullScreenDialog,
      );
    }

    switch (settings.name) {
      case AppRoutes.login:
        return getRoute(widget: const LoginPage());
      default:
        return getRoute(widget: const InvalidRoute());
    }
  }
}
