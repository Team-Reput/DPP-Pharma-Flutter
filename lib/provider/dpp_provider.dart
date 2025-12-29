import 'dart:convert';
import 'package:dpp_pharma/api/dpp_api_service.dart';
import 'package:flutter/foundation.dart';
import '../models/dpp_models.dart';

class DppProvider extends ChangeNotifier {
  final _api = DppApiService();

  DppResponse? _response;
  bool _loading = false;
  String? _error;

  DppResponse? get response => _response;
  bool get isLoading => _loading;
  String? get error => _error;

  ProductDetails? get product =>
      _response?.data.isNotEmpty == true &&
          _response!.data.first.oDetails.productDetails.isNotEmpty
      ? _response!.data.first.oDetails.productDetails.first
      : null;

  PackagingDetails? get packaging =>
      _response?.data.isNotEmpty == true &&
          _response!.data.first.oDetails.packagingDetails.isNotEmpty
      ? _response!.data.first.oDetails.packagingDetails.first
      : null;

  Future<void> loadDpp({required int brandId, required int batchId}) async {
    _loading = true;
    _error = null;
    notifyListeners();

    try {
      final Map<String, dynamic> map = await _api.fetchDppTabsRaw(
        brandId: brandId,
        batchId: batchId,
      );
      final prettyJson = const JsonEncoder.withIndent('  ').convert(map);
      print('🔓 Decrypted DPP JSON:\n$prettyJson');

      _response = DppResponse.fromJson(map);
    } catch (e) {
      _error = e.toString();
    } finally {
      _loading = false;
      notifyListeners();
    }
  }
}
