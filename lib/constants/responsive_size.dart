import 'package:flutter/widgets.dart';

class Responsive {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;

  static const double figmaWidth = 360;
  static const double figmaHeight = 564;

  static late double _scaleWidth;
  static late double _scaleHeight;

  static void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;

    _scaleWidth = screenWidth / figmaWidth;
    _scaleHeight = screenHeight / figmaHeight;
  }

  /// Width-based scaling (e.g. width, horizontal padding, image width)
  static double w(double width) => width * _scaleWidth;

  /// Height-based scaling (e.g. height, vertical padding, image height)
  static double h(double height) => height * _scaleHeight;

  /// Font scaling (can be based on height for better vertical harmony)
  static double sp(double fontSize) => fontSize * _scaleHeight;

  /// Border radius scaling
  static double radius(double r) => r * _scaleWidth;

  /// Icon size
  static double icon(double size) => size * _scaleWidth;

  /// Border width scaling
  static double border(double width) =>
      width * (_scaleWidth + _scaleHeight) / 2;

}
