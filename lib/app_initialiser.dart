import 'dart:convert';

import 'package:dpp_pharma/api/dpp_api_service.dart';
import 'package:dpp_pharma/constants/crypto_utils.dart';
import 'package:dpp_pharma/constants/splash_icons.dart';
import 'package:dpp_pharma/provider/dpp_provider.dart';
import 'package:dpp_pharma/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class AppInitializer extends StatefulWidget {
  const AppInitializer({super.key});

  @override
  State<AppInitializer> createState() => _AppInitializerState();
}

class _AppInitializerState extends State<AppInitializer> {
  bool _isLoading = true;
  String? _error;

  final DppApiService _apiService = DppApiService();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Optional splash delay
      Future.delayed(const Duration(seconds: 2), () {
        _extractParamsAndFetchDataForProduction();
        // _extractParamsAndFetchDataForDevelopment();
      });
    });
  }

  Future<void> _extractParamsAndFetchDataForDevelopment() async {
    try {
      final uri = Uri.parse(
        'http://pharma-dpp-dev.eba-hdp3gcht.ap-south-1.elasticbeanstalk.com/?data=15gKW6aLXsbpl3mCfGEZJXVNJ07ECYdNZ5TYEv8YqDIrvaRhTgT3v4w41y3GuA%3D%3D&iv=e1wll0vIDNJPUov2',
        // 'http://pharma-dpp-dev.eba-hdp3gcht.ap-south-1.elasticbeanstalk.com/?data=gxo%2F%2F9nzPcwxYEohBzFayedfUYfKCrFQQQEpZG91JaYF6q%2F8ADa8QKyip9Dao6IzQ9Kp%2Fb5LXCYw9Q%3D%3D&iv=AmcD9gGoeRm3S4Qv',
        //  'http://pharma-dpp-dev.eba-hdp3gcht.ap-south-1.elasticbeanstalk.com/?data=3zRqLSSVYGqOOqJUz2DcCEEUqRGwqnEeBbhavf%2F0XZAj6UKQZkugZtKKLgJYjA%3D%3D&iv=dC4FvjsvxBjBnI%2Fq',
      );
      final encryptedData = uri.queryParameters['data'];
      final iv = uri.queryParameters['iv'];

      if (encryptedData == null || iv == null) {
        _fail('Missing data or iv in dev URL');
        return;
      }

      await _decryptAndFetchData(encryptedData, iv);
    } catch (e) {
      _fail('Dev init error: $e');
    }
  }

  Future<void> _extractParamsAndFetchDataForProduction() async {
    try {
      final uri = Uri.base; // current web URL
      final encryptedData = uri.queryParameters['data'];
      final iv = uri.queryParameters['iv'];

      if (encryptedData == null || iv == null) {
        _fail('Missing data or iv in URL');
        return;
      }

      await _decryptAndFetchData(encryptedData, iv);
    } catch (e) {
      _fail('Init error: $e');
    }
  }

  Future<void> _decryptAndFetchData(String encryptedData, String iv) async {
    try {
      final decryptedText = await CryptoHelper.decrypt(
        encryptedBase64: encryptedData,
        ivBase64: iv,
        keyString: DppApiService.encryptionKey,
      );

      final decodedData = json.decode(decryptedText);

      final brandId = decodedData['BrandID'];
      final batchId = decodedData['BatchID'];
      final templateId = decodedData['TemplateID'] ?? 2;

      if (brandId == null || batchId == null) {
        _fail('BrandID or BatchID missing in decrypted payload');
        return;
      }

      final provider = Provider.of<DppProvider>(context, listen: false);
      provider.setIds(brandId: brandId as int, batchId: batchId as int);
      provider.setTemplateId(templateId as int);

      await _fetchAndStoreDecryptedTabs(
        brandId: brandId as int,
        batchId: batchId as int,
      );

      setState(() => _isLoading = false);
    } catch (e) {
      _fail('Error during decryption: $e');
    }
  }

  Future<void> _fetchAndStoreDecryptedTabs({
    required int brandId,
    required int batchId,
  }) async {
    try {
      final result = await _apiService.fetchDppTabsRaw(
        brandId: brandId,
        batchId: batchId,
      );

      final provider = Provider.of<DppProvider>(context, listen: false);
      provider.setDecryptedData(result);

      // Optional pretty log
      // final prettyJson = const JsonEncoder.withIndent('  ').convert(result);
      // print("🔓 Decrypted Data from POST:\n$prettyJson");
    } catch (e) {
      _fail('Error fetching DPP tabs: $e');
    }
  }

  void _fail(String message) {
    debugPrint(message);
    setState(() {
      _error = message;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(color: Colors.black),
              SizedBox(height: 16.h),
              Text(
                '®Powered by RePut.ai',
                style: TextStyle(
                  fontFamily: 'Gilroy-Light',
                  fontSize: 20.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      );
    }

    if (_error != null) {
      return Scaffold(
        body: Center(
          child: Text(
            "Initialization error:\n$_error",
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.red,
              fontFamily: 'Gilroy-Light',
            ),
          ),
        ),
      );
    }

    // Ready: DppProvider now has brandId, batchId, templateId, decryptedData
    return SplashScreen(
      dynamicIconPaths: splashIcons,
      batchID: Provider.of<DppProvider>(context, listen: false).batchId!,
      brandID: Provider.of<DppProvider>(context, listen: false).brandId!,
    );
  }
}
