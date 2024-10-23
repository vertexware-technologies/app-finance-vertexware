import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'config/app_colors.dart';
import 'config/app_dependecy.dart';
import 'views/splash_page.dart';

void main() {
  runApp(
    MultiProvider(
      providers: AppDependency.getProviders(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: AppColors.primarySwatchColor,
        primaryColorLight: AppColors.primary,
        primaryColorDark: AppColors.primaryDark,
        focusColor: AppColors.primary,
        appBarTheme: const AppBarTheme(
          color: AppColors.primaryDark,
          iconTheme: IconThemeData(color: Colors.white),
          elevation: 1,
          titleTextStyle: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w500, fontSize: 20),
        ),
        scaffoldBackgroundColor: const Color(0xFF161522), // Cor de fundo global
        buttonTheme: ButtonThemeData(
          buttonColor: AppColors.buttonPrimary, // Cor do botão
          textTheme: ButtonTextTheme.primary,
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const SplashPage(),
    );
  }
}
