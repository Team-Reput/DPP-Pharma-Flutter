import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../constants/api_constants.dart';

class DppApiService {
  static const String _key = "0123456789abcdef";
  static String get encryptionKey => _key;

  Future<Map<String, dynamic>> fetchDppTabsRaw({
    required int brandId,
    required int batchId,
  }) async {
    final url = Uri.parse(kGetPharmaDPPResponse);
    final body = jsonEncode({'BrandID': brandId, 'BatchID': batchId});

    final response = await http.post(
      url,
      headers: const {'Content-Type': 'application/json'},
      body: body,
    );

    if (response.statusCode != 200) {
      throw Exception('DPP API failed with code ${response.statusCode}');
    }

    final Map<String, dynamic> jsonBody = jsonDecode(response.body);
    final prettyJson = const JsonEncoder.withIndent('  ').convert(jsonBody);
    print('🔓 Brand ID: $brandId');
    print('🔓 Batch ID: $batchId');
    // print('🔓 Decrypted DPP JSON:\n$prettyJson');

    return jsonBody;
  }
}
