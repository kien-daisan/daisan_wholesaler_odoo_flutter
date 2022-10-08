import 'package:flutter/material.dart';
import 'package:flutter_project_structure/helper/extension.dart';
import 'package:simple_animations/simple_animations.dart';
import 'dart:async';

import '../constants/app_constants.dart';

class AlertMessage {
  static showError(String message, BuildContext context) {
    ToastUtils.showCustomToast(
        context,
        message,
        const Icon(
          Icons.error,
          color: Colors.white,
          size: 40,
        ),
        HexColor.fromHex("BB2124"));
  }

  static showSuccess(String message, BuildContext context) {
    ToastUtils.showCustomToast(
        context,
        message,
        const Icon(Icons.check_circle_outline, color: Colors.white, size: 40),
        HexColor.fromHex("22bb33"));
  }

  static showWarning(String message, BuildContext context) {
    ToastUtils.showCustomToast(
        context,
        message,
        const Icon(Icons.error, color: Colors.white, size: 40),
        HexColor.fromHex("f0ad4e"));
  }
}

class ToastUtils {
  static Timer? toastTimer;
  static OverlayEntry? _overlayEntry;

  static void showCustomToast(
      BuildContext context, String message, Icon icon, Color color) {
    if (!(toastTimer?.isActive ?? false)) {
      toastTimer = null;
    }
    if (toastTimer == null) {
      if (!(toastTimer?.isActive ?? false)) {
        _overlayEntry = createOverlayEntry(context, message, icon, color);
        Overlay.of(context)!.insert(_overlayEntry!);
        toastTimer = Timer(const Duration(seconds: 2), () {
          if (_overlayEntry != null) {
            _overlayEntry?.remove();
          }
        });
      }
    }
  }

  static OverlayEntry createOverlayEntry(
      BuildContext context, String message, Icon icon, Color color) {
    return OverlayEntry(
      builder: (context) => Positioned(
        width: AppSizes.width.toDouble(),
        child: SlideInToastMessageAnimation(Material(
          child: Container(
            padding:
                const EdgeInsets.only(top: 30, bottom: 8, left: 16, right: 8),
            decoration: BoxDecoration(color: color),
            child: Align(
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  icon,
                  const SizedBox(
                    width: 8,
                  ),
                  SizedBox(
                      width: AppSizes.width * 0.8,
                      child: Text(
                        message,
                        softWrap: true,
                        style: Theme.of(context)
                            .textTheme
                            .headline6
                            ?.copyWith(color: AppColors.white),
                      ))
                ],
              ),
            ),
          ),
        )),
      ),
    );
  }
}

class SlideInToastMessageAnimation extends StatelessWidget {
  final Widget child;

  SlideInToastMessageAnimation(this.child);

  @override
  Widget build(BuildContext context) {
    final tween = MultiTween<AnimationType>()
      ..add(
        AnimationType.translateX,
        Tween(begin: -100.0, end: 0.0),
        const Duration(milliseconds: 250),
        Curves.easeOut,
      )
      ..add(
        AnimationType.translateX,
        Tween(begin: 0.0, end: 0.0),
        const Duration(seconds: 1, milliseconds: 250),
      )
      ..add(
        AnimationType.translateX,
        Tween(begin: 0.0, end: -100.0),
        const Duration(milliseconds: 250),
        Curves.easeIn,
      )
      ..add(
        AnimationType.opacity,
        Tween(begin: 0.0, end: 1.0),
        const Duration(milliseconds: 500),
      )
      ..add(
        AnimationType.opacity,
        Tween(begin: 1.0, end: 1.0),
        const Duration(seconds: 1),
      )
      ..add(
        AnimationType.opacity,
        Tween(begin: 1.0, end: 0.0),
        const Duration(milliseconds: 500),
      );

    return PlayAnimation<MultiTweenValues<AnimationType>>(
        duration: tween.duration,
        tween: tween,
        child: child,
        builder: (context, child, animation) {
          return Opacity(
            opacity: animation.get(AnimationType.opacity),
            child: Transform.translate(
                offset: Offset(0, animation.get(AnimationType.translateX)!),
                child: child),
          );
        });
  }
}

enum AnimationType { opacity, translateX }
