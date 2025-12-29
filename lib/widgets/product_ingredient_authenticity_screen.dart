// // import 'package:flutter/material.dart';
// import 'package:dpp_pharma/models/dpp_models.dart';
// import 'package:dpp_pharma/provider/dpp_provider.dart';
// import 'package:dpp_pharma/widgets/common_widgets/common_widgets.dart';
// import 'package:dpp_pharma/widgets/passport_card.dart';
// import 'package:dpp_pharma/widgets/product_info_card.dart';
// import 'package:dpp_pharma/widgets/work_flow_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';

// class ProductIngredientAuthenticityScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final dpp = context.watch<DppProvider>();
//     final product = dpp.product;

//     final compositionsRaw = product?.compositions ?? [];
//     final compositions = compositionsRaw
//         .where((c) => (c.isPreservative ?? false) == false)
//         .toList();

//     final List<KeyIngredient> keyIngredients = product?.keyIngredients ?? [];

//     return Scaffold(
//       backgroundColor: const Color(0xFFFFFFFF),
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back),
//           onPressed: () => Navigator.pop(context),
//           color: Colors.black,
//         ),
//         title: Text(
//           'Product & Composition Authenticity',
//           style: GoogleFonts.roboto(
//             fontWeight: FontWeight.bold,
//             fontSize: 18.sp,
//           ),
//         ),
//         foregroundColor: Colors.black,
//       ),
//       body: ListView(
//         padding: EdgeInsets.symmetric(horizontal: 18.w),
//         children: [
//           Text(
//             "Composition Source & Origin",
//             style: GoogleFonts.roboto(
//               fontSize: 16.sp,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           SingleChildScrollView(
//             scrollDirection: Axis.horizontal,
//             child: Container(
//               margin: EdgeInsets.only(top: 6.h, bottom: 10.h),
//               padding: EdgeInsets.all(8.w),
//               decoration: BoxDecoration(
//                 color: Colors.green[50],
//                 borderRadius: BorderRadius.circular(12.r),
//                 border: Border.all(color: Colors.green.shade100),
//               ),
//               child: Table(
//                 defaultVerticalAlignment: TableCellVerticalAlignment.middle,
//                 columnWidths: const {
//                   0: IntrinsicColumnWidth(), // Ingredient
//                   1: IntrinsicColumnWidth(), // Part
//                   2: IntrinsicColumnWidth(), // Extract mg
//                   3: IntrinsicColumnWidth(), // From mg
//                   4: FixedColumnWidth(180), // Botanical name
//                 },
//                 children: [
//                   _compositionHeaderRow(),
//                   ...compositions.map(_compositionRow),
//                 ],
//               ),
//             ),
//           ),
//           SizedBox(height: 5.h),
//           Text(
//             "Ingredient Details",
//             style: GoogleFonts.roboto(
//               fontWeight: FontWeight.bold,
//               fontSize: 16.sp,
//             ),
//           ),
//           SizedBox(height: 8.h),

//           SingleChildScrollView(
//             scrollDirection: Axis.horizontal,
//             child: Container(
//               padding: EdgeInsets.all(10.w),
//               decoration: BoxDecoration(
//                 color: Colors.green[50],
//                 borderRadius: BorderRadius.circular(12.r),
//                 border: Border.all(color: Colors.green.shade100),
//               ),
//               child: Table(
//                 defaultVerticalAlignment: TableCellVerticalAlignment.middle,
//                 columnWidths: const {
//                   0: IntrinsicColumnWidth(), // Ingredient
//                   1: FixedColumnWidth(170), // Functions
//                   2: FixedColumnWidth(170), // Botanical name
//                 },
//                 children: [
//                   _keyIngHeaderRow(),
//                   ...keyIngredients.map(_keyIngRow),
//                 ],
//               ),
//             ),
//           ),
//           SizedBox(height: 10.h),

//           SizedBox(height: 15.h),

