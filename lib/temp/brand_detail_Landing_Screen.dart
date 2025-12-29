import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart' hide DeviceType;

/// Simple enum so code compiles without your ResponsiveHelper.
enum DeviceType { mobile, web }

DeviceType _getDeviceType(double width) {
  return width < 800 ? DeviceType.mobile : DeviceType.web;
}

double responsiveFontSize(double mobile, double web, DeviceType type) {
  return type == DeviceType.mobile ? mobile.sp : web.sp;
}

class BrandDetailedScreen extends StatefulWidget {
  const BrandDetailedScreen({super.key});

  @override
  State<BrandDetailedScreen> createState() => _BrandDetailedScreenState();
}

class _BrandDetailedScreenState extends State<BrandDetailedScreen>
    with TickerProviderStateMixin {
  late PageController _pageController;
  Timer? _carouselTimer;
  bool _carouselStarted = false;

  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..forward();

    _pageController = PageController(viewportFraction: 0.85);
  }

  @override
  void dispose() {
    _carouselTimer?.cancel();
    _pageController.dispose();
    _controller.dispose();
    super.dispose();
  }

  // ---------- STATIC MOCK DATA ----------

  // primary card (tab 19, is_stats = false)
  final Map<String, dynamic> primaryCardData = const {
    'brandlogourl': 'assets/temp/millennium_herbal_care_limited_logo.png',
    'motto': 'Assurance of Natural Health',
    'tagline':
        'Plant-based therapies inspired by Ayurveda, validated by science.',
    'hashtag': '#MillenniumHerbalCare',
    'brandid': 501,
    'landingurl': 'assets/temp/phyto.jpeg',
    'brandweb_url': 'https://www.millenniumherbal.com',
    'highlightcolor': '#0b8c4a',
  };

  final List<Map<String, dynamic>> statsItems = const [
    {
      'title': 'Herbal Formulations',
      'description':
          'Portfolio of clinically validated herbal medicines and nutraceuticals across 9+ therapeutic areas.',
      'filepath': 'https://dummyimage.com/120x120/0b8c4a/ffffff.png&text=70%2B',
      'value': '70',
      'units': '+ SKUs',
      'is_stats': 'True',
    },
    {
      'title': 'Countries Reached',
      'description':
          'Phyto-therapies exported to CIS, South-East Asia, Africa and other global markets.[web:75][web:77]',
      'filepath': 'https://dummyimage.com/120x120/004f89/ffffff.png&text=22',
      'value': '22',
      'units': 'Countries',
      'is_stats': 'True',
    },
    {
      'title': 'Years of Expertise',
      'description':
          'Herbal and pharma experience built over decades of R&D in Vedic and Ayurvedic formulations.[web:74][web:78]',
      'filepath': 'https://dummyimage.com/120x120/ffaa00/ffffff.png&text=20%2B',
      'value': '20',
      'units': '+ Years',
      'is_stats': 'True',
    },
  ];

  // stats cards (tab 19, is_stats = true)

  // ---------- UI HELPERS ----------

  Widget cardOneWidget(
    Map<String, dynamic>? data, {
    required DeviceType deviceType,
  }) {
    final logoUrl = data?['brandlogourl'] as String?;
    final motto = data?['motto'] as String? ?? '';
    final tagLine = data?['tagline'] as String? ?? '';
    final hashTags = data?['hashtag'] as String? ?? '';
    final rawBrand = data?['brandid'];
    final int? brandId = (rawBrand is int)
        ? rawBrand
        : int.tryParse(rawBrand?.toString() ?? '');
    final landingImageUrl = data?['landingurl'] as String? ?? '';

    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 15.w),
      child: Column(
        children: [
          SizedBox(height: 1.h),
          if (logoUrl != null) Image.asset(logoUrl, height: 100.h),
          SizedBox(height: 8.h),
          if (motto.isNotEmpty)
            Text(
              motto,
              style: TextStyle(
                fontFamily: 'Gilroy-Light',
                fontWeight: FontWeight.w500,
                fontSize: responsiveFontSize(17, 8, deviceType),
                color: const Color(0XFF121212),
              ),
              textAlign: TextAlign.center,
            ),
          SizedBox(height: 12.h),
          if (landingImageUrl.isNotEmpty)
            Image.asset(
              landingImageUrl,
              fit: BoxFit.contain,
              width: double.infinity,
              height: 150.h,
            ),
          SizedBox(height: 12.h),
          if (tagLine.isNotEmpty)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: 3.w),
                Expanded(
                  child: Text(
                    tagLine,
                    style: TextStyle(
                      fontFamily: 'Gilroy-Light',
                      fontSize: responsiveFontSize(15, 6, deviceType),
                      color: const Color(0XFF121212),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(width: 3.w),
              ],
            ),
          SizedBox(height: 8.h),
          if (hashTags.isNotEmpty)
            Text(
              hashTags,
              style: TextStyle(
                fontFamily: 'Gilroy-Light',
                fontSize: responsiveFontSize(16, 6, deviceType),
                color: const Color(0XFF121212),
                fontWeight: brandId == 242 ? FontWeight.w500 : FontWeight.w600,
              ),
            ),
        ],
      ),
    );
  }

  Widget commonCardDesign(
    String cardTitle,
    String cardDescription,
    String cardValue,
    String cardUnit, {
    required Widget iconWidget,
    required Color titleCardColor,
    required Color entireCardColor,
    required String imagePath,
    required Gradient gradient,
    required DeviceType deviceType,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: entireCardColor,
        gradient: gradient,
        boxShadow: [
          BoxShadow(
            color: entireCardColor,
            offset: const Offset(0, 1),
            blurRadius: 2,
            spreadRadius: 1,
          ),
          BoxShadow(
            color: Colors.white.withOpacity(0.4),
            offset: const Offset(0, 2),
            blurRadius: 1,
          ),
        ],
      ),
      child: Column(
        children: [
          // simple top strip replacing ScoopedContainer
          Container(
            height: 50.h,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20),
              ),
              color: titleCardColor.withOpacity(0.8),
            ),
            child: Center(
              child: Text(
                cardTitle,
                style: TextStyle(
                  fontFamily: 'Gilroy-Light',
                  fontWeight: FontWeight.w700,
                  fontSize: responsiveFontSize(18, 10, deviceType),
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(
              top: 15.h,
              bottom: 15.h,
              left: 15.w,
              right: 15.w,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SizedBox(width: 10.w),
                    Text(
                      cardValue,
                      style: TextStyle(
                        fontFamily: 'Gilroy-Light',
                        fontSize: responsiveFontSize(34, 22, deviceType),
                        fontWeight: FontWeight.w700,
                        color: const Color(0XFF121212),
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      cardUnit,
                      style: TextStyle(
                        fontFamily: 'Gilroy-Light',
                        fontSize: responsiveFontSize(20, 10, deviceType),
                        fontWeight: FontWeight.bold,
                        color: const Color(0XFF121212),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                Text(
                  cardDescription,
                  style: TextStyle(
                    fontFamily: 'Gilroy-Light',
                    fontSize: responsiveFontSize(15, 8.5, deviceType),
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ),
          SizedBox(height: 10.h),
        ],
      ),
    );
  }

  Color getColorFromHex(String hexColor) {
    hexColor = hexColor.replaceAll('#', '');
    return Color(int.parse('0xFF$hexColor'));
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        ScreenUtil.init(
          context,
          designSize: const Size(390, 844),
          minTextAdapt: true,
        );
        final deviceType = _getDeviceType(constraints.maxWidth);

        final brandWebUrl =
            primaryCardData['brandweb_url'] as String? ??
            'https://www.millenniumherbal.com/?srsltid=AfmBOoodGCClDBlF7gbSyTQ3lTCFJDUZQ7ON1dUSK-uEst-uSxFNEW4j';

        final displayUrl = brandWebUrl
            .replaceFirst(RegExp(r'^https?://'), '')
            .replaceFirst(RegExp(r'\/$'), '');

        // start carousel auto-scroll once
        if (!_carouselStarted && statsItems.isNotEmpty) {
          _carouselStarted = true;
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _carouselTimer = Timer.periodic(const Duration(seconds: 10), (_) {
              if (_pageController.hasClients) {
                final next =
                    (_pageController.page!.round() + 1) % statsItems.length;
                _pageController.animateToPage(
                  next,
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeInOut,
                );
              }
            });
          });
        }

        final brandHighlightingColor =
            primaryCardData['highlightcolor'] as String? ?? '';

        LinearGradient getBrandGradient(String highlight) {
          if (highlight.isNotEmpty) {
            final c = getColorFromHex(highlight);
            return LinearGradient(
              colors: [
                c.withOpacity(0.3),
                Colors.white.withOpacity(0.9),
                Colors.white,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: const [0, 0.7, 1],
            );
          } else {
            return const LinearGradient(
              colors: [Colors.grey, Colors.white70],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            );
          }
        }

        return Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Column(
              children: [
                cardOneWidget(primaryCardData, deviceType: deviceType),
                SizedBox(height: 16.h),
                if (statsItems.isEmpty)
                  Text(
                    'No stats cards to show',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Gilroy-Light',
                    ),
                  )
                else
                  SizedBox(
                    height: deviceType == DeviceType.mobile ? 250.h : 350.h,
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: statsItems.length,
                      itemBuilder: (context, idx) {
                        final item = statsItems[idx];
                        final title = item['title'] as String? ?? '';
                        final description =
                            item['description'] as String? ?? '';
                        final filePath = item['filepath'] as String? ?? '';
                        final cardValue = item['value'] as String? ?? '';
                        final cardUnit = item['units']?.toString() ?? '';

                        final iconWidget = filePath.isNotEmpty
                            ? Image.network(
                                filePath,
                                height: 50.h,
                                width: 50.w,
                                fit: BoxFit.cover,
                              )
                            : Container(
                                height: 50.h,
                                width: 50.w,
                                color: Colors.grey.shade300,
                              );

                        return Padding(
                          padding: EdgeInsets.only(
                            bottom: 12.h,
                            left: 5.w,
                            right: 5.w,
                          ),
                          child: commonCardDesign(
                            title,
                            description,
                            cardValue,
                            cardUnit,
                            iconWidget: iconWidget,
                            entireCardColor: const Color(0XFFEADCE2),
                            imagePath: filePath,
                            titleCardColor: getColorFromHex(
                              brandHighlightingColor,
                            ),
                            gradient: getBrandGradient(brandHighlightingColor),
                            deviceType: deviceType,
                          ),
                        );
                      },
                    ),
                  ),
                SizedBox(height: 12.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Shop at  ',
                      style: TextStyle(
                        fontFamily: 'Gilroy-Light',
                        color: const Color(0XFF121212),
                        fontSize: responsiveFontSize(15, 6, deviceType),
                        decoration: TextDecoration.none,
                      ),
                    ),
                    Text(
                      displayUrl,
                      style: TextStyle(
                        fontFamily: 'Gilroy-Light',
                        color: const Color(0XFF121212),
                        fontSize: responsiveFontSize(16, 7, deviceType),
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                Text(
                  '®Powered by RePut.ai',
                  style: TextStyle(
                    fontFamily: 'Gilroy-Light',
                    fontSize: responsiveFontSize(16, 7, deviceType),
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 70.h),
              ],
            ),
          ),
        );
      },
    );
  }
}
