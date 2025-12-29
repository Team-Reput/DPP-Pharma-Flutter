import 'package:dpp_pharma/models/dpp_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CompositionPlayground extends StatefulWidget {
  final List<Composition> compositions;
  const CompositionPlayground({super.key, required this.compositions});

  @override
  State<CompositionPlayground> createState() => _CompositionPlaygroundState();
}

class _CompositionPlaygroundState extends State<CompositionPlayground> {
  // create once, never null
  final PageController _pageController = PageController(
    viewportFraction: 0.55,
    initialPage: 0,
  );

  int activeIndex = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filtered = widget.compositions
        .where((c) => (c.isPreservative ?? false) == false)
        .where((c) => c.ingredientName.isNotEmpty)
        .toList();

    if (filtered.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Composition Details",
          style: GoogleFonts.roboto(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 5.h),
        SizedBox(
          height: 250.h,
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (i) => setState(() => activeIndex = i),
            itemCount: filtered.length,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              final c = filtered[index];

              return AnimatedBuilder(
                animation: _pageController,
                builder: (context, child) {
                  double value;

                  if (_pageController.hasClients &&
                      _pageController.position.haveDimensions) {
                    final page =
                        _pageController.page ??
                        _pageController.initialPage.toDouble();
                    value = page - index;
                  } else {
                    value = activeIndex - index.toDouble();
                  }

                  value = value.clamp(-1.0, 1.0);
                  final scale = 1 - (value.abs() * 0.18);
                  final opacity = 1 - (value.abs() * 0.4);

                  return Center(
                    child: Opacity(
                      opacity: opacity,
                      child: Transform.scale(
                        scale: scale,
                        child: _CompositionCard(
                          composition: c,
                          index: index,
                          selected: index == activeIndex,
                          onTap: () {
                            _pageController.animateToPage(
                              index,
                              duration: const Duration(milliseconds: 280),
                              curve: Curves.easeInCirc,
                            );
                          },
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

class _CompositionCard extends StatefulWidget {
  final Composition composition;
  final int index;
  final bool selected;
  final VoidCallback onTap;

  const _CompositionCard({
    required this.composition,
    required this.index,
    required this.selected,
    required this.onTap,
  });

  @override
  State<_CompositionCard> createState() => _CompositionCardState();
}

class _CompositionCardState extends State<_CompositionCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 350),
  );

  @override
  void didUpdateWidget(covariant _CompositionCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selected) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  void initState() {
    super.initState();
    // initial “pop‑in” animation
    Future.delayed(Duration(microseconds: 80 * widget.index), () {
      if (mounted) _controller.forward(from: 0);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final c = widget.composition;

    return ScaleTransition(
      scale: Tween<double>(begin: 0.9, end: 1.02).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
      ),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 260),
          width: 250.w,
          padding: EdgeInsets.all(10.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18.r),
            color: Colors.green.shade100,
            // gradient: LinearGradient(
            //   colors: widget.selected
            //       ? [Colors.green.shade100, const Color(0xFFc8e6ff)]
            //       : [Colors.white, Colors.grey.shade50],
            //   begin: Alignment.topLeft,
            //   end: Alignment.bottomRight,
            // ),
            // boxShadow: [
            //   if (widget.selected)
            //     BoxShadow(
            //       color: Colors.green.withOpacity(0.3),
            //       blurRadius: 14.r,
            //       offset: const Offset(0, 6),
            //     ),
            // ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    _MiniDonutGauge(
                      value: (c.extractMg ?? 0).toDouble(),
                      maxValue: (c.derivedFromMg ?? 100).toDouble(),
                    ),
                    Text(
                      c.ingredientName.isEmpty
                          ? 'Edible colour'
                          : c.ingredientName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.roboto(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      c.botanicalName ?? 'Botanical: NA',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.roboto(
                        fontSize: 15.sp,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 6.h),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _pillText(
                          label: 'Part used',
                          value: c.partUsed ?? 'NA',
                        ),
                        SizedBox(height: 4.h),
                        _pillText(
                          label: 'Extract',
                          value: '${c.extractMg ?? '-'} mg',
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              // expanded details
              AnimatedSize(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeOut,
                child: widget.selected
                    ? Padding(
                        padding: EdgeInsets.only(top: 8.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Derived from: ${c.derivedFromMg ?? '-'} mg',
                              style: GoogleFonts.roboto(
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            if (c.edibleColours != null &&
                                c.edibleColours!.isNotEmpty)
                              Padding(
                                padding: EdgeInsets.only(top: 4.h),
                                child: Text(
                                  'Colour: ${c.edibleColours}',
                                  style: GoogleFonts.roboto(
                                    fontSize: 9.5.sp,
                                    color: Colors.deepPurple,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      )
                    : const SizedBox.shrink(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _pillText({required String label, required String value}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.r),
      border: Border.all(color: Colors.green.shade100),
    ),
    child: Text(
      '$label: $value',
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: GoogleFonts.roboto(fontSize: 14.sp),
    ),
  );
}

class _MiniDonutGauge extends StatelessWidget {
  final double value;
  final double maxValue;
  const _MiniDonutGauge({required this.value, required this.maxValue});

  @override
  Widget build(BuildContext context) {
    final pct = maxValue <= 0 ? 0.0 : (value / maxValue).clamp(0.0, 1.0);
    return Container(
      // color: Colors.red,
      width: 120.w,
      height: 30.h,
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0, end: pct),
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOut,
        builder: (context, animValue, _) {
          return Stack(
            alignment: Alignment.center,
            children: [
              CircularProgressIndicator(
                value: animValue,
                strokeWidth: 4,
                backgroundColor: Colors.grey.shade200,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
              ),
              Text(
                '${(animValue * 100).round()}%',
                style: GoogleFonts.roboto(fontSize: 13.sp),
              ),
            ],
          );
        },
      ),
    );
  }
}

class KeyIngredientPlayground extends StatefulWidget {
  final List<KeyIngredient> keyIngredients;
  const KeyIngredientPlayground({super.key, required this.keyIngredients});

  @override
  State<KeyIngredientPlayground> createState() =>
      _KeyIngredientPlaygroundState();
}

class _KeyIngredientPlaygroundState extends State<KeyIngredientPlayground> {
  static const int _pageSize = 6;
  int _visibleCount = _pageSize;

  @override
  void initState() {
    super.initState();
    _visibleCount = _pageSize.clamp(0, widget.keyIngredients.length);
  }

  @override
  Widget build(BuildContext context) {
    final total = widget.keyIngredients.length;
    final sliceEnd = _visibleCount.clamp(0, total);
    final visibleItems = widget.keyIngredients.take(sliceEnd).toList();

    final allVisible = sliceEnd >= total;
    final canShowToggle = total > _pageSize;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Key Ingredient Functions",
          style: GoogleFonts.roboto(
            fontWeight: FontWeight.bold,
            fontSize: 16.sp,
          ),
        ),
        SizedBox(height: 8.h),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: Colors.green[50],
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: Colors.green.shade100),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Table(
                  defaultVerticalAlignment: TableCellVerticalAlignment.top,
                  columnWidths: const {
                    0: FixedColumnWidth(220), // Ingredient (2 lines)
                    1: FixedColumnWidth(220), // Function
                  },
                  children: [_headerRow(), ...visibleItems.map(_dataRow)],
                ),
                if (canShowToggle) SizedBox(height: 6.h),
                if (canShowToggle)
                  InkWell(
                    onTap: () {
                      setState(() {
                        if (allVisible) {
                          _visibleCount = _pageSize.clamp(
                            0,
                            widget.keyIngredients.length,
                          );
                        } else {
                          _visibleCount = (_visibleCount + _pageSize).clamp(
                            0,
                            total,
                          );
                        }
                      });
                    },
                    borderRadius: BorderRadius.circular(20.r),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 6.w,
                        vertical: 4.h,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            allVisible ? 'View less' : 'View more',
                            style: GoogleFonts.roboto(
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.green[800],
                            ),
                          ),
                          SizedBox(width: 4.w),
                          Icon(
                            allVisible
                                ? Icons.keyboard_arrow_up_rounded
                                : Icons.keyboard_arrow_down_rounded,
                            size: 16.sp,
                            color: Colors.green[800],
                          ),
                        ],
                      ),
                    ),
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    _LegendDot(color: Colors.orange.withOpacity(0.5)),
                    SizedBox(width: 4.w),
                    Text(
                      'Analgesic',
                      style: GoogleFonts.roboto(fontSize: 10.sp),
                    ),
                    SizedBox(width: 10.w),
                    _LegendDot(color: Colors.red.withOpacity(0.5)),
                    SizedBox(width: 4.w),
                    Text(
                      'Anti‑inflammatory',
                      style: GoogleFonts.roboto(fontSize: 10.sp),
                    ),
                    SizedBox(width: 10.w),
                    _LegendDot(color: Colors.green.withOpacity(0.5)),
                    SizedBox(width: 4.w),
                    Text('Others', style: GoogleFonts.roboto(fontSize: 10.sp)),
                  ],
                ),
                SizedBox(height: 6.h),
              ],
            ),
          ),
        ),
      ],
    );
  }

