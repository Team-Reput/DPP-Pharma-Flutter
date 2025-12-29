import 'package:dpp_pharma/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CSRCardData {
  final String imageAsset; // e.g. "assets/csr_tree_plantation.jpg"
  final String header;
  final String subtext;
  final List<String> highlights;
  final String footerLeft;
  final String footerRight;

  CSRCardData({
    required this.imageAsset,
    required this.header,
    required this.subtext,
    required this.highlights,
    required this.footerLeft,
    required this.footerRight,
  });
}

class CSRActivityCard extends StatelessWidget {
  final CSRCardData data;
  final VoidCallback? onTap;

  const CSRActivityCard({Key? key, required this.data, this.onTap})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 320.w,
        height: 190.h,
        margin: EdgeInsets.only(right: 18.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8.r,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              height: 100.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.r),
                  bottomLeft: Radius.circular(20.r),
                  topRight: Radius.circular(20.r),
                  bottomRight: Radius.circular(20.r),
                ),
                image: DecorationImage(
                  image: AssetImage(data.imageAsset),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Text (right vertical half)
            Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(14.w, 5.h, 14.w, 14.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.header,
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.sp,
                        color: Colors.black87,
                      ),
                    ),
                    if (data.subtext.isNotEmpty)
                      Text(
                        data.subtext,
                        style: GoogleFonts.roboto(
                          color: Colors.grey[800],
                          fontSize: 12.5.sp,
                        ),
                      ),
                    ...data.highlights
                        .take(2)
                        .map(
                          (item) => Row(
                            children: [
                              Icon(
                                Icons.check_circle,
                                size: 14.sp,
                                color: AppColors.primary,
                              ),
                              SizedBox(width: 5.w),
                              Expanded(
                                child: Text(
                                  item,
                                  style: GoogleFonts.roboto(
                                    fontSize: 12.5.sp,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                    if (data.highlights.length > 2)
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 1.h),
                        child: Row(
                          children: [
                            SizedBox(width: 19.w),
                            Expanded(
                              child: Text(
                                "+${data.highlights.length - 2} more...",
                                style: GoogleFonts.roboto(
                                  fontSize: 11.sp,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          data.footerLeft,
                          style: GoogleFonts.roboto(
                            color: AppColors.primary,
                            fontSize: 11.5.sp,
                          ),
                        ),
                        Text(
                          data.footerRight,
                          style: GoogleFonts.roboto(
                            color: Colors.black54,
                            fontSize: 11.5.sp,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
