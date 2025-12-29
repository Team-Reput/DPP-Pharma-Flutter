// import 'package:flutter/material.dart';
import 'package:dpp_pharma/models/dpp_models.dart';
import 'package:dpp_pharma/provider/dpp_provider.dart';
import 'package:dpp_pharma/widgets/circular_spinner.dart';
import 'package:dpp_pharma/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ProductIngredientAuthenticityScreen extends StatelessWidget {
  @override
  @override
  Widget build(BuildContext context) {
    final dpp = context.watch<DppProvider>();
    final product = dpp.product;
    final compositions = product?.compositions ?? [];
    final keyIngredients = product?.keyIngredients ?? [];

    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
          color: Colors.black,
        ),
        title: Text(
          'Product & Composition Authenticity',
          style: GoogleFonts.roboto(
            fontWeight: FontWeight.bold,
            fontSize: 18.sp,
          ),
        ),
        foregroundColor: Colors.black,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 10.h),
        children: [
          // IngredientWheel(compositions: compositions),
          CompositionPlayground(compositions: compositions),
          SizedBox(height: 10.h),
          KeyIngredientPlayground(keyIngredients: keyIngredients),
        ],
      ),
    );
  }
}
