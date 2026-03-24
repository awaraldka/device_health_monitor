import 'package:encrypt/encrypt.dart';

class EncryptionService {
  static final _key = Key.fromUtf8('my32charslongsecretkeyforaes256!'); // 32 chars
  static final _iv = IV.fromLength(16); // 16 bytes of zeros
  static final _encrypter = Encrypter(AES(_key, mode: AESMode.cbc));

  static String encrypt(String text) {
    if (text.isEmpty) return '';
    return _encrypter.encrypt(text, iv: _iv).base64;
  }

  static String decrypt(String encryptedText) {
    if (encryptedText.isEmpty) return '';
    try {
      return _encrypter.decrypt64(encryptedText, iv: _iv);
    } catch (e) {
      return 'Decryption Error';
    }
  }

  static String encryptInt(int value) => encrypt(value.toString());
  static String encryptDouble(double value) => encrypt(value.toString());
  static String encryptBool(bool value) => encrypt(value.toString());

  static int decryptInt(String encryptedText) =>
      int.tryParse(decrypt(encryptedText)) ?? 0;
  static double decryptDouble(String encryptedText) =>
      double.tryParse(decrypt(encryptedText)) ?? 0.0;
  static bool decryptBool(String encryptedText) =>
      decrypt(encryptedText).toLowerCase() == 'true';
}
