import 'package:dpp_pharma/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:google_fonts/google_fonts.dart';

// Data model for sustainability section
class SustainabilityImpactData {
  final String sourcingType;
  final String renewableEnergyUsage;
  final List<String> savingInitiatives;
  final List<String> complianceCertificates;
  final List<String> imageAssets;
  final double renewablePercentage; // value 0-100 for chart
  final double waterSavingPercentage; // value 0-100 for chart

  SustainabilityImpactData({
    required this.sourcingType,
    required this.renewableEnergyUsage,
    required this.savingInitiatives,
    required this.complianceCertificates,
    required this.imageAssets,
    required this.renewablePercentage,
    required this.waterSavingPercentage,
  });
}

class PassportSectionSustainabilityWidget extends StatelessWidget {
  final SustainabilityImpactData data;
  const PassportSectionSustainabilityWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Eco-friendly Sourcing',
            style: GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: 16.sp),
          ),
          SizedBox(height: 5.h),
          Text(data.sourcingType, style: GoogleFonts.roboto(fontSize: 14.sp)),
          SizedBox(height: 12.h),
          Text(
            'Renewable Energy in Manufacturing',
            style: GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: 16.sp),
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              Text(
                data.renewableEnergyUsage,
                style: GoogleFonts.roboto(fontSize: 14.sp),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: LinearProgressIndicator(
                  value: data.renewablePercentage / 100,
                  minHeight: 8.h,
                  backgroundColor: AppColors.primary,
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                ),
              ),
              SizedBox(width: 8.w),
              Text(
                '${data.renewablePercentage.toStringAsFixed(1)}%',
                style: GoogleFonts.roboto(fontSize: 13.sp),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Text(
            'Water/Energy Saving Initiatives',
            style: GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: 16.sp),
          ),
          SizedBox(height: 6.h),
          ...data.savingInitiatives.map(
            (initiative) => Padding(
              padding: EdgeInsets.only(bottom: 4.h),
              child: Text('- $initiative', style: GoogleFonts.roboto(fontSize: 14.sp)),
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            'Environmental Compliance Certificates',
            style: GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: 16.sp),
          ),
          SizedBox(height: 4.h),
          Wrap(
            spacing: 8.w,
            children: data.complianceCertificates
                .map(
                  (cert) => Chip(
                    label: Text(cert),
                    backgroundColor: AppColors.primary,
                  ),
                )
                .toList(),
          ),
          SizedBox(height: 12.h),
          Text(
            'Sustainability Projects / Certifications',
            style: GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: 16.sp),
          ),
          SizedBox(height: 8.h),
          SizedBox(
            height: 70.h,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: data.imageAssets.length,
              itemBuilder: (context, idx) => ClipRRect(
                borderRadius: BorderRadius.circular(10.r),
                child: Image.asset(
                  data.imageAssets[idx],
                  height: 68.h,
                  width: 90.w,
                  fit: BoxFit.cover,
                ),
              ),
              separatorBuilder: (c, i) => SizedBox(width: 8.w),
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            'Water Saving Metrics',
            style: GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: 16.sp),
          ),
          Row(
            children: [
              Expanded(
                child: LinearProgressIndicator(
                  value: data.waterSavingPercentage / 100,
                  minHeight: 8.h,
                  backgroundColor: Colors.blue[100],
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blue[700]!),
                ),
              ),
              SizedBox(width: 8.w),
              Text(
                '${data.waterSavingPercentage.toStringAsFixed(1)}%',
                style: GoogleFonts.roboto(fontSize: 13.sp),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
