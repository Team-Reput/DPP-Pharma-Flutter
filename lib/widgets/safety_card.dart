import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class PharmaInfoCard extends StatelessWidget {
  final String imageAsset;
  final String title;
  final String subtitle;
  final String trailingTop;
  final String detailTitle;
  final String detailText;
  final String detailFooterLeft;
  final String detailFooterRight;
  final VoidCallback onTap;

  const PharmaInfoCard({
    Key? key,
    required this.imageAsset,
    required this.title,
    required this.subtitle,
    required this.trailingTop,
    required this.detailTitle,
    required this.detailText,
    required this.detailFooterLeft,
    required this.detailFooterRight,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        // elevation: 20,
        child: Container(
          // margin: EdgeInsets.symmetric(vertical: 9.h),
          decoration: BoxDecoration(
            // color: Color(0XffB6C8BB),
            borderRadius: BorderRadius.circular(18.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 14,
                spreadRadius: 0,
                offset: Offset(0, 4),
              ),
            ],

            image: DecorationImage(
              image: AssetImage('assets/temp/safety_bg.png'),
              fit: BoxFit.fill,
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 10.h),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundColor: Color(0xFFF3F6EE),
                      radius: 40.r,
                      backgroundImage: AssetImage(imageAsset),
                    ),
                    SizedBox(width: 15.w),
                    // Main Text Column
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            title,
                            style: GoogleFonts.roboto(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.sp,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            subtitle,
                            style: GoogleFonts.roboto(
                              color: Colors.black54,
                              fontWeight: FontWeight.w500,
                              fontSize: 13.5.sp,
                            ),
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            trailingTop,
                            style: GoogleFonts.roboto(
                              color: Colors.black38,
                              fontSize: 12.5.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 10.w),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
