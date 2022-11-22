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

    //   final cipherKey = Key.fromUtf8(AppStrings.encryptionSecuredKey);
    //   final encryptService =
    //       Encrypter(AES(cipherKey, mode: AESMode.cbc)); //Using AES CBC encryption
    //   final initVector = IV.fromUtf8(AppStrings.encryptionSecuredKey.substring(0,
    //       16)); //Here the IV is generated from key. This is for example only. Use some other text or random data as IV for better security.

    //   Encrypted encriptedData = Encrypted.from64(value);

    //   print(encriptedData);

    //   return encryptService.decrypt(encriptedData, iv: initVector);
    // }

    final plainText = "value checking";
    final key = Key.fromUtf8(AppStrings.encryptionSecuredKey);
    final iv = IV.fromLength(16);

    final b64key = Key.fromUtf8(base64Url.encode(key.bytes));
    // if you need to use the ttl feature, you'll need to use APIs in the algorithm itself
    final fernet = Fernet(b64key);
    print(fernet);
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
