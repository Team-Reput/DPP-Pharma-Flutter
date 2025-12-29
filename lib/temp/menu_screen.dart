import 'package:accordion/accordion.dart';
import 'package:dpp_pharma/temp/brand_detail_Landing_Screen.dart';
import 'package:dpp_pharma/temp/our_story_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart' hide DeviceType;

// --------- minimal helpers (no Provider / ResponsiveHelper) ----------

enum DeviceType { mobile, web }

DeviceType getDeviceType(double width) {
  return width < 800 ? DeviceType.mobile : DeviceType.web;
}

// ---------------------- MenuScreen (static) ----------------------

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  int _openSection = 1;

  void _open(int section) {
    if (_openSection != section) {
      setState(() => _openSection = section);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final deviceType = getDeviceType(screenWidth);

    return deviceType == DeviceType.mobile
        ? Scaffold(
            body: SafeArea(
              child: Accordion(
                maxOpenSections: 1,
                headerPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                children: [
                  AccordionSection(
                    isOpen: _openSection == 0,
                    header: GestureDetector(
                      onTap: () => _open(0),
                      child: Text(
                        'Our Initiatives',
                        style: TextStyle(fontSize: 15.sp),
                      ),
                    ),
                    headerBackgroundColor: Colors.green.withOpacity(0.2),
                    headerBackgroundColorOpened: Colors.green.withOpacity(0.2),
                    content: const OurStoryScreen(),
                  ),
                  AccordionSection(
                    isOpen: _openSection == 1,
                    header: GestureDetector(
                      onTap: () => _open(1),
                      child: Text(
                        'Brand Story',
                        style: TextStyle(fontSize: 15.sp),
                      ),
                    ),
                    headerBackgroundColor: Colors.green.withOpacity(0.2),
                    headerBackgroundColorOpened: Colors.green.withOpacity(0.2),
                    content: SizedBox(
                      height:
                          MediaQuery.of(context).size.height - kToolbarHeight,
                      child: const BrandDetailedScreen(),
                    ),
                  ),
                ],
              ),
            ),
          )
        : _buildWebMenu(context);
  }

  Widget _buildWebMenu(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0, // Brand Story tab selected by default
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [],
            // tabs: [Brand Story, Our Initiatives]
          ),
        ),
        body: const TabBarView(
          children: [
            Scaffold(body: SingleChildScrollView(child: BrandDetailedScreen())),
            Scaffold(body: SingleChildScrollView(child: OurStoryScreen())),
          ],
        ),
      ),
    );
  }
}
