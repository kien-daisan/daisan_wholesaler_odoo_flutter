import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'app_shared_pref.dart';

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}

//============================Manage Email and cart count=====================//
void checkCartAndEmailVerification(Response response){
  try {
    var map = response.data as Map<String, dynamic>;
    var count = map["cartCount"];
    var isEmailVerified = map["is_email_verified"];
    if (AppSharedPref().getUserData() != null) {
      var userData = AppSharedPref().getUserData();
      if (count != null) {
        userData?.cartCount = count;
      }
      if (isEmailVerified != null) {
        userData?.isEmailVerified = isEmailVerified;
      }
      AppSharedPref().setUserData(userData);
    }
  } catch (e) {
    print(e.toString());
  }
}
//============================================================//
