import 'package:dpp_pharma/constants/app_colors.dart';
import 'package:dpp_pharma/widgets/work_flow_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

// Main Screen
class SustainabilityImpactScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: AppColors.primary,
        title: Text(
          "Sustainability",
          style: GoogleFonts.roboto(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 10.h),
          child: Column(
            children: [
              GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 13.w,
                mainAxisSpacing: 10.h,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                childAspectRatio: 0.78,
                children: [
                  SustainabilityKpiCard(
                    asset: 'assets/energy-sus.jpeg',
                    kpiLabel: "Energy Saved",
                    kpiValue: "68% Solar",
                    details: EnergyDetailsModal(),
                    badge: "ISO 50001",
                  ),
                  SustainabilityKpiCard(
                    asset: "assets/temp/water_sus.jpeg",
                    kpiLabel: "Water Consumed",
                    kpiValue: "23% Saved",
                    details: WaterDetailsModal(),
                    badge: "Green Water",
                  ),
                  SustainabilityKpiCard(
                    asset: "assets/eco-packaging.jpeg",
                    kpiLabel: "Eco-Packaging",
                    kpiValue: "Bio 90%",
                    details: PackagingDetailsModal(),
                    badge: "BPI",
                  ),
                  SustainabilityKpiCard(
                    asset: "assets/waste-packaging.jpeg",
                    kpiLabel: "Waste Reowned",
                    kpiValue: "24% Reduced",
                    details: WasteDetailsModal(),
                    badge: "ISO 14001",
                  ),
                ],
              ),
              SupplyChainAccordion(),
            ],
          ),
        ),
      ),
    );
  }
}

// Card style matches reference images and is highly professional, scalable
class SustainabilityKpiCard extends StatelessWidget {
  final String asset;
  final String kpiLabel;
  final String kpiValue;
  final Widget details;
  final String badge;

