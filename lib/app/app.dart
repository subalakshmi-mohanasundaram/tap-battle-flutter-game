import 'package:flutter/material.dart';

import 'package:finger_tap/constants/app_constants.dart';
import 'package:finger_tap/screens/home_screen.dart';
import 'package:finger_tap/utils/app_colors.dart';

class TapBattleApp extends StatelessWidget {
  const TapBattleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.appTitle,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.blue),
        scaffoldBackgroundColor: AppColors.background,
      ),
      home: const HomeScreen(),
    );
  }
}
