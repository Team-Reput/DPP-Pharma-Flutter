import 'dart:math';

import 'package:dpp_pharma/models/dpp_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class IngredientWheel extends StatefulWidget {
  final List<Composition> compositions;
  const IngredientWheel({super.key, required this.compositions});

  @override
  State<IngredientWheel> createState() => _IngredientWheelState();
}

class _IngredientWheelState extends State<IngredientWheel> {
  double _rotation = 0; // current rotation (radians)
  double _startRotation = 0; // rotation at drag start
  double _startAngle = 0; // finger angle at drag start
  int? _selectedIndex;

  Color _segmentColor(int index) {
    final colors = [
      const Color(0xFFB2EBF2),
      const Color(0xFFC8E6C9),
      const Color(0xFFCFD8DC),
      const Color(0xFFD1C4E9),
      const Color(0xFFFFF9C4),
      const Color(0xFFB3E5FC),
      const Color(0xFFE1F5FE),
      const Color(0xFFE8F5E9),
    ];
    return colors[index % colors.length];
  }

  void _onPanStart(DragStartDetails details, BoxConstraints constraints) {
    final box = context.findRenderObject() as RenderBox;
    final local = box.globalToLocal(details.globalPosition);
    final center = Offset(constraints.maxWidth / 4, constraints.maxHeight / 2);
    _startAngle = atan2(local.dy - center.dy, local.dx - center.dx);
    _startRotation = _rotation;
  }

  void _onPanUpdate(DragUpdateDetails details, BoxConstraints constraints) {
    final box = context.findRenderObject() as RenderBox;
    final local = box.globalToLocal(details.globalPosition);
    final center = Offset(constraints.maxWidth / 4, constraints.maxHeight / 2);
    final angle = atan2(local.dy - center.dy, local.dx - center.dx);
    setState(() {
      _rotation = _startRotation + (angle - _startAngle);
    });
  }

  Future<void> _onPanEnd() async {
    final count = widget.compositions.isEmpty ? 1 : widget.compositions.length;
    final segAngle = (2 * pi) / count;

    double angle = (-_rotation) % (2 * pi);
    if (angle < 0) angle += 2 * pi;

    final shifted = (angle + pi / 2) % (2 * pi);
    final index = (shifted ~/ segAngle) % count;

    await Future.delayed(const Duration(microseconds: 50));
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    final comps = widget.compositions;
    final selected = (_selectedIndex != null && _selectedIndex! < comps.length)
        ? comps[_selectedIndex!]
        : null;

    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          height: 200.h,
          width: double.infinity,
          padding: EdgeInsets.all(8.w),
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onPanStart: (d) => _onPanStart(d, constraints),
                  onPanUpdate: (d) => _onPanUpdate(d, constraints),
                  onPanEnd: (_) => _onPanEnd(),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Positioned(
                        top: 4.h,
                        child: Icon(
                          Icons.arrow_drop_down,
                          color: Colors.redAccent,
                          size: 32.sp,
                        ),
                      ),
                      Transform.rotate(
                        angle: _rotation,
                        child: CustomPaint(
                          size: Size.square(160.w),
                          painter: _RingWheelPainter(
                            compositions: comps,
                            getColor: _segmentColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  child: selected == null
                      ? Center(
                          child: Text(
                            'Rotate the wheel\nand pause on a segment',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.roboto(
                              fontSize: 11.sp,
                              color: Colors.grey[600],
                            ),
                          ),
                        )
                      : _IngredientDetailCard(
                          key: ValueKey(selected.ingredientName),
                          composition: selected,
                        ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _RingWheelPainter extends CustomPainter {
  final List<Composition> compositions;
  final Color Function(int index) getColor;

  _RingWheelPainter({required this.compositions, required this.getColor});

  @override
  void paint(Canvas canvas, Size size) {
    final count = compositions.isEmpty ? 1 : compositions.length;
    final center = size.center(Offset.zero);
    final outerR = size.width / 2;
    final innerR = outerR * 0.65;
    final sweep = (2 * pi) / count;
    final radius = (outerR + innerR) / 2;

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = outerR - innerR;

    for (int i = 0; i < count; i++) {
      paint.color = getColor(i);
      final start = -pi / 2 + i * sweep;
      final rect = Rect.fromCircle(center: center, radius: radius);
      canvas.drawArc(rect, start, sweep, false, paint);
    }

    final centerPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, innerR * 0.9, centerPaint);
  }

  @override
  bool shouldRepaint(covariant _RingWheelPainter oldDelegate) =>
      oldDelegate.compositions != compositions;
}

class _IngredientDetailCard extends StatelessWidget {
  final Composition composition;

  const _IngredientDetailCard({super.key, required this.composition});

  @override
  Widget build(BuildContext context) {
    final c = composition;
    return Container(
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: DefaultTextStyle(
        style: GoogleFonts.roboto(fontSize: 11.sp, color: Colors.black87),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              c.ingredientName.isEmpty ? 'Capsule component' : c.ingredientName,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.roboto(
                fontSize: 13.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              c.botanicalName ?? 'Botanical: NA',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.roboto(
                fontSize: 10.sp,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: 6.h),
            _detailRow('Part used', c.partUsed ?? '-'),
            _detailRow('Extract', '${c.extractMg ?? '-'} mg'),
            _detailRow('Derived from', '${c.derivedFromMg ?? '-'} mg'),
            if (c.edibleColours != null && c.edibleColours!.isNotEmpty)
              _detailRow('Edible colours', c.edibleColours!),
          ],
        ),
      ),
    );
  }

  Widget _detailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(top: 3.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label: ',
            style: GoogleFonts.roboto(
              fontSize: 10.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          Expanded(
            child: Text(value, maxLines: 3, overflow: TextOverflow.ellipsis),
          ),
        ],
      ),
    );
  }
}
