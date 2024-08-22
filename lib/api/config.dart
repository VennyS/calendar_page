import 'dart:convert';
import 'package:flutter/services.dart';

class Config {
  static late String baseUrl;

  static Future<void> load() async {
    final String response = await rootBundle.loadString('assets/config.json');
    final data = await json.decode(response);
    baseUrl = data['baseUrl'];
  }
}