  const SustainabilityKpiCard({
    required this.asset,
    required this.kpiLabel,
    required this.kpiValue,
    required this.details,
    required this.badge,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          backgroundColor: Color.fromARGB(255, 225, 250, 255),
          context: context,
          builder: (_) => details,
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(21.r),
        ),
        elevation: 50,
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.only(
            left: 10.w,
            right: 10.w,
            top: 5.h,
            bottom: 5.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(13.r),
                    child: Image.asset(
                      asset,
                      width: MediaQuery.of(context).size.width,
                      height: 70.h,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Positioned(
                    top: 9.h,
                    left: 7.w,
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 2.h,
                      ),
                      child: Text(
                        badge,
                        style: GoogleFonts.roboto(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5.h),
              Text(
                kpiLabel,
                style: GoogleFonts.roboto(
                  fontWeight: FontWeight.bold,
                  fontSize: 15.sp,
                  color: AppColors.primary,
                ),
              ),
              SizedBox(height: 5.h),
              Text(
                kpiValue,
                style: GoogleFonts.roboto(fontWeight: FontWeight.w600, fontSize: 13.sp),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SupplyChainAccordion extends StatefulWidget {
  @override
  State<SupplyChainAccordion> createState() => _SupplyChainAccordionState();
}

class _SupplyChainAccordionState extends State<SupplyChainAccordion> {
  bool _showJourney = false;
  @override
  Widget build(BuildContext context) {
    final List<String> nodeSteps = [
      "Plant",
      "Distributor",
      "Retailer",
      "Pharmacy",
    ];
    return Card(
      elevation: 40,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.r)),
      child: Container(
        decoration: BoxDecoration(
          // image: DecorationImage(
          //   image: AssetImage('assets/temp/safety.png'),
          //   fit: BoxFit.cover,
          // ),
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15.r),
                    child: Image.asset(
                      "assets/temp/supply_chain.png",
                      width: 52.w,
                      height: 52.w,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Text(
                      "Supply Chain Sustainability",
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.sp,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 7.h),
              _ChipRow(chips: ['FairWild', 'ISO 14001', 'GMP', 'B Corp']),
              SizedBox(height: 8.h),
              Text(
                "Local sourcing: 63%\nEco audits: annual\nLogistics: Emissions tracked\nSupplier collab: for GAP, GMP",
                style: GoogleFonts.roboto(fontSize: 15.sp, color: Colors.black),
              ),
              Divider(),
              _BulletPoint('Full traceability—farm to finished product'),
              _BulletPoint(
                'Community: fair wage, biodiversity, direct support',
              ),
              _BulletPoint('Download: sustainability reports, certificates'),

              // TRACK AND TRACE / ACCORDION TOGGLE
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Track & Trace",
                    style: GoogleFonts.roboto(
                      fontWeight: FontWeight.bold,
                      fontSize: 15.sp,
                    ),
                  ),
                  InkWell(
                    onTap: () => setState(() => _showJourney = !_showJourney),
                    borderRadius: BorderRadius.circular(13),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 4.h,
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.route, color: Colors.green, size: 18.sp),
                          SizedBox(width: 4.w),
                          Text(
                            _showJourney ? "Hide Journey" : "See Journey →",
                            style: GoogleFonts.roboto(
                              fontSize: 12.sp,
                              color: Colors.green[800],
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          AnimatedRotation(
                            turns: _showJourney ? 0.5 : 0.0,
                            duration: Duration(milliseconds: 250),
                            child: Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: Colors.green[800],
                              size: 20.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 9.h),
              Row(
                children: nodeSteps.map((n) {
                  final idx = nodeSteps.indexOf(n);
                  return Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 9.w,
                          vertical: 5.h,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.green[50],
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(color: Colors.green[100]!),
                        ),
                        child: Text(
                          n,
                          style: GoogleFonts.roboto(
                            fontSize: 11.sp,
                            color: Colors.green[900],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      if (idx < nodeSteps.length - 1)
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4.w),
                          child: Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 15.sp,
                            color: Colors.green[300],
                          ),
                        ),
                    ],
                  );
                }).toList(),
              ),
              // ---- ACCORDION ANIMATION: Trace Journey ----
              if (_showJourney)
                Padding(
                  padding: EdgeInsets.only(top: 20.h),
                  child: AnimatedSwitcher(
                    duration: Duration(milliseconds: 380),
                    switchInCurve: Curves.easeOutExpo,
                    switchOutCurve: Curves.easeInExpo,
                    child: AnimatedAuthWorkflow(),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

// Chips
class _ChipRow extends StatelessWidget {
  final List<String> chips;
  const _ChipRow({required this.chips});
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.w,
      children: chips
          .map(
            (label) => Chip(
              color: WidgetStatePropertyAll(Color(0XFFf0f0f0)),
              label: Text(
                label,
                style: GoogleFonts.roboto(fontSize: 11.sp, fontWeight: FontWeight.bold),
              ),
            ),
          )
          .toList(),
    );
  }
}

class _BulletPoint extends StatelessWidget {
  final String text;
  const _BulletPoint(this.text);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 3.h),
      child: Row(
        children: [
          Icon(Icons.check, color: Colors.black, size: 12.sp),
          SizedBox(width: 7.w),
          Expanded(
            child: Text(text, style: GoogleFonts.roboto(fontSize: 14.sp)),
          ),
        ],
      ),
    );
  }
}

// KPI Detail Modals
class EnergyDetailsModal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _ModalDetailContainer(
      title: "Energy Management",
      items: [
        "Total energy consum.: 140,000 kWh",
        "Solar: 68%, Wind: 12%, Grid: 20%",
        "Carbon reduction: -11 tons",
        "LED, HVAC, audits",
        "ISO 50001 Certified",
      ],
      assetimage: 'assets/temp/pexels-alexasfotos-7471992.jpg',
    );
  }
}

class WaterDetailsModal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _ModalDetailContainer(
      title: "Water Conservation",
      items: [
        "Total withdrawal: 19,000 m³",
        "Rain harvesting: 4,000 m³",
        "Treated reuse: 2,100 m³",
        "Water-saving tech installed",
        "Eco-compliance certified",
      ],
      assetimage: 'assets/temp/pexels-alexasfotos-7471992.jpg',
    );
  }
}

class PackagingDetailsModal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _ModalDetailContainer(
      title: "Sustainable Packaging",
      items: [
        "Materials: Compostable, glass, recycled",
        "Volume reduction: -11% YoY",
        "5% single-use plastics, labeled",
        "Eco-label: BPI, EU Organic",
        "Disposal/recycling included",
      ],
      assetimage: 'assets/temp/pexels-alexasfotos-7471992.jpg',
    );
  }
}

class WasteDetailsModal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _ModalDetailContainer(
      title: "Waste Management",
      items: [
        "Composted: 6.1 tons",
        "Recycled: 8.7 tons, landfill reduced",
        "Hazardous: 0.3 tons (safe disposal)",
        "Eco-brick program",
        "ISO 14001 certified",
      ],
      assetimage: 'assets/temp/pexels-alexasfotos-7471992.jpg',
    );
  }
}

// Modal Details Container
class _ModalDetailContainer extends StatelessWidget {
  final String title;
  final List<String> items;
  final String assetimage;
  const _ModalDetailContainer({
    required this.title,
    required this.items,
    required this.assetimage,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(23.r)),
        // image: DecorationImage(image: AssetImage(assetimage)),
      ),
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 18.h),
      child: ListView(
        shrinkWrap: true,
        children: [
          Text(
            title,
            style: GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: 17.sp),
          ),
          SizedBox(height: 17.h),
          ...items.map(
            (item) => Padding(
              padding: EdgeInsets.symmetric(vertical: 5.h),
              child: Row(
                children: [
                  Icon(
                    Icons.chevron_right,
                    size: 17.sp,
                    color: AppColors.primary,
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Text(item, style: GoogleFonts.roboto(fontSize: 14.sp)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
