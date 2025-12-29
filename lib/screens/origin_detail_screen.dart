import 'package:dpp_pharma/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class OriginDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7F7E4),
      appBar: AppBar(
        title: Text('Product Origin & Authenticity'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: AppColors.primary,
      ),
      body: ListView(
        padding: EdgeInsets.all(18.w),
        children: [
          // Source images as horizontal list (see screenshot 1)
          Text(
            'Botanical Origin',
            style: GoogleFonts.roboto(
              fontWeight: FontWeight.bold,
              fontSize: 18.sp,
            ),
          ),
          SizedBox(height: 8.h),
          SizedBox(
            height: 80.h,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(14.r),
                  child: Image.asset(
                    'assets/ashwagandha_leaf.jpeg',
                    width: 80.w,
                    height: 80.h,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 12.w),
                ClipRRect(
                  borderRadius: BorderRadius.circular(14.r),
                  child: Image.asset(
                    'assets/ashwagandha_root.jpeg',
                    width: 80.w,
                    height: 80.h,
                    fit: BoxFit.cover,
                  ),
                ),
                // Add more images as required
              ],
            ),
          ),
          SizedBox(height: 14.h),
          Card(
            color: Color(0xFFE3F5E5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.r),
            ),
            child: Padding(
              padding: EdgeInsets.all(18.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Region of Harvest',
                    style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w600,
                      fontSize: 16.sp,
                    ),
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    'Sindh, Punjab, India',
                    style: GoogleFonts.roboto(fontSize: 13.sp),
                  ),
                  Divider(),
                  Text(
                    'Certificate of Authenticity',
                    style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w600,
                      fontSize: 16.sp,
                    ),
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    'COA #2025/ASH/789 (Eurofins)',
                    style: GoogleFonts.roboto(fontSize: 13.sp),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 14.h),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {},
                child: Text('Consultant'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[200],
                  foregroundColor: Colors.green[900],
                ),
              ),
              SizedBox(width: 10.w),
              ElevatedButton(
                onPressed: () {},
                child: Text('Stay Native'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.green[900],
                  elevation: 0,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
