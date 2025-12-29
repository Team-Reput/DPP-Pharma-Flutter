import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class PassportDesignCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final List<String> subtitleLines;
  final String assetName;
  final VoidCallback onTap;

  const PassportDesignCard({
    required this.icon,
    required this.title,
    required this.subtitleLines,
    required this.assetName,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 110.h,
        decoration: BoxDecoration(
          // color: Color(0XFFFFFFFF),
          color: Color(0XFFededed),
          // image: DecorationImage(
          //   image: AssetImage(assetName),
          //   alignment: AlignmentGeometry.topRight,
          // ),
          borderRadius: BorderRadius.circular(22.r),
        ),
        child: Padding(
          padding: EdgeInsets.all(14.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10.h),
              Text(
                title,
                style: GoogleFonts.roboto(
                  fontWeight: FontWeight.bold,
                  fontSize: 17.sp,
                  letterSpacing: 0.1,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 5.h),
              ...subtitleLines.map(
                (line) => Text(
                  line,
                  style: GoogleFonts.roboto(
                    fontSize: 13.sp,
                    color: Colors.grey[700],
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
