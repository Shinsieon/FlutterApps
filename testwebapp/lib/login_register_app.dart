import 'package:flutter/material.dart';
import 'package:testwebapp/routes.dart';
import 'package:testwebapp/utils/helpers/navigation_helper.dart';
import 'package:testwebapp/utils/helpers/snackbar_helper.dart';
import 'package:testwebapp/values/app_routes.dart';
import 'package:testwebapp/values/app_strings.dart';
import 'package:testwebapp/values/app_theme.dart';

class LoginRegisterApp extends StatelessWidget {
  const LoginRegisterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppStrings.loginAndRegister,
      theme: AppTheme.themeData,
      initialRoute: AppRoutes.login,
      scaffoldMessengerKey: SnackbarHelper.key,
      navigatorKey: NavigationHelper.key,
      onGenerateRoute: Routes.generateRoute,
    );
  }
}
