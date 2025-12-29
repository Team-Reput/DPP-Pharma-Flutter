import 'package:dpp_pharma/models/dpp_models.dart';
import 'package:dpp_pharma/provider/dpp_provider.dart';
import 'package:dpp_pharma/temp/menu_screen.dart';
import 'package:dpp_pharma/widgets/certificate_widget.dart';
import 'package:dpp_pharma/widgets/common_widgets/common_widgets.dart';
import 'package:dpp_pharma/widgets/feedback_screen.dart';
import 'package:dpp_pharma/widgets/home_section_row.dart';
import 'package:dpp_pharma/widgets/CSRActivityCard.dart';
import 'package:dpp_pharma/widgets/product2.dart';
import 'package:dpp_pharma/widgets/safety_and_efficacy_screen.dart';
import 'package:dpp_pharma/widgets/safety_card.dart';
import 'package:dpp_pharma/widgets/scratch_card.dart';
import 'package:dpp_pharma/widgets/sustainability_impact_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../models/product_model.dart';
import '../widgets/product_card.dart';

class ProductPassportScreen extends StatefulWidget {
  const ProductPassportScreen({super.key});

  @override
  State<ProductPassportScreen> createState() => _ProductPassportScreenState();
}

class _ProductPassportScreenState extends State<ProductPassportScreen> {
  int selectedIndex = 0;
  bool _rewardClaimed = false;
  bool _showRewardBadge = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FeedbackService.showFeedback(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final dpp = context.watch<DppProvider>();
    final ProductDetails? apiProduct = dpp.product;
    final PackagingDetails? packagingProduct = dpp.packaging;

    if (apiProduct == null || packagingProduct == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final ProductModel productCardModel = ProductModel(
      title: apiProduct.productName,
      subTitle: apiProduct.uses ?? "Joint & pain support",
      productImageUrl: apiProduct.productImageUrl ?? "Anything Image",
      batch: apiProduct.gtinSku ?? "NA",
      status: "Verified DPP",
    );

    return Scaffold(
      backgroundColor: const Color(0xFFffffff),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final success = await _showClaimRewardDialog(context);
          if (success && mounted) {
            setState(() {
              _rewardClaimed = true;
              _showRewardBadge = true;
            });
          }
        },
        backgroundColor: const Color(0xFF4CAF50),
        icon: const Icon(Icons.card_giftcard, color: Colors.white),
        label: Text(
          'Claim Reward',
          style: GoogleFonts.roboto(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 14.sp,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 12.h),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MenuScreen()),
                      );
                    },
                    child: brandNameAndLogoWidget(
                      brandManufacturerName: apiProduct!.manufactureName,
                      showRewardBadge: _showRewardBadge,
                      onGoodiesTap: () {
                        setState(() => _showRewardBadge = false);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const ScratchCard(),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 10.h),
                  ProductCard(
                    model: productCardModel,
                    gtin: apiProduct.gtinSku,
                    skuid: apiProduct.skuNumber,
                    batchNo: packagingProduct!.batchNumber,
                    expiryDate: apiProduct.expiryDate,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: PassportDesignCard(
                            icon: Icons.eco_outlined,
                            title: 'Product & Composition Authenticity',
                            subtitleLines: [
                              'Source Check.',
                              'Purity Proof',
                              'Regulatory tags.',
                            ],
                            assetName: 'assets/temp/productComp.png',
                            onTap: () => navigateTo(
                              context,
                              ProductIngredientAuthenticityScreen(),
                            ),
                          ),
                        ),
                        SizedBox(width: 15.w),
                        Expanded(
                          child: PassportDesignCard(
                            icon: Icons.emoji_nature_outlined,
                            title: 'Sustainability Impact',
                            subtitleLines: [
                              'Eco Score.',
                              'Energy Water.',
                              'Impact badges.',
                            ],
                            assetName: 'assets/temp/susImpact.png',
                            onTap: () => navigateTo(
                              context,
                              SustainabilityImpactScreen(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  PharmaInfoCard(
                    imageAsset: "assets/temp/Pasted Graphic 3.png",
                    title: "Safety & Efficacy",
                    subtitle: "Herbaly Concentrated",
                    trailingTop: "Efficacy Techniques",
                    detailTitle: "Efficacy Techniques",
                    detailText:
                        "Human studies show ... (use your actual dynamic description and bullet points)",
                    detailFooterLeft: "View Imaging Report Album",
                    detailFooterRight: "Report Date",
                    onTap: () =>
                        navigateTo(context, SafetyAndEfficacyCardWidget()),
                  ),
                  // SizedBox(height: 10.h),
                  if (apiProduct.productCertificates.isNotEmpty)
                    ProductCertificatesSection(
                      certificates: apiProduct.productCertificates,
                    ),
                  SizedBox(height: 10.h),
                  Text(
                    'Community & Social Responsibility, Consumer Engagement & Education',
                    style: GoogleFonts.roboto(
                      color: Colors.black,
                      fontWeight: FontWeight.w800,
                      fontSize: 17.sp,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(height: 3.h),
                  SizedBox(
                    height: 200.h,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      children: [
                        CSRActivityCard(
                          data: CSRCardData(
                            imageAsset: "assets/csr_school.jpeg",
                            header: "Direct Employment",
                            subtext: "Local hiring, rural upskilling",
                            highlights: [
                              "145 villagers employed across 3 states",
                              "Partnerships with women's self-help groups",
                              "Community health insurance support",
                            ],
                            footerLeft: "Verified CSR",
                            footerRight: "2025 Report",
                          ),
                        ),
                        CSRActivityCard(
                          data: CSRCardData(
                            imageAsset: "assets/csr_school.jpeg",
                            header: "Wellness Programs",
                            subtext: "Building healthy communities",
                            highlights: [
                              "Herbal Health Awareness Drive",
                              "Rural Diabetes Screening Camps",
                              "School Nutrition Workshop",
                            ],
                            footerLeft: "Impact: 3,000+",
                            footerRight: "Learn More",
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> _showClaimRewardDialog(BuildContext context) async {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final TextEditingController phoneController = TextEditingController();
    final TextEditingController otpController = TextEditingController();

    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        insetPadding: EdgeInsets.all(20.w),
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            constraints: BoxConstraints(maxHeight: 0.85.sh),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 25,
                  offset: Offset(0, 10),
                ),
              ],
            ),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Header
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.fromLTRB(24.w, 32.h, 24.w, 24.h),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          const Color(0xFF4CAF50),
                          const Color(0xFF45A049),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20.r),
                      ),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.card_giftcard,
                          size: 48.sp,
                          color: Colors.white,
                        ),
                        SizedBox(height: 12.h),
                        Text(
                          'Claim Your Reward',
                          style: GoogleFonts.roboto(
                            color: Colors.white,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Form Fields
                  Padding(
                    padding: EdgeInsets.all(24.w),
                    child: Column(
                      children: [
                        // Phone Number Field
                        TextFormField(
                          controller: phoneController,
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please enter phone number';
                            }
                            if (value.trim() != "9999999998") {
                              return 'Use 9999999998 for demo';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: 'Phone Number *',
                            hintText: 'Enter your phone number',
                            prefixIcon: Icon(
                              Icons.phone,
                              color: const Color(0xFF4CAF50),
                            ),
                            filled: true,
                            fillColor: Colors.grey.shade50,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.r),
                              borderSide: BorderSide(
                                color: const Color(0xFF4CAF50),
                                width: 2,
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.r),
                              borderSide: BorderSide(
                                color: Colors.red,
                                width: 2,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20.h),
                        // OTP Field
                        TextFormField(
                          controller: otpController,
                          keyboardType: TextInputType.number,
                          maxLength: 4,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please enter OTP';
                            }
                            if (value.trim() != "1234") {
                              return 'OTP must be 1234';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: 'OTP *',
                            prefixIcon: Icon(
                              Icons.lock_outline,
                              color: const Color(0xFF4CAF50),
                            ),
                            filled: true,
                            fillColor: Colors.grey.shade50,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.r),
                              borderSide: BorderSide(
                                color: const Color(0xFF4CAF50),
                                width: 2,
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.r),
                              borderSide: BorderSide(
                                color: Colors.red,
                                width: 2,
                              ),
                            ),
                            counterText: '',
                          ),
                        ),
                        SizedBox(height: 32.h),
                        // Buttons
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () => Navigator.pop(context, false),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.grey.shade200,
                                  foregroundColor: Colors.black87,
                                  padding: EdgeInsets.symmetric(vertical: 16.h),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.r),
                                  ),
                                  elevation: 0,
                                ),
                                child: Text(
                                  'Cancel',
                                  style: GoogleFonts.roboto(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    Navigator.pop(context, true); // Success!
                                  }
                                  _showSuccessDialog(context);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF4CAF50),
                                  foregroundColor: Colors.white,
                                  padding: EdgeInsets.symmetric(vertical: 16.h),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.r),
                                  ),
                                  elevation: 2,
                                ),
                                child: Text(
                                  'Verify & Claim',
                                  style: GoogleFonts.roboto(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    return result ?? false;
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        insetPadding: EdgeInsets.all(20.w),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 25,
                offset: Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Success Header
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(32.w),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [const Color(0xFF4CAF50), const Color(0xFF45A049)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20.r),
                  ),
                ),
                child: Column(
                  children: [
                    Icon(Icons.check_circle, size: 60.sp, color: Colors.white),
                    SizedBox(height: 16.h),
                    Text(
                      'Congratulations!',
                      style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              // Success Content
              Padding(
                padding: EdgeInsets.all(28.w),
                child: Column(
                  children: [
                    Text(
                      'Yay! You have claimed your reward.\nPlease use it in your next purchase! 🎉',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(
                        fontSize: 16.sp,
                        height: 1.5,
                        color: Colors.black87,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 32.h),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF4CAF50),
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(vertical: 18.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          elevation: 2,
                        ),
                        child: Text(
                          'Got it! 🎁',
                          style: GoogleFonts.roboto(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget brandNameAndLogoWidget({
    required String brandManufacturerName,
    required bool showRewardBadge,
    required VoidCallback onGoodiesTap,
  }) {
    return Card(
      color: Colors.white,
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset(
                  'assets/temp/millenium_herbal_logo.png',
                  height: 15.h,
                ),
                SizedBox(width: 6.w),
                Text(
                  brandManufacturerName,
                  style: GoogleFonts.roboto(
                    color: Colors.black,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            if (showRewardBadge)
              GestureDetector(
                onTap: onGoodiesTap,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      padding: EdgeInsets.all(8.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.card_giftcard,
                        color: Colors.green,
                        size: 22.sp,
                      ),
                    ),
                    Positioned(
                      top: -2,
                      right: -2,
                      child: Container(
                        width: 10.w,
                        height: 10.w,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.notifications,
                          size: 6.sp,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
