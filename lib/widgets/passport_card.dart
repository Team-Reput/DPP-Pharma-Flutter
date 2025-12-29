import 'package:dpp_pharma/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductIdentityCard extends StatefulWidget {
  final ProductModel model;
  final String gtin;
  final String serial;
  final String batch;
  final String expiry;
  const ProductIdentityCard({
    super.key,
    required this.gtin,
    required this.serial,
    required this.batch,
    required this.expiry,
    required this.model,
  });

  @override
  State<ProductIdentityCard> createState() => _ProductIdentityCardState();
}

class _ProductIdentityCardState extends State<ProductIdentityCard> {
  bool _showJourney = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.network(widget.model.productImageUrl, height: 80.h),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _IdChip('Expiry: ${widget.expiry}'),
                SizedBox(height: 5.h),
                _IdChip('GTIN: ${widget.gtin}'),
                SizedBox(height: 5.h),
                _IdChip('Serial: ${widget.serial}'),
                SizedBox(height: 5.h),
                _IdChip('Batch: ${widget.batch}'),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class _IdChip extends StatelessWidget {
  final String text;
  const _IdChip(this.text);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 3.h),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 249, 253, 249),
        borderRadius: BorderRadius.circular(11.r),
      ),
      child: Text(
        text,
        style: GoogleFonts.roboto(
          fontSize: 12.sp,
          color: Colors.black,
          letterSpacing: 0.1,
        ),
      ),
    );
  }
}
