import 'package:dpp_pharma/app_initialiser.dart';
import 'package:dpp_pharma/constants/splash_icons.dart';
import 'package:dpp_pharma/provider/dpp_provider.dart';
import 'package:dpp_pharma/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(412, 524),
      minTextAdapt: true,
      splitScreenMode: false,
      builder: (context, child) {
        return MultiProvider(
          providers: [ChangeNotifierProvider(create: (_) => DppProvider())],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            home: AppInitializer(),
          ),
        );
      },
    );
  }
}
