import 'dart:convert';

import 'package:encrypt/encrypt.dart';
import 'app_strings.dart';

class EncryptData {
//for AES Algorithms

  static Encrypted encryptAES(plainText) {
    final key = Key.fromUtf8(AppStrings.encryptionSecuredKey);
    final iv = IV.fromLength(16);
    final encryptor = Encrypter(AES(key));
    return encryptor.encrypt(plainText, iv: iv);
  }

  static String decryptAES({required String value}) {
    // final key = Key.fromUtf8(AppStrings.encryptionSecuredKey);
    // final iv = IV.fromLength(16);
    // final encryptor = Encrypter(AES(key));
    // Encrypted encrypted = Encrypted(const Utf8Encoder().convert(value));
    // return encryptor.decrypt(encrypted, iv: iv);


    final plainText = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit';
    final key = Key.fromUtf8(AppStrings.encryptionSecuredKey);
    final iv = IV.fromLength(16);

    final b64key = Key.fromUtf8(base64Url.encode(key.bytes));
    // if you need to use the ttl feature, you'll need to use APIs in the algorithm itself
    final fernet = Fernet(b64key);
    final encrypter = Encrypter(fernet);

    final encrypted = encrypter.encrypt(plainText);
    final decrypted = encrypter.decrypt(encrypted);

    print(decrypted); // Lorem ipsum dolor sit amet, consectetur adipiscing elit
    print(encrypted.base64); // random cipher text
    print(fernet.extractTimestamp(encrypted.bytes));
    print('ValueIS:---  $decrypted');
    print('ValueIS:---  ${encrypted.base64}');
    print('ValueIS:---  ${fernet.extractTimestamp(encrypted.bytes)}');
    return '';
  }
}
