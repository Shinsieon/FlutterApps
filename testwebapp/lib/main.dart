import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:testwebapp/login_register_app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarBrightness: Brightness.light),
  );
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
    (value) => runApp(const LoginRegisterApp()),
  );
}
