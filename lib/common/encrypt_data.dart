import 'package:encrypt/encrypt.dart';
import 'app_strings.dart';

class EncryptData {
//for AES Algorithms

  static String decryptAES({required String value}) {
    try {
      final base64Key = Key.fromUtf8(AppStrings.encryptionSecuredKey);
      final iv = IV.fromLength(16);

      final encrypted = Encrypter(
        AES(base64Key, mode: AESMode.ecb, padding: null),
      );
      final decrypted = encrypted.decrypt(Encrypted.from64(value), iv: iv);

      return decrypted;
    } catch (_) {}
    return '';
  }
}
