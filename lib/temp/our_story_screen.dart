import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart' hide DeviceType;

// simple enum + helper so it compiles without your existing ResponsiveHelper
enum DeviceType { mobile, web }

DeviceType getDeviceType(double width) {
  return width < 800 ? DeviceType.mobile : DeviceType.web;
}

double responsiveFontSize(double mobile, double web, DeviceType type) {
  return type == DeviceType.mobile ? mobile.sp : web.sp;
}

class OurStoryScreen extends StatefulWidget {
  const OurStoryScreen({super.key});

  @override
  State<OurStoryScreen> createState() => _OurStoryScreenState();
}

class _OurStoryScreenState extends State<OurStoryScreen>
    with TickerProviderStateMixin {
  late AnimationController _expandController;
  late Animation<double> _expandAnimation;
  late Animation<Offset> _slideAnimation;
  late ScrollController _scrollController;

  bool _showDetails = false;
  bool _isVideoPlaying = false; // kept for future use

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController();

    _expandController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _expandAnimation = CurvedAnimation(
      parent: _expandController,
      curve: Curves.easeInOut,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(_expandAnimation);
  }

  @override
  void dispose() {
    _expandController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  // ---------------- MOCK DATA (replaces decryptedData / provider) ----------------

  final Map<String, dynamic> headerStory = const {
    'is_author': true,
    'authorimagepath':
        'https://dummyimage.com/200x200/0b8c4a/ffffff.png&text=MH',
    'authorname': 'Dr. Ananya Deshpande',
    'designation': 'Head – Medical & Scientific Affairs',
    'authortitle': 'Millennium Herbal Care Limited',
    'storytitle': 'Herbal Health for Every Home',
    'location_name': 'Mumbai, Maharashtra, India',
  };

  final List<Map<String, dynamic>> womenEmpowermentList = const [
    {
      'tabid': 18,
      'storytitle': 'Ayurveda for Rural Women',
      'entrydate': '2025-01-15T00:00:00',
      'location_name': 'Nashik, Maharashtra, India',
      'mediapath': 'assets/temp/women training.jpeg',
      'storydescription':
          'Millennium Herbal Care organized hands-on workshops for rural women on safe herbal formulations—like cough syrups and wound oils—linking them to local SHGs for income generation.',
    },
    {
      'tabid': 18,
      'storytitle': 'Community Herbal Health Camps',
      'entrydate': '2025-03-10T00:00:00',
      'location_name': 'Palghar, Maharashtra, India',
      'mediapath': 'assets/temp/health_camp.jpeg',
      'storydescription':
          'Doctors and Ayurveda experts from Millennium conducted free herbal health check-ups, counselling and product donations for underserved patients.',
    },
    {
      'tabid': 18,
      'storytitle': 'Sustainable Herb Farming',
      'entrydate': '2025-07-20T00:00:00',
      'location_name': 'Satara, Maharashtra, India',
      'mediapath': 'assets/temp/herbs_farms.jpeg',
      'storydescription':
          'Small farmers were trained to cultivate medicinal plants used in Millennium’s formulations, improving traceability and providing assured buy-back.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      designSize: const Size(390, 844),
      minTextAdapt: true,
    );
    final width = MediaQuery.of(context).size.width;
    final deviceType = getDeviceType(width);

    final bool isAuthor = headerStory['is_author'] == true;

    return SingleChildScrollView(
      controller: _scrollController,
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Header block
          isAuthor
              ? Row(
                  children: [
                    CircleAvatar(
                      radius: 30.sp,
                      backgroundImage: NetworkImage(
                        headerStory['authorimagepath'] ?? '',
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          headerStory['authorname'] ?? 'Author Name',
                          style: TextStyle(
                            fontFamily: 'Gilroy-Light',
                            fontWeight: FontWeight.bold,
                            fontSize: responsiveFontSize(18, 8, deviceType),
                          ),
                        ),
                        Text(
                          headerStory['designation'] ?? 'Designation',
                          style: TextStyle(
                            fontSize: responsiveFontSize(15, 5, deviceType),
                            fontFamily: 'Gilroy-Light',
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          headerStory['authortitle'] ?? 'No Title Provided',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: responsiveFontSize(15, 5, deviceType),
                            fontFamily: 'Gilroy-Light',
                          ),
                          softWrap: true,
                        ),
                      ],
                    ),
                  ],
                )
              : Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          headerStory['storytitle'] ?? 'Story Title',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: responsiveFontSize(18, 8, deviceType),
                            fontFamily: 'Gilroy-Light',
                          ),
                        ),
                        Text(
                          headerStory['location_name'] ?? 'Location name',
                          style: TextStyle(
                            fontSize: responsiveFontSize(11, 7, deviceType),
                            fontFamily: 'Gilroy-Light',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

          SizedBox(height: 24.h),

          // 2. CSR cards list (bottom sheet content in original code)
          buildBottomSheetContent(deviceType),
        ],
      ),
    );
  }

  Widget eachCSRActivityBasedCard(
    Map<String, dynamic> csr,
    bool isMiddleElement,
    DeviceType deviceType,
  ) {
    return Padding(
      padding: EdgeInsets.all(12.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            csr['storytitle'] ?? 'No Title',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: responsiveFontSize(16, 7, deviceType),
              fontFamily: 'Gilroy-Light',
            ),
            softWrap: true,
          ),
          SizedBox(height: 8.h),
          Text(
            '${csr['entrydate']?.toString().split('T').first ?? ''} • ${csr['location_name'] ?? ''}',
            style: TextStyle(
              fontSize: responsiveFontSize(12, 5, deviceType),
              color: Colors.grey[600],
              fontFamily: 'Gilroy-Light',
            ),
          ),
          SizedBox(height: 12.h),
          ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: deviceType == DeviceType.mobile
                ? Image.asset(
                    csr['mediapath'] ?? '',
                    height: 180.h,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (ctx, err, stack) => Image.asset(
                      'assets/temp/herbs_farms.jpeg',
                      height: 180.h,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  )
                : Align(
                    alignment: Alignment.centerLeft,
                    child: Image.network(
                      csr['mediapath'] ?? '',
                      height: 200.h,
                      fit: BoxFit.contain,
                      errorBuilder: (ctx, err, stack) => Image.asset(
                        'assets/temp/herbs_farms.jpeg',
                        height: 180.h,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
          ),
          SizedBox(height: 12.h),
          Text(
            csr['storydescription'] ?? '',
            style: TextStyle(
              fontSize: responsiveFontSize(14, 7, deviceType),
              fontFamily: 'Gilroy-Light',
            ),
          ),
        ],
      ),
    );
  }

  Widget buildBottomSheetContent(DeviceType deviceType) {
    if (womenEmpowermentList.isEmpty) return const SizedBox();

    final extraCsrs = womenEmpowermentList; // all entries used

    double contentWidth = MediaQuery.of(context).size.width * 0.9;

    return Align(
      alignment: Alignment.center,
      child: Container(
        width: contentWidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (extraCsrs.length >= 2)
              Column(
                children: [
                  eachCSRActivityBasedCard(extraCsrs[0], true, deviceType),
                  if (extraCsrs.length > 1) SizedBox(width: 12.w),
                  if (extraCsrs.length > 1)
                    eachCSRActivityBasedCard(extraCsrs[1], true, deviceType),
                ],
              ),
            SizedBox(height: 20.h),
            for (final csr in extraCsrs.skip(2))
              eachCSRActivityBasedCard(csr, false, deviceType),
          ],
        ),
      ),
    );
  }
}
