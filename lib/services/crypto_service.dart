import 'dart:convert';
import 'package:cryptography/cryptography.dart';

class CryptoHelper {
  static final _cipher = AesGcm.with128bits();

  static Future<String> decrypt({
    required String encryptedBase64,
    required String ivBase64,
    required String keyString,
  }) async {
    try {
      final keyBytes = utf8.encode(keyString);
      final ivBytes = base64.decode(ivBase64);
      final encryptedBytes = base64.decode(encryptedBase64);

      if (encryptedBytes.length < 16) {
        throw Exception('Encrypted data too short.');
      }

      final cipherTextLength = encryptedBytes.length - 16;
      final cipherText = encryptedBytes.sublist(0, cipherTextLength);
      final macBytes = encryptedBytes.sublist(cipherTextLength);

      final secretKey = SecretKey(keyBytes);
      final secretBox = SecretBox(
        cipherText,
        nonce: ivBytes,
        mac: Mac(macBytes),
      );

      final decryptedBytes = await _cipher.decrypt(
        secretBox,
        secretKey: secretKey,
      );
      return utf8.decode(decryptedBytes);
    } catch (e) {
      // print("❌ Decryption error: $e");
      throw Exception("Decryption failed: $e");
    }
  }
}
