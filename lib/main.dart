import 'dart:io';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_structure/config/theme.dart';
import 'package:flutter_project_structure/constants/app_constants.dart';
import 'package:flutter_project_structure/helper/app_navigation.dart';
import 'package:flutter_project_structure/helper/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_project_structure/helper/app_restart.dart';
import 'package:flutter_project_structure/helper/app_shared_pref.dart';
import 'package:flutter_project_structure/helper/firebase_analytics.dart';
import 'package:get_storage/get_storage.dart';
import 'constants/route_constant.dart';
import 'helper/push_notifications_manager.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  HttpOverrides.global =  MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage().initStorage;
  await AppSharedPref().init();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(AppRestart(child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  static final ValueNotifier<ThemeMode> themeNotifier =
      ValueNotifier(ThemeMode.light);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final FirebaseAnalyticsObserver observer = FirebaseAnalyticsObserver(analytics: FirebaseAnalytics.instance);


  @override
  void initState() {
    PushNotificationsManager().setUpFirebase(context);
    bool? isDarkMode = AppSharedPref().getThemeMode() ?? false;
    print('DarkMode--$isDarkMode');
    setState(() {
      if (isDarkMode == true) {
        MyApp.themeNotifier.value = ThemeMode.dark;
      } else {
        MyApp.themeNotifier.value = ThemeMode.light;
      }
    });
    AnalyticsEventsFirebase().appOpenEvent();

    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    print("FESADEDWE---main${AppSharedPref().getThemeMode()}");
    return ValueListenableBuilder<ThemeMode>(
        valueListenable: MyApp.themeNotifier,
        builder: (BuildContext context, ThemeMode currentMode, __) {
          var string = AppSharedPref().getAppLanguage()?.split("_");

          var selectedLocale = Locale.fromSubtags(
              languageCode: string?[0] ?? "en",
              countryCode: string?[1] ?? "US");
          var isFirst = AppSharedPref().getFirstLang();
          if(isFirst) {
            AppSharedPref().setFirstLang(false);
            if (MyApp.themeNotifier.value == ThemeMode.dark) {
              MyApp.themeNotifier.value = ThemeMode.light;
              currentMode = ThemeMode.light;
            }
            else {
              MyApp.themeNotifier.value = ThemeMode.dark;
              currentMode = ThemeMode.dark;
            }
          }

          return MaterialApp(
              title: 'My Daisan',
              themeMode: currentMode,
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              onGenerateRoute: generateRouteSettings,
              initialRoute: splash,
              navigatorKey: navigatorKey,
              debugShowCheckedModeBanner: false,
              supportedLocales: AppConstant.supportedLanguages.map((e) => e),
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
              ],
              locale: selectedLocale,
              localeResolutionCallback: (locale, supportedLocales) {
                var string = AppSharedPref().getAppLanguage()?.split("_");
                var selectedLocale = Locale.fromSubtags(
                    languageCode: string?[0] ?? "en",
                    countryCode: string?[1] ?? "US");
                if (AppConstant.supportedLanguages.contains(selectedLocale)) {
                  return selectedLocale;
                }
                return supportedLocales.first;
              });
        });
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
