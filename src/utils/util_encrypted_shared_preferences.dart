// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// This code is copyrighted - See LICENCE.txt
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

import 'package:encrypt/encrypt.dart';
export 'package:shared_preferences/shared_preferences.dart';

import '/all.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

extension EncryptedSharedPreferences on SharedPreferences {
  //
  //
  //

  Future<bool> setStringSalsa20(String key, String value) {
    // Password = hardcoded password + key.
    final password = Key.fromUtf8("${"YOUR_HARDCODED_PASSWORD_HERE"}$key");
    final encrypter = Encrypter(Salsa20(password));
    final encrypted = encrypter.encrypt(value, iv: IV.fromLength(8));
    return this.setString(key, encrypted.base64);
  }

  //
  //
  //

  String? getStringSalsa20(String key) {
    final raw = this.getString(key);
    if (raw != null) {
      // Password = hardcoded password + key.
      final password = Key.fromUtf8("${"YOUR_HARDCODED_PASSWORD_HERE"}$key");
      final encrypter = Encrypter(Salsa20(password));
      final decrypted = encrypter.decrypt(
        Encrypted.fromBase64(raw),
        iv: IV.fromLength(8),
      );
      return decrypted;
    }
    return null;
  }

  //
  //
  //

  Future<bool> setIntSalsa20(String key, int value) {
    return this.setStringSalsa20(key, value.toString());
  }

  //
  //
  //

  int? getIntSalsa20(String key) {
    final temp = this.getStringSalsa20(key);
    if (temp != null) return int.tryParse(temp);
    return null;
  }

  //
  //
  //

  Future<void> removeAll(List<String> keys) async {
    final all = keys.map((final key) => this.remove(key));
    await Future.wait(all);
  }
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

String specificKey(String key) => "${"YOUR_APP_ID_HERE"}?key=$key";
String specificVersionKey(String key) => "${"YOUR_APP_ID_HERE"}?version=$K_APP_VERSION&key=$key";
