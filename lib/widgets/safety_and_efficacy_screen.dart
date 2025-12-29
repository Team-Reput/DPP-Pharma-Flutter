// safety_and_efficacy_screen.dart

import 'package:dpp_pharma/constants/app_colors.dart';
import 'package:dpp_pharma/models/dpp_models.dart';
import 'package:dpp_pharma/provider/dpp_provider.dart';
import 'package:dpp_pharma/widgets/medicine_safety.dart';
import 'package:dpp_pharma/widgets/accordion_tile_widget.dart';
import 'package:dpp_pharma/widgets/passport_section_regulatory_widget.dart';
import 'package:dpp_pharma/widgets/safety_tile.dart' hide MedicineSafetyPassportCard;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart';

class SafetyAndEfficacyCardWidget extends StatelessWidget {
  const SafetyAndEfficacyCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final dpp = context.watch<DppProvider>();
    final ProductDetails? product = dpp.product;

    if (product == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final directions = product.directionsOfUse.isEmpty
        ? 'As directed by physician.'
        : product.directionsOfUse;
    final uses = product.uses;
    final keyIng = product.keyIngredients;

    final allergenText = keyIng.isEmpty
        ? 'No documented allergen information.'
        : 'Contains herbal ingredients: '
              '${keyIng.map((k) => k.ingredientName).join(", ")}';

    // Boolean‑driven texts and colors
    final infantSafe = product.infantFood;
    final infantText = infantSafe
        ? 'Safe to use but consult your doctor before giving to infants.'
        : 'Not formulated as infant food. Use only under medical supervision for children.';
    final infantTileColor = infantSafe
        ? Colors.green.shade50
        : Colors.orange.shade50;
    final infantIconColor = infantSafe ? Colors.green : Colors.orange.shade800;

    final pregnancyCare = product.pregnancyCare;
    final pregnancyText = pregnancyCare
        ? 'Suitable in pregnancy; however, consult your gynaecologist before use.'
        : 'Not specifically designed for pregnancy care. Seek medical advice if pregnant or breastfeeding.';
    final pregnancyTileColor = pregnancyCare
        ? Colors.green.shade50
        : Colors.yellow.shade50;
    final pregnancyIconColor = pregnancyCare
        ? Colors.green
        : Colors.amber.shade800;

    final tiles = <SafetyInfoTileData>[
      SafetyInfoTileData(
        icon: Icons.medical_information_outlined,
        label: "Usage & Dosage Instructions",
        description: directions,
      ),
      SafetyInfoTileData(
        icon: Icons.child_friendly,
        label: infantSafe ? "Infant Safety" : "Not Infant Food",
        description: infantText,
      ),
      SafetyInfoTileData(
        icon: Icons.pregnant_woman,
        label: "Pregnancy & Lactation",
        description: pregnancyText,
      ),
      SafetyInfoTileData(
        icon: Icons.thermostat_rounded,
        label: "Storage Conditions",
        description:
            "Store in a cool, dry place away from direct sunlight unless specified otherwise on the pack.",
      ),
      SafetyInfoTileData(
        icon: Icons.science,
        label: "Clinical & Testing Data",
        description: uses.isEmpty
            ? "Herbal formulation. Clinical data available with manufacturer."
            : "Indication: $uses\nFor detailed clinical data, refer to pack insert / CoA.",
      ),
      SafetyInfoTileData(
        icon: Icons.warning_amber,
        label: "Allergen & Interaction Warnings",
        description: allergenText,
      ),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          children: [
            SizedBox(height: 14.h),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  color: Colors.black87,
                  onPressed: () => Navigator.pop(context),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      "Safety And Efficacy",
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // Safety tiles (with infant/pregnancy boolean handling)
            MedicineSafetyPassportCard(items: tiles),

            // Modern product facts box BEFORE regulatory accordion
            ProductFactsBox(product: product),

            Divider(height: 18.h, thickness: 1, color: Colors.grey[200]),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18.r),
              ),
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Consumer & Community Testimonial",
                    style: GoogleFonts.roboto(
                      fontWeight: FontWeight.bold,
                      fontSize: 15.sp,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(height: 12.h),
                  // _TestimonialList(), // plug back when ready
                  // SizedBox(height: 14.h),
                  // PassportAccordionTile(
                  //   icon: Symbols.assignment_turned_in,
                  //   iconBgColor: Colors.green[50]!,
                  //   iconColor: AppColors.primary,
                  //   title: 'Regulatory Compliance',
                  //   subtitle: 'Aligned. Approved. Compliant.',
                  //   details: PassportSectionRegulatoryWidget(
                  //     data: RegulatoryComplianceData(
                  //       regulatoryLicenses: [
                  //         'AYUSH Manufacturing License: A-2025/HERB',
                  //         'WHO GMP Approval',
                  //         'ISO 22716:2018 Cosmetic GMP',
                  //       ],
                  //       countryRegistrations: [
                  //         'India: CDSCO Registration #CD1234567',
                  //         'Germany: BfArM Herbal Product #HERB00123',
                  //         'USA: FDA Registered Facility',
                  //       ],
                  //       safetyCertificates: [
                  //         'Batch Safety: Eurofins Certificate #2025B45',
                  //         'Label Compliance: CMO Verified',
                  //         'Packaging: FDA Label Compliance',
                  //       ],
                  //     ),
                  //   ),
                  // ),
               
               
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
