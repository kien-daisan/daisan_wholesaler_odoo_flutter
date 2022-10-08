import 'package:flutter/material.dart';
import 'package:flutter_project_structure/constants/app_constants.dart';

Widget commonButton(BuildContext context, VoidCallback onPressed, String text,
    {double? width,
      double? height,
      Color? textColor,
      Color? backgroundColor,
      Color? borderSideColor,
      double borderRadius = 4,
      TextAlign? textAlign
    }) {
  borderSideColor ??= Theme.of(context).colorScheme.onPrimary;
  return OutlinedButton(
    onPressed: onPressed,
    child: Text(
      text,
      textAlign: textAlign,
      style: Theme.of(context).textTheme.headline6?.copyWith(color: textColor??Theme.of(context).colorScheme.onPrimary),     ),
    style: OutlinedButton.styleFrom(
        side: BorderSide(
          color: borderSideColor,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(borderRadius))),
        minimumSize: Size((width != null) ? width : AppSizes.width,
            (height != null) ? height : AppSizes.height / 16),
        backgroundColor: backgroundColor),
  );
}
