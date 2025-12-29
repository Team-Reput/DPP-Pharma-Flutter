import 'package:dpp_pharma/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class PassportNavigationCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final Color bgColor;

  const PassportNavigationCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    required this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: bgColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.r)),
      elevation: 0.7,
      margin: EdgeInsets.symmetric(vertical: 8.h),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.white,
          child: Icon(icon, color: AppColors.primary, size: 26.sp),
        ),
        title: Text(
          title,
          style: GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: 15.sp),
        ),
        subtitle: Text(
          subtitle,
          style: GoogleFonts.roboto(color: Colors.grey[700], fontSize: 13.sp),
        ),
        trailing: Icon(Icons.chevron_right, color: Colors.grey[700]),
        onTap: onTap,
        contentPadding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 7.h),
      ),
    );
  }
}
