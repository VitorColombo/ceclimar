import 'dart:convert';
import 'dart:math';

class PassGenerator {
  static String generate() {
    var _random = Random.secure();
    var random = List<int>.generate(32, (i) => _random.nextInt(256));
    var randomPass = base64Url.encode(random);
    randomPass = randomPass.replaceAll('+', '')
      .replaceAll('/', '')
      .replaceAll('=', '')
      .substring(0,8);

    return randomPass;
  }
}
