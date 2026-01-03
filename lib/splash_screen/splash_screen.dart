import 'dart:convert';
import 'dart:math';
import 'package:dpp_pharma/api/dpp_api_service.dart';
import 'package:dpp_pharma/provider/dpp_provider.dart';
import 'package:dpp_pharma/screens/product_passport_screen.dart';
import 'package:dpp_pharma/widgets/feedback_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  final List<String> dynamicIconPaths;
  final int brandID;
  final int batchID;
  const SplashScreen({required this.dynamicIconPaths, required this.brandID, required this.batchID});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _rotationController;
  late AnimationController _logoController;
  late AnimationController _miniLogoController;
  late AnimationController _iconsController;

  final _api = DppApiService();

  @override
  void initState() {
    super.initState();

    _rotationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 4),
    );

    _logoController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 100),
    );

    _miniLogoController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 450),
    );

    _iconsController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );

    _logoController.forward();

    Future.delayed(
      Duration(milliseconds: 100),
      () => _miniLogoController.forward(),
    );

    Future.delayed(
      Duration(milliseconds: 100),
      () => _iconsController.forward(),
    );

    Future.delayed(
      Duration(milliseconds: 200),
      () => _rotationController.repeat(),
    );

    // Future.delayed(Duration(seconds: 5), () {
    //   Navigator.pushReplacement(
    //     context,
    //     MaterialPageRoute(builder: (_) => ProductPassportScreen()),
    //   );
    // });

    _startFlow();
  }

  Future<void> _startFlow() async {
    final dppProvider = context.read<DppProvider>();

    // Call API here; this will print the JSON from provider & service
    await dppProvider.loadDpp(brandId: widget.brandID, batchId: widget.batchID);

    // Optional splash delay to show animation
    await Future.delayed(const Duration(seconds: 3));

    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const ProductPassportScreen()),
    );
  }

  @override
  void dispose() {
    _logoController.dispose();
    _miniLogoController.dispose();
    _iconsController.dispose();
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final icons = widget.dynamicIconPaths;
    final iconCount = icons.length;
    final double bigLogo = 110.w;
    final double miniLogo = 46.w;
    final double iconCircleRadius = 110.w;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // PHASE 1 - BIG LOGO animated
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FadeTransition(
                opacity: _miniLogoController.drive(Tween(begin: 0.0, end: 1.0)),
                child: ScaleTransition(
                  scale: _miniLogoController.drive(Tween(begin: 0.8, end: 1.0)),
                  child: Image.asset(
                    // 'assets/svg/reput_full.png',
                    'assets/r_logo.png',
                    width: bigLogo,
                    height: bigLogo,
                  ),
                ),
              ),

              // Container(
              //   color: Colors.yellow,
              //   child: FadeTransition(
              //     opacity: _logoController.drive(Tween(begin: 0.0, end: 1.0)),
              //     child: ScaleTransition(
              //       scale: _logoController.drive(
              //         CurveTween(curve: Curves.easeIn),
              //       ),
              //       child: AnimatedBuilder(
              //         animation: _miniLogoController,
              //         builder: (_, child) {
              //           final fadeVal = 1 - _miniLogoController.value;
              //           final scaleVal = 1 - _miniLogoController.value * 0.8;
              //           return Opacity(
              //             opacity: fadeVal,
              //             child: Transform.scale(scale: scaleVal, child: child),
              //           );
              //         },
              //         child: Image.asset(
              //           'assets/svg/r_logo.png',
              //           width: bigLogo,
              //           height: bigLogo,
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
          // PHASE 3 - CIRCLE OF ICONS
          AnimatedBuilder(
            animation: Listenable.merge([
              _iconsController,
              _rotationController,
            ]),
            builder: (context, _) {
              final iconAnim = Curves.easeOut.transform(_iconsController.value);
              final double rotation = _rotationController.value * 2 * pi;

              return Center(
                child: SizedBox(
                  width: iconCircleRadius * 2.5,
                  height: iconCircleRadius * 2.5,
                  child: Stack(
                    children: [
                      for (int i = 0; i < iconCount; i++)
                        _AnimatedCircleIcon(
                          angle:
                              2 * pi * i / iconCount +
                              rotation, // << ROTATION APPLIED HERE
                          radius: iconCircleRadius * iconAnim,
                          iconPath: icons[i],
                          fade: iconAnim,
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

/// Widget for a single icon animating around in a circle
class _AnimatedCircleIcon extends StatelessWidget {
  final double angle;
  final double radius;
  final String iconPath;
  final double fade; // 0..1

  const _AnimatedCircleIcon({
    required this.angle,
    required this.radius,
    required this.iconPath,
    required this.fade,
  });

  @override
  Widget build(BuildContext context) {
    // Position icon at its calculated angle and radius
    return Positioned(
      left: radius * cos(angle) + radius + 8,
      top: radius * sin(angle) + radius + 8,
      child: Opacity(
        opacity: fade,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Container(
            width: 32.w,
            height: 32.w,
            color: Colors.green[50],
            child: Padding(
              padding: const EdgeInsets.all(5.5),
              child: Image.asset(iconPath, fit: BoxFit.contain),
            ),
          ),
        ),
      ),
    );
  }
}
