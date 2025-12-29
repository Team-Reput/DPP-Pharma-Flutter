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
    final List<String> splashIcons = [
      'assets/svg/industry/ic1.png',
      'assets/svg/industry/ic2.png',
      'assets/svg/industry/ic3.png',
      'assets/svg/industry/ic4.png',
      'assets/svg/industry/ic5.png',
      'assets/svg/industry/ic6.png',
      'assets/svg/industry/ic7.png',
      'assets/svg/industry/ic8.png',
      'assets/svg/industry/ic9.png',
      'assets/svg/industry/ic10.png',
      'assets/svg/industry/ic11.png',
      'assets/svg/industry/ic12.png',
    ];

     return ScreenUtilInit(
      designSize: const Size(412, 524),
      minTextAdapt: true,
      splitScreenMode: false,
      builder: (context, child) {
        return MultiProvider(
          providers: [ChangeNotifierProvider(create: (_) => DppProvider())],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            home: SplashScreen(dynamicIconPaths: splashIcons),
          ),
        );
      },
    );
  }
}
