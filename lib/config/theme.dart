import 'package:flutter/material.dart';

class MobikulTheme {
  static const Color primaryColor = Color(0xFFFFFFFF);
  static const Color accentColor = Color(0xFF000000);

  static const Color lightGrey = Color(0xffe8e5e5);
  static const Color lightGreyTest = Color(0xfff7f7f7);
}

class DSTheme {
  static const TextStyle lightTextPrice = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 20,
      color: Colors.red,
      fontFamily: "Roboto"
  );
}

class AppTheme {
  AppTheme._();

  static final Color _iconColor = Colors.blueAccent.shade200;

  static const Color _lightPrimaryColor = Colors.white24;
  static const Color _lightPrimaryVariantColor = MobikulTheme.primaryColor;
  static const Color _lightSecondaryColor = Colors.green;
  static const Color _lightOnPrimaryColor = Colors.black;

  static const Color _darkPrimaryColor = Colors.white24;
  static const Color _darkPrimaryVariantColor = Colors.black;
  static const Color _darkSecondaryColor = Colors.white;
  static const Color _darkOnPrimaryColor = Colors.white;

  static final ThemeData lightTheme = ThemeData(
      appBarTheme: const AppBarTheme(
        actionsIconTheme: IconThemeData(
            color: Colors.white,
        ),
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontFamily: "Roboto",
          fontWeight: FontWeight.bold,),
        color: Color(0xFF1976D2),

        iconTheme: IconThemeData(color: Colors.white,),
      ),
      textSelectionTheme: const TextSelectionThemeData(selectionColor: Colors.green, cursorColor: Colors.green),
      colorScheme: const ColorScheme.light(
        primary: _lightPrimaryColor,
        secondaryContainer: _lightPrimaryVariantColor,
        // primaryVariant: _lightPrimaryVariantColor,
        secondary: _lightSecondaryColor,
        onPrimary: Color(0xFF212121),
      ),
      iconTheme: const IconThemeData(
        color: _lightOnPrimaryColor,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: _lightOnPrimaryColor),
      textTheme: _lightTextTheme,
      dividerTheme: const DividerThemeData(color: Colors.black12),
      bottomAppBarTheme: const BottomAppBarTheme(color: Color(0xFF2A65B3),));

  static final ThemeData darkTheme = ThemeData(
      scaffoldBackgroundColor: _darkPrimaryVariantColor,
      appBarTheme: const AppBarTheme(
        actionsIconTheme: IconThemeData(
          color: Colors.white,

        ),
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontFamily: "Roboto",
          fontWeight: FontWeight.bold,),
        color: Color(0xFF10069f),

        iconTheme: IconThemeData(color: Colors.white,),
      ),
      colorScheme: const ColorScheme.dark(
        primary: _darkPrimaryColor,
        secondaryContainer: _darkPrimaryVariantColor,
        // primaryVariant: _darkPrimaryVariantColor,
        secondary: _darkSecondaryColor,
        onPrimary: _darkOnPrimaryColor,
        background: Colors.white12,
      ),
      iconTheme: IconThemeData(
        color: _darkOnPrimaryColor,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: _darkOnPrimaryColor),
      textTheme: _darkTextTheme,
      dividerTheme: const DividerThemeData(color: Colors.black),
      bottomAppBarTheme: const BottomAppBarTheme(color: _darkOnPrimaryColor));

  static const TextTheme _lightTextTheme = TextTheme(
    headline1: _lightScreenHeading1TextStyle,
    headline2: _lightScreenHeading2TextStyle,
    headline3: _lightScreenHeading3TextStyle,
    headline4: _lightScreenHeading4TextStyle,
    headline5: _lightScreenHeading5TextStyle,
    headline6: _lightScreenHeading6TextStyle,
    subtitle1: _lightScreenSubTile1TextStyle,
    subtitle2: _lightScreenSubTile2TextStyle,
    bodyText1: _lightScreenTaskNameTextStyle,
    bodyText2: _lightScreenTaskDurationTextStyle,
  );

  static final TextTheme _darkTextTheme = TextTheme(
    headline1: _darkScreenHeading1TextStyle,
    headline2: _darkScreenHeading2TextStyle,
    headline3: _darkScreenHeading3TextStyle,
    headline4: _darkScreenHeading4TextStyle,
    headline5: _darkScreenHeading5TextStyle,
    headline6: _darkScreenHeading6TextStyle,
    subtitle1: _darkScreenSubTile1TextStyle,
    subtitle2: _darkScreenSubTile2TextStyle,
    bodyText1: _darkScreenTaskNameTextStyle,
    bodyText2: _darkScreenTaskDurationTextStyle
  );

  static const TextStyle _lightScreenHeading1TextStyle = TextStyle(
      fontSize: 26.0,
      fontWeight: FontWeight.bold,
      color: _lightOnPrimaryColor,
      fontFamily: "Roboto");

  static const TextStyle _lightScreenHeading2TextStyle = TextStyle(
      fontSize: 22.0,
      fontWeight: FontWeight.bold,
      color: _lightOnPrimaryColor,
      fontFamily: "Roboto");

  static const TextStyle _lightScreenHeading3TextStyle = TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
      color: _lightOnPrimaryColor,
      fontFamily: "Roboto");

  static const TextStyle _lightScreenHeading4TextStyle = TextStyle(
      fontSize: 18.0,
      // fontWeight: FontWeight.bold,
      color: _lightOnPrimaryColor,
      fontFamily: "Roboto");

  static const TextStyle _lightScreenHeading5TextStyle = TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w500,
      color: _lightOnPrimaryColor,
      fontFamily: "Roboto");

  static const TextStyle _lightScreenHeading6TextStyle = TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.bold,
      color: _lightOnPrimaryColor,
      fontFamily: "Roboto");

  static const TextStyle _lightScreenTaskNameTextStyle = TextStyle(
      fontSize: 14.0, color: _lightOnPrimaryColor, fontFamily: "Roboto");

  static const TextStyle _lightScreenTaskDurationTextStyle = TextStyle(
      fontSize: 12.0, color: _lightOnPrimaryColor, fontFamily: "Roboto");

  static const TextStyle _lightScreenSubTile1TextStyle =
  TextStyle(fontSize: 20.0, color: Colors.grey, fontFamily: "Roboto");

  static const TextStyle _lightScreenSubTile2TextStyle =
  TextStyle(fontSize: 16.0, color: Colors.grey, fontFamily: "Roboto");

  static final TextStyle _darkScreenHeading1TextStyle =
  _lightScreenHeading1TextStyle.copyWith(color: _darkOnPrimaryColor);

  static final TextStyle _darkScreenHeading2TextStyle =
  _lightScreenHeading2TextStyle.copyWith(color: _darkOnPrimaryColor);

  static final TextStyle _darkScreenHeading3TextStyle =
  _lightScreenHeading3TextStyle.copyWith(color: _darkOnPrimaryColor);

  static final TextStyle _darkScreenHeading4TextStyle =
  _lightScreenHeading4TextStyle.copyWith(color: _darkOnPrimaryColor);

  static final TextStyle _darkScreenHeading5TextStyle =
  _lightScreenHeading5TextStyle.copyWith(color: _darkOnPrimaryColor);

  static final TextStyle _darkScreenHeading6TextStyle =
  _lightScreenHeading6TextStyle.copyWith(color: _darkOnPrimaryColor);

  static final TextStyle _darkScreenTaskNameTextStyle =
  _lightScreenTaskNameTextStyle.copyWith(color: _darkOnPrimaryColor);

  static final TextStyle _darkScreenTaskDurationTextStyle =
  _lightScreenTaskDurationTextStyle.copyWith(color: _darkOnPrimaryColor);

  static const TextStyle _darkScreenSubTile1TextStyle =
      _lightScreenSubTile1TextStyle;

  static const TextStyle _darkScreenSubTile2TextStyle =
      _lightScreenSubTile2TextStyle;

  static const TextStyle smallBoldText = TextStyle(
      fontSize: 12.0, fontWeight: FontWeight.bold, fontFamily: "Roboto");
}
