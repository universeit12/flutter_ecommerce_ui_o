import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_ui_o/route/route_constants.dart';
import 'package:flutter_ecommerce_ui_o/theme/app_theme.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:flutter_ecommerce_ui_o/route/router.dart' as route;



void main() {
  runApp(const MyApp());
}

// Thanks for using our template. You are using the free version of the template.
// 🔗 Full template: https://theflutterway.gumroad.com/l/fluttershop

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shop Template by The Flutter Way',
      theme: AppTheme.lightTheme(context),
      // Dark theme is inclided in the Full template
      themeMode: ThemeMode.light,
      onGenerateRoute: route.generateRoute,
      initialRoute: onbordingScreenRoute,
    );
  }
}
