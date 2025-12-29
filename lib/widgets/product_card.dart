import 'package:dpp_pharma/widgets/passport_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';
import '../models/product_model.dart';

class ProductCard extends StatelessWidget {
  final ProductModel model;
  final String gtin;
  final String skuid;
  final String batchNo;
  final String expiryDate;

  const ProductCard({
    super.key,
    required this.model,
    required this.gtin,
    required this.skuid,
    required this.batchNo,
    required this.expiryDate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(18.w),
      decoration: BoxDecoration(
        color: Color(0XFFb6c8bb),
        // color: Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 5.0)],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
        child: Column(
          children: [
            // SizedBox(width: 20.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // SizedBox(height: 10.h),
                Text(
                  model.title,
                  style: GoogleFonts.roboto(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),

                SizedBox(height: 10.h),
                ProductIdentityCard(
                  model: model,
                  gtin: gtin,
                  serial: skuid,
                  batch: batchNo,
                  expiry: expiryDate,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
