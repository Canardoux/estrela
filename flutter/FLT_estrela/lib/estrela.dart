
import 'dart:async';

import 'package:flutter/services.dart';

class Estrela {
  static const MethodChannel _channel =
      const MethodChannel('estrela');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
