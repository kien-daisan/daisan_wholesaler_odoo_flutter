import 'package:flutter/material.dart';

class ApiConstant {
  static const String baseUrl = 'https://my.daisan.vn/';
  static const String baseData = "fG6W-0Lp8-5cd7-cJK4-ad6a-z1q0:fG6W-0Lp8-5cd7-cJK4-ad6a-z1q0";
}

class AppConstant {
  static const String appDocPath = "";
  static const List<Locale> supportedLanguages = [
    Locale.fromSubtags(languageCode: 'en', countryCode: 'US'),
    Locale.fromSubtags(languageCode: 'ar', countryCode: 'SY'),
    Locale.fromSubtags(languageCode: 'es', countryCode: 'ES'),
    Locale.fromSubtags(languageCode: 'es', countryCode: 'CO'),
    Locale.fromSubtags(languageCode: 'fr', countryCode: 'FR'),
    Locale.fromSubtags(languageCode: 'vi', countryCode: 'VN'),

  ];
  static const String productTypeNotification = "product";
  static const String categoryTypeNotification = "category";
  static const String customTypeNotification = "custom";
  static const String googleKey = "AIzaSyDC-fhKsECxRbY9JzBpCg3LDeANys4-Zgs";

  //=======App Keys Constants=======//
  static const productDefault = "default";
  static const productFixed = "fixed";
  static const demoEmail = "";
  static const demoPassword = "";
  static const deactivateTemporary ="temporary";
  static const deactivatePermanent = "permanent";
  static const bannerImage = 'banner';
  static const profileImage = "image";
  static const userBannerImage = "bannerImage";
  static const sku = "sku";

  //========Product Variant Types======//
  static const radioType = "radio";
  static const colorType = "color";

  //======Method Channel Name=====//
static const channelName= "com.oddo.flutter/channel";

//=============Search Type Image/Text==========//
static const imageSearch = "ImageSearch";
static const textSearch = "TextSearch";
}

class AppSizes {
  static const int splashScreenTitleFontSize = 48;
  static const int titleFontSize = 34;
  static const double sidePadding = 15;
  static const double widgetSidePadding = 20;
  static const double buttonRadius = 25;
  static const double imageRadius = 8;
  static const double linePadding = 4;
  static const double widgetBorderRadius = 34;
  static const double textFieldRadius = 4.0;
  static const double genericPadding = 16.0;
  static const double iconButtonBorderRadius = 24;
  static const double itemHeight = 45;
  static double height = MediaQueryData.fromWindow(WidgetsBinding.instance!.window).size.height;
  static double width = MediaQueryData.fromWindow(WidgetsBinding.instance!.window).size.width;
  static const EdgeInsets bottomSheetPadding =
      EdgeInsets.symmetric(horizontal: 16, vertical: 10);
  static const app_bar_size = 56.0;
  static const app_bar_expanded_size = 180.0;
  static const double normalPadding = 8.0;
  static const double mediumPadding = 12.0;
  static const double extraPadding = 16.0;
}

class TextSizes {
  static const double mediumTextSize = 20;
  static const double textSize18 = 18;
  static const double textSizeNormal = 16;
}

class AppColors {
  static const red = Color(0xFFDB3022);
  static const lightRed = Color(0xFFF65F53);
  static const textBlue = Color(0xFF1A4391);
  static const black = Color(0xFF222222);
  static const lightGray = Color(0xFF9B9B9B);
  static const darkGray = Color(0xFF615959);
  static const white = Color(0xFFFFFFFF);
  static const orange = Color(0xFFFFBA49);
  static const background = Color(0xFFE5E5E5);
  static const backgroundLight = Color(0xFFF9F9F9);
  static const transparent = Color(0x00000000);
  static const success = Color(0xFF2AA952);
  static const green = Color(0xFF2AA952);
  static const yellow = Color(0xFFEA9301);
  static const blue = Color(0xFF3D79EC);
  static const lightBlue = Color(0xCFD9D0F6);
}
