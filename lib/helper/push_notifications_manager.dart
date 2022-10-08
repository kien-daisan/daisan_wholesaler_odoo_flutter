import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_project_structure/constants/app_constants.dart';
import 'package:flutter_project_structure/helper/app_shared_pref.dart';
import '../constants/arguments_map.dart';
import '../constants/route_constant.dart';
import '../main.dart';

class PushNotificationsManager {
  static final FirebaseMessaging _firebaseMessaging =
      FirebaseMessaging.instance;
  static final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  static const initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  static const initializationSettingsIOS = IOSInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestSoundPermission: true,
  );

  final InitializationSettings initializationSettings =
      const InitializationSettings(
          android: initializationSettingsAndroid,
          iOS: initializationSettingsIOS);

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  void setUpFirebase(BuildContext context) {
    FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(alert: true, badge: true, sound: true);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String? payload) async {
      if (payload?.isNotEmpty ?? false) {
        print("payload" + payload.toString());
        Map notificationModelMap = json.decode(payload.toString());
        if (notificationModelMap['type'] ==
            AppConstant.productTypeNotification) {
          Navigator.pushNamed(navigatorKey.currentContext!, productPage,
              arguments: getProductDataMap(
                  notificationModelMap['name'], notificationModelMap['id']));
        } else if (notificationModelMap['type'] ==
            AppConstant.categoryTypeNotification) {
          Navigator.pushNamed(navigatorKey.currentContext!, catalogPage,
              arguments: getCatalogMap(
                "",
                false,
                notificationModelMap['name'],
                customerId: int.parse(notificationModelMap['id']),
              ));
        } else if (notificationModelMap['type'] ==
            AppConstant.customTypeNotification) {
          Navigator.pushNamed(navigatorKey.currentContext!, catalogPage,
              arguments: getCatalogMap("", false, "Catalog",
                  fromNotification: true,
                  domain: notificationModelMap['domain']));
        }
      }
    });
    _firebaseCloudMessagingListeners(context);
  }

  Future<StyleInformation?> getNotificationStyle(String? image) async {
    if (image != null) {
      final ByteData imageData =
          await NetworkAssetBundle(Uri.parse(image)).load("");
      return BigPictureStyleInformation(
          ByteArrayAndroidBitmap(imageData.buffer.asUint8List()));
    } else {
      return null;
    }
  }

  void showNotification(
      String title, String body, String? payload, String? image) async {
    var notificationStyle = await getNotificationStyle(image);
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        '${Random().nextDouble()}', 'Odoo Notification',
        importance: Importance.max,
        priority: Priority.max,
        playSound: true,
        styleInformation: notificationStyle);

    var iOSPlatformChannelSpecifics = const IOSNotificationDetails(
      presentAlert: true,
      presentSound: true,
      presentBadge: true,
    );

    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    flutterLocalNotificationsPlugin
        .show(0, title, body, platformChannelSpecifics, payload: payload);
  }

  Future<String?> createFcmToken() async {
    return _firebaseMessaging.getToken();
  }

  void _firebaseCloudMessagingListeners(BuildContext context) async {
    if (Platform.isIOS) _iosPermission();

    createFcmToken();

    if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      print("deviceId${iosInfo.identifierForVendor}");
      AppSharedPref().setDeviceID(iosInfo.identifierForVendor.toString());
    } else {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      print("deviceId${androidInfo.androidId}");
      AppSharedPref().setDeviceID(androidInfo.androidId.toString());
    }

    // _firebaseMessaging.subscribeToTopic("topic");

    //When app is in Working state
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      RemoteNotification? notification = message.notification;
      print('on message ${message.data}');
      print("onMessageNotification${message.notification?.body}");
      String? title = notification?.title;
      String? body = notification?.body;
      String? imageUrl = "";
      if (Platform.isAndroid) {
        imageUrl = message.notification?.android?.imageUrl;
      } else {
        imageUrl = message.notification?.apple?.imageUrl;
      }
      showNotification(title!, body!, json.encode(message.data), imageUrl);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("OnAppOpened}");
      print(message.data);
      if (message.data['type'] == "product") {
        print("product");
        Navigator.pushNamed(navigatorKey.currentContext!, productPage,
            arguments:
                getProductDataMap(message.data['name'], message.data['id']));
      } else if (message.data['type'] == "category") {
        Navigator.pushNamed(navigatorKey.currentContext!, catalogPage,
            arguments: getCatalogMap(
              "",
              false,
              message.data['name'],
              customerId: int.parse(message.data['id']),
            ));
      } else if (message.data['type'] == AppConstant.customTypeNotification) {
        Navigator.pushNamed(navigatorKey.currentContext!, catalogPage,
            arguments: getCatalogMap(
                "", false, message.notification?.title ?? "",
                fromNotification: true, domain: message.data['domain']));
      }
    });
  }

  void checkInitialMessage(BuildContext context) {
    _firebaseMessaging.getInitialMessage().then((RemoteMessage? message) {
      print("open app data");
      print(message?.data);
      if (message?.data != null) {
        if (message?.data['type'] == "product") {
          Navigator.pushNamed(context, productPage,
              arguments: getProductDataMap(
                  message?.data['name'], message?.data['id']));
        } else if (message?.data['type'] == "category") {
          Navigator.pushNamed(context, catalogPage,
              arguments: getCatalogMap(
                "",
                false,
                message?.data['name'],
                customerId: int.parse(message?.data['id']),
              ));
        } else if (message?.data['type'] ==
            AppConstant.customTypeNotification) {
          Navigator.pushNamed(navigatorKey.currentContext!, catalogPage,
              arguments: getCatalogMap(
                  "", false, message?.notification?.title ?? "",
                  fromNotification: true, domain: message?.data['domain']));
        }
      }
    });
  }

  void _iosPermission() {
    _firebaseMessaging
        .requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    )
        .then((value) {
      print("Settings registered: $value");
    });
  }
}
