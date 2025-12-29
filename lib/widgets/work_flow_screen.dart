import 'package:dpp_pharma/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class WorkflowStepData {
  final IconData icon;
  final String label;
  final String? tip;
  WorkflowStepData(this.icon, this.label, {this.tip});
}

class AnimatedAuthWorkflow extends StatefulWidget {
  const AnimatedAuthWorkflow({Key? key}) : super(key: key);

  @override
  State<AnimatedAuthWorkflow> createState() => _AnimatedAuthWorkflowState();
}

class _AnimatedAuthWorkflowState extends State<AnimatedAuthWorkflow>
    with TickerProviderStateMixin {
  int activeStep = 0;
  final List<WorkflowStepData> steps = [
    WorkflowStepData(
      Icons.park_rounded,
      "Source",
      tip: "Raw material origin verified",
    ),
    WorkflowStepData(Icons.science_rounded, "Lab", tip: "Tested in ISO labs"),
    WorkflowStepData(
      Icons.verified_rounded,
      "Verify",
      tip: "Digital QR/trace check",
    ),
    WorkflowStepData(
      Icons.local_shipping_rounded,
      "Package",
      tip: "Secured & labeled",
    ),
    WorkflowStepData(Icons.verified, "Certified", tip: "Pharma approved batch"),
  ];
  List<AnimationController>? _bubbleControllers;

  @override
  void initState() {
    super.initState();
    _bubbleControllers = List.generate(
      steps.length,
      (index) => AnimationController(
        duration: Duration(milliseconds: 520),
        vsync: this,
      ),
    );
    WidgetsBinding.instance.addPostFrameCallback((_) => animateSteps());
  }

  Future<void> animateSteps() async {
    for (int i = 0; i < steps.length; i++) {
      await Future.delayed(Duration(milliseconds: 350));
      setState(() => activeStep = i);
      _bubbleControllers?[i]?.forward();
    }
  }

  @override
  void dispose() {
    for (final c in _bubbleControllers!) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // FULL WIDTH clean card
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(steps.length, (i) {
            final isActive = i <= activeStep;
            return Expanded(
              child: Column(
                children: [
                  AnimatedBuilder(
                    animation: _bubbleControllers![i],
                    builder: (context, child) {
                      double t = _bubbleControllers![i].value;
                      return Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isActive
                              ? AppColors.primary.withOpacity(0.80 + 0.2 * t)
                              : Colors.grey[200],
                          boxShadow: isActive
                              ? [
                                  BoxShadow(
                                    color: AppColors.primary.withOpacity(
                                      0.18 + t * 0.32,
                                    ),
                                    blurRadius: 18.r,
                                    spreadRadius: 0.8,
                                  ),
                                ]
                              : [],
                        ),
                        padding: EdgeInsets.all(9.w + t * 7.w),
                        child: Icon(
                          steps[i].icon,
                          color: isActive ? Colors.white : AppColors.primary,
                          size: 28.sp + t * 4.sp,
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 8.h),
                  AnimatedDefaultTextStyle(
                    duration: Duration(milliseconds: 320),
                    style: TextStyle(
                      color: isActive ? AppColors.primary : Colors.black54,
                      fontWeight: isActive
                          ? FontWeight.bold
                          : FontWeight.normal,
                      fontSize: 12.5.sp,
                      letterSpacing: .18,
                    ),
                    child: Text(steps[i].label, textAlign: TextAlign.center),
                  ),
                  if (steps[i].tip != null && isActive)
                    Padding(
                      padding: EdgeInsets.only(top: 5.h),
                      child: AnimatedOpacity(
                        opacity: 1,
                        duration: Duration(milliseconds: 430),
                        child: Text(
                          steps[i].tip!,
                          style: GoogleFonts.roboto(
                            fontSize: 10.sp,
                            color: AppColors.primary,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              ),
            );
          }),
        ),
        // Progress bar below icons
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 17.h),
          child: Stack(
            alignment: Alignment.centerLeft,
            children: [
              Container(
                height: 5.h,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(30.r),
                ),
              ),
              AnimatedContainer(
                duration: Duration(milliseconds: 350),
                curve: Curves.easeOut,
                height: 5.h,
                width:
                    (activeStep / (steps.length - 1)).clamp(0, 1) *
                    MediaQuery.of(context).size.width *
                    0.9,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(30.r),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