//           // Methods of Extraction/Synthesis
//           Text(
//             "Extraction & Authentication Methods",
//             style: GoogleFonts.roboto(
//               fontWeight: FontWeight.bold,
//               fontSize: 16.sp,
//             ),
//           ),
//           SizedBox(height: 8.h),
//           Wrap(
//             spacing: 7.w,
//             runSpacing: 6.h,
//             children: [
//               _MethodChip(label: "HPLC Tested"),
//               _MethodChip(label: "Spectroscopy"),
//               _MethodChip(label: "DNA Tagging"),
//               _MethodChip(label: "RFID Trace"),
//               _MethodChip(label: "Lab Minikit Verified"),
//             ],
//           ),
//           SizedBox(height: 15.h),
//           Text(
//             'Verification Documents',
//             style: GoogleFonts.roboto(
//               fontWeight: FontWeight.bold,
//               fontSize: 16.sp,
//             ),
//           ),
//           SizedBox(height: 8.h),
//           Row(
//             children: [
//               _VerificationIcon(label: "CoA", asset: 'assets/temp/coa.png'),
//               SizedBox(width: 10.w),
//               _VerificationIcon(label: "FDA", asset: 'assets/temp/fda.jpeg'),
//               SizedBox(width: 10.w),
//               _VerificationIcon(
//                 label: "AYUSH",
//                 asset: 'assets/temp/ayush.jpeg',
//               ),
//             ],
//           ),
//           SizedBox(height: 15.h),
//         ],
//       ),
//     );
//   }
// }

// TableRow _compositionHeaderRow() {
//   final headerStyle = GoogleFonts.roboto(
//     fontSize: 15.sp,
//     fontWeight: FontWeight.w700,
//   );

//   Widget cell(String text) => Padding(
//     padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
//     child: Text(
//       text,
//       maxLines: 2,
//       overflow: TextOverflow.ellipsis,
//       style: headerStyle,
//     ),
//   );

//   return TableRow(
//     decoration: BoxDecoration(
//       border: Border(bottom: BorderSide(color: Colors.green.shade200)),
//     ),
//     children: [
//       cell("Ingredient"),
//       cell("Part used"),
//       cell("Extract mg"),
//       cell("From mg"),
//       cell("Botanical name"),
//     ],
//   );
// }

// TableRow _compositionRow(Composition c) {
//   final rowStyle = GoogleFonts.roboto(
//     fontSize: 13.sp,
//     fontWeight: FontWeight.w600,
//   );

//   Widget cell(String text) => Padding(
//     padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 3.h),
//     child: Text(
//       text,
//       maxLines: 3,
//       overflow: TextOverflow.ellipsis,
//       style: rowStyle,
//     ),
//   );

//   return TableRow(
//     children: [
//       cell(c.ingredientName),
//       cell(c.partUsed ?? '-'),
//       cell(c.extractMg?.toString() ?? '-'),
//       cell(c.derivedFromMg?.toString() ?? '-'),
//       cell(c.botanicalName ?? '-'),
//     ],
//   );
// }

// class _VerificationIcon extends StatelessWidget {
//   final String label;
//   final String asset;
//   const _VerificationIcon({required this.label, required this.asset});
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Image.asset(asset, width: 50.w, height: 50.w),
//         SizedBox(height: 2.h),
//         Text(label, style: GoogleFonts.roboto(fontSize: 10.sp)),
//       ],
//     );
//   }
// }

// TableRow _keyIngHeaderRow() {
//   final headerStyle = GoogleFonts.roboto(
//     fontSize: 15.sp,
//     fontWeight: FontWeight.w700,
//   );

//   Widget cell(String text) => Padding(
//     padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
//     child: Text(
//       text,
//       maxLines: 2,
//       overflow: TextOverflow.ellipsis,
//       style: headerStyle,
//     ),
//   );

//   return TableRow(
//     decoration: BoxDecoration(
//       border: Border(bottom: BorderSide(color: Colors.green.shade200)),
//     ),
//     children: [
//       cell("Key ingredient"),
//       cell("Function / role"),
//       cell("Botanical name"),
//     ],
//   );
// }

// TableRow _keyIngRow(KeyIngredient k) {
//   final rowStyle = GoogleFonts.roboto(
//     fontSize: 13.sp,
//     fontWeight: FontWeight.w600,
//   );

//   Widget cell(String text) => Padding(
//     padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 3.h),
//     child: Text(
//       text,
//       maxLines: 3,
//       overflow: TextOverflow.ellipsis,
//       style: rowStyle,
//     ),
//   );

//   return TableRow(
//     children: [
//       cell(k.ingredientName),
//       cell(k.functions),
//       cell(k.botanicalName),
//     ],
//   );
// }

// class _MethodChip extends StatelessWidget {
//   final String label;
//   const _MethodChip({required this.label});
//   @override
//   Widget build(BuildContext context) {
//     return Chip(
//       label: Text(label, style: GoogleFonts.roboto(fontSize: 11.sp)),
//       backgroundColor: Colors.teal[50],
//     );
//   }
// }