  TableRow _headerRow() {
    final style = GoogleFonts.roboto(
      fontSize: 11.sp,
      fontWeight: FontWeight.w700,
    );

    Widget cell(String text) => Padding(
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
      child: Text(text, style: style),
    );

    return TableRow(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.green.shade200)),
      ),
      children: [cell("Ingredient"), cell("Function")],
    );
  }

  TableRow _dataRow(KeyIngredient k) {
    final rowStyle = GoogleFonts.roboto(
      fontSize: 10.sp,
      fontWeight: FontWeight.w400,
    );

    Color highlightColor;
    if (k.functions.toLowerCase().contains('analgesic')) {
      highlightColor = Colors.orange.withOpacity(0.12);
    } else if (k.functions.toLowerCase().contains('anti-inflammatory')) {
      highlightColor = Colors.red.withOpacity(0.10);
    } else {
      highlightColor = Colors.green.withOpacity(0.06);
    }

    Widget ingredientCell() => Padding(
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 6.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            k.botanicalName,
            style: rowStyle.copyWith(fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 2.h),
          Text(k.ingredientName, style: rowStyle),
        ],
      ),
    );

    Widget functionCell() => Padding(
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 6.h),
      child: Text(k.functions, style: rowStyle),
    );

    return TableRow(
      decoration: BoxDecoration(color: highlightColor),
      children: [ingredientCell(), functionCell()],
    );
  }
}

class _LegendDot extends StatelessWidget {
  final Color color;
  const _LegendDot({required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 10.w,
      height: 10.w,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}
