import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../constants/app_constants.dart';
import '../helper/alert_message.dart';
import '../helper/app_localizations.dart';

class Helper {
  static void hideSoftKeyBoard() {
    SystemChannels.textInput.invokeMethod("TextInput.hide");
  }

  Future<String> getFilePath(fileName) async {
    String path = '';
    // var pat_h = await ExtStorage.getExternalStoragePublicDirectory(ExtStorage.DIRECTORY_DOWNLOADS);
    // Directory dir = await getApplicationDocumentsDirectory();
    Directory? dir =  Platform.isAndroid
        ? await getExternalStorageDirectory() //FOR ANDROID
        : await getApplicationDocumentsDirectory(); ;
    path = '${dir?.path}/$fileName';
    return path;
  }

  Future downloadPersonalData(BuildContext context, String fileUrl) async {
      try {
        Dio dio = Dio();
        var status = await Permission.storage.status;
        if (status.isGranted) {
          String fileName = "PersonalData." + "usdz";
          var savePath = await getFilePath(fileName);

          AlertMessage.showSuccess(
              AppLocalizations.of(context)?.translate("downloading") ??
                  "Downloading",
              context);
          await dio.download(fileUrl, savePath,
              onReceiveProgress: (received, total) {
                print("igihgi" +
                    " Download started received" +
                    received.toString() +
                    " total " +
                    total.toString());
              });
          const platform = MethodChannel(AppConstant.channelName);
          try {
            if (Platform.isAndroid) {
              // await platform.invokeMethod('fileviewer', savePath);
            } else {
              await platform.invokeMethod('fileviewer', fileName);
            }
          } on PlatformException catch (e) {
          }
          AlertMessage.showSuccess(
              AppLocalizations.of(context)?.translate("download_complete") ??
                  "Download completed",
              context);
        } else if (status.isDenied) {
          Permission.storage.request();
        }
      } catch (e) {
        print("qwdqwdq" + "exception while downloading invoice " + e.toString());
      }

  }
}