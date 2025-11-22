import 'dart:convert';
import 'dart:math';

class PassGenerator {
  static String generate() {
    var random = Random.secure();
    var number = List<int>.generate(32, (i) => random.nextInt(256));
    var randomPass = base64Url.encode(number);
    randomPass = randomPass.replaceAll('+', '')
      .replaceAll('/', '')
      .replaceAll('=', '')
      .substring(0,8);

    return randomPass;
  }
}
