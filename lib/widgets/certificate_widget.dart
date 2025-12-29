import 'package:dpp_pharma/models/dpp_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductCertificatesSection extends StatelessWidget {
  final List<ProductCertificate> certificates;

  const ProductCertificatesSection({super.key, required this.certificates});

  @override
  Widget build(BuildContext context) {
    if (certificates.isEmpty) return const SizedBox.shrink();

    return Card(
      margin: EdgeInsets.only(top: 10.h, bottom: 10.h),
      elevation: 10,
      color: const Color(0xFFdeebe2),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Product Certificates',
              style: GoogleFonts.roboto(
                fontSize: 17.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF0000000),
              ),
            ),
            SizedBox(height: 10.h),
            ...certificates
                .map((c) => _CertificateTile(certificate: c))
                .toList(),
          ],
        ),
      ),
    );
  }
}

class _CertificateTile extends StatelessWidget {
  final ProductCertificate certificate;

  const _CertificateTile({required this.certificate});

  bool get _isExpired {
    if (certificate.lastValidityDate == null ||
        certificate.lastValidityDate!.isEmpty) {
      return false;
    }
    try {
      final d = DateTime.parse(certificate.lastValidityDate!);
      return d.isBefore(DateTime.now());
    } catch (_) {
      return false;
    }
  }

  String _formatDate(String? raw) {
    if (raw == null || raw.isEmpty) return 'NA';
    try {
      final dt = DateTime.parse(raw);
      return DateFormat('d MMM, y').format(dt);
    } catch (_) {
      return raw;
    }
  }

  Future<void> _openDocument() async {
    final uri = Uri.parse(certificate.documentUrl);
    if (!await canLaunchUrl(uri)) {
      return;
    }
    await launchUrl(
      uri,
      mode: LaunchMode.platformDefault, // web: new tab, mobile: browser/app
      webViewConfiguration: const WebViewConfiguration(enableJavaScript: true),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: _openDocument,
      borderRadius: BorderRadius.circular(16.r),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // certificate thumbnail placeholder
            Container(
              width: 64.w,
              height: 48.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(color: Colors.blue.shade100),
              ),
              child: Icon(
                Icons.insert_drive_file_outlined,
                color: Colors.blue.shade700,
                size: 28.sp,
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    certificate.certificateName.isEmpty
                        ? certificate.documentName
                        : certificate.certificateName,
                    style: GoogleFonts.roboto(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.blue.shade900,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.event_available,
                        size: 14.sp,
                        color: Colors.green.shade800,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        'Date: ${_formatDate(certificate.issueDate)}',
                        style: GoogleFonts.roboto(
                          fontSize: 13.sp,
                          color: Colors.green.shade900,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 2.h),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        _isExpired
                            ? Icons.report_gmailerrorred
                            : Icons.lock_clock,
                        size: 14.sp,
                        color: _isExpired
                            ? theme.colorScheme.error
                            : Colors.red.shade700,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        _isExpired
                            ? 'Expired on: ${_formatDate(certificate.lastValidityDate)}'
                            : 'Expires on: ${_formatDate(certificate.lastValidityDate)}',
                        style: GoogleFonts.roboto(
                          fontSize: 14.sp,
                          color: _isExpired
                              ? theme.colorScheme.error
                              : Colors.red.shade800,
                          fontWeight: _isExpired
                              ? FontWeight.w700
                              : FontWeight.w500,
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
    );
  }
}
