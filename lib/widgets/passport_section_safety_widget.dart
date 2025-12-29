import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

// Safety & Efficacy data model
class SafetyEfficacyData {
  final List<String> clinicalStudies;
  final List<String> batchTestResults;
  final List<String> adverseReportingMeasures;

  SafetyEfficacyData({
    required this.clinicalStudies,
    required this.batchTestResults,
    required this.adverseReportingMeasures,
  });
}

class PassportSectionSafetyWidget extends StatelessWidget {
  final SafetyEfficacyData data;
  const PassportSectionSafetyWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Clinical/Efficacy Tests & Research',
            style: GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: 16.sp),
          ),
          SizedBox(height: 8.h),
          ...data.clinicalStudies.map(
            (study) => Padding(
              padding: EdgeInsets.only(bottom: 4.h),
              child: Text('- $study', style: GoogleFonts.roboto(fontSize: 14.sp)),
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            'Batch Testing (Heavy Metals, Pesticides, Microbial Safety)',
            style: GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: 16.sp),
          ),
          SizedBox(height: 8.h),
          ...data.batchTestResults.map(
            (result) => Padding(
              padding: EdgeInsets.only(bottom: 3.h),
              child: Text(result, style: GoogleFonts.roboto(fontSize: 14.sp)),
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            'Adverse Effect Reporting & Patient Safety Measures',
            style: GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: 16.sp),
          ),
          SizedBox(height: 7.h),
          ...data.adverseReportingMeasures.map(
            (item) => Padding(
              padding: EdgeInsets.only(bottom: 3.h),
              child: Text('- $item', style: GoogleFonts.roboto(fontSize: 14.sp)),
            ),
          ),
        ],
      ),
    );
  }
}
