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

    // final plainText = "value checking";
    // final key = Key.fromUtf8(AppStrings.encryptionSecuredKey);
    // final iv = IV.fromLength(16);
    //
    // final b64key = Key.fromUtf8(base64Url.encode(key.bytes));
    // // if you need to use the ttl feature, you'll need to use APIs in the algorithm itself
    // final fernet = Fernet(b64key);
    // print(fernet);
    // final encrypter = Encrypter(fernet);
    //
    // final encrypted = encrypter.encrypt(plainText);
    // final decrypted = encrypter.decrypt(encrypted);
    //
    // print(decrypted); // Lorem ipsum dolor sit amet, consectetur adipiscing elit
    // print(encrypted.base64); // random cipher text
    // print(fernet.extractTimestamp(encrypted.bytes));
    // print('ValueIS:---  $decrypted');
    // print('ValueIS:---  ${encrypted.base64}');
    // print('ValueIS:---  ${fernet.extractTimestamp(encrypted.bytes)}');

    const plainText = "4567@test.com";
    String credentials = "username:password";
    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    String encoded = stringToBase64.encode('4567@test.com');      // dXNlcm5hbWU6cGFzc3dvcmQ=
    String decoded = stringToBase64.decode('xWelMdVI9kuwiaoQA5Gqxg==');



    print('Plain text for encryption: $encoded  \n  $decoded');
    //
    // //Encrypt
    // Encrypted encrypted = encryptWithAES(AppStrings.encryptionSecuredKey, plainText);
    // String encryptedBase64 = encrypted.base64;
    // print('Encrypted data in base64 encoding: $encryptedBase64');
    //
    // //Decrypt
    // String decryptedText = decryptWithAES(AppStrings.encryptionSecuredKey, encrypted);
    // print('Decrypted data: $decryptedText');

    return '';
  }

  ///Accepts encrypted data and decrypt it. Returns plain text
  static String decryptWithAES(String key, Encrypted encryptedData) {
    final cipherKey = Key.fromUtf8(key);
    final encryptService = Encrypter(AES(cipherKey, mode: AESMode.cbc)); //Using AES CBC encryption
    final initVector = IV.fromUtf8(key.substring(0, 16)); //Here the IV is generated from key. This is for example only. Use some other text or random data as IV for better security.

    return encryptService.decrypt(encryptedData, iv: initVector);
  }

  ///Encrypts the given plainText using the key. Returns encrypted data
  static Encrypted encryptWithAES(String key, String plainText) {
    final cipherKey = Key.fromUtf8(key);
    final encryptService = Encrypter(AES(cipherKey, mode: AESMode.cbc));
    final initVector = IV.fromUtf8(key.substring(0, 16)); //Here the IV is generated from key. This is for example only. Use some other text or random data as IV for better security.

    Encrypted encryptedData = encryptService.encrypt(plainText, iv: initVector);
    return encryptedData;
  }

}
