import 'package:flutter/material.dart';
import 'package:flutter_application_30/core/constants/color_manager.dart';
import 'package:flutter_application_30/presentation/home/view/home_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,

      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: ThemeMode.system,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: ColorManager.appSeedColor,
              brightness: Brightness.light,
            ),
            scaffoldBackgroundColor: ColorManager.whiteColor,
            cardColor: ColorManager.cardBackground,
            useMaterial3: true,
          ),
          darkTheme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: ColorManager.appSeedColor,
              brightness: Brightness.dark,
            ),
            scaffoldBackgroundColor: ColorManager.darkScaffoldBackground,
            cardColor: ColorManager.darkCardBackground,
            useMaterial3: true,
          ),
          home: const HomeScreen(),
        );
      },
    );
  }
}
