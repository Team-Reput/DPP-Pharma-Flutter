import 'package:dpp_pharma/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

// Regulatory Compliance data model
class RegulatoryComplianceData {
  final List<String> regulatoryLicenses;
  final List<String> countryRegistrations;
  final List<String> safetyCertificates;

  RegulatoryComplianceData({
    required this.regulatoryLicenses,
    required this.countryRegistrations,
    required this.safetyCertificates,
  });
}

class PassportSectionRegulatoryWidget extends StatelessWidget {
  final RegulatoryComplianceData data;
  const PassportSectionRegulatoryWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'AYUSH & Regulatory Licenses',
          style: GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: 16.sp),
        ),
        SizedBox(height: 6.h),
        Wrap(
          spacing: 8.w,
          children: data.regulatoryLicenses
              .map(
                (lic) => Chip(
                  label: Text(lic, style: GoogleFonts.roboto(fontSize: 13.sp)),
                  backgroundColor: Colors.green[50],
                ),
              )
              .toList(),
        ),
        SizedBox(height: 12.h),
        Text(
          'Country-specific Registrations',
          style: GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: 16.sp),
        ),
        SizedBox(height: 6.h),
        ...data.countryRegistrations.map(
          (reg) => Padding(
            padding: EdgeInsets.only(bottom: 4.h),
            child: Text('- $reg', style: GoogleFonts.roboto(fontSize: 14.sp)),
          ),
        ),
        SizedBox(height: 12.h),
        Text(
          'Product Safety & Labeling Compliance',
          style: GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: 16.sp),
        ),
        SizedBox(height: 6.h),
        Wrap(
          spacing: 8.w,
          children: data.safetyCertificates
              .map(
                (cert) => Chip(
                  label: Text(cert, style: GoogleFonts.roboto(fontSize: 13.sp)),
                  backgroundColor: Colors.green[50],
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
