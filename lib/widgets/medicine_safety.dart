import 'package:dpp_pharma/models/dpp_models.dart';
import 'package:dpp_pharma/widgets/safety_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class MedicineSafetyPassportCard extends StatelessWidget {
  final List<SafetyInfoTileData> items;

  const MedicineSafetyPassportCard({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: items.map((data) {
        return Container(
          margin: EdgeInsets.only(bottom: 8.h),
          padding: EdgeInsets.all(10.w),
          decoration: BoxDecoration(
            color: data.tileColor ?? Colors.white, // <-- use tileColor
            borderRadius: BorderRadius.circular(14.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.03),
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 32.w,
                height: 32.w,
                decoration: BoxDecoration(
                  color: (data.iconColor ?? Colors.green).withOpacity(0.08),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  data.icon,
                  size: 18.sp,
                  color: data.iconColor ?? Colors.green, // <-- use iconColor
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.label,
                      style: GoogleFonts.roboto(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 3.h),
                    Text(
                      data.description!,
                      style: GoogleFonts.roboto(
                        fontSize: 11.sp,
                        color: Colors.grey[800],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

class ProductFactsBox extends StatelessWidget {
  final ProductDetails product;
  const ProductFactsBox({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 14.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Product Facts',
            style: GoogleFonts.roboto(
              fontWeight: FontWeight.w700,
              fontSize: 14.sp,
            ),
          ),
          SizedBox(height: 8.h),
          Wrap(
            spacing: 6.w,
            runSpacing: 6.h,
            children: [
              _factChip('Dosage form', product.dosageForm),
              _factChip('Units in pack', '${product.unitsInPack}'),
              _factChip('Veg / Non‑veg', product.vegOrNonveg),
              _factChip('Flavour', product.flavourColour),
              _factChip('Target population', product.targetPopulation),
              _factChip('Category', product.suggestedCategoryUdp),
              _factChip('Origin', product.originCountry),
              _factChip(
                'Infant food',
                product.infantFood ? 'Yes' : 'No',
                color: product.infantFood
                    ? Colors.green.shade50
                    : Colors.red.shade50,
              ),
              _factChip(
                'Pregnancy care',
                product.pregnancyCare ? 'Yes' : 'Not specific',
                color: product.pregnancyCare
                    ? Colors.green.shade50
                    : Colors.yellow.shade50,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _factChip(String label, String value, {Color? color}) {
    if (value.isEmpty) return const SizedBox.shrink();
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: color ?? Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.roboto(
              fontSize: 9.5.sp,
              color: Colors.grey[600],
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            value,
            style: GoogleFonts.roboto(
              fontSize: 11.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
