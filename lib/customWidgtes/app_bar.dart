import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

AppBar commonAppBar(String heading, BuildContext context,
    {bool isHomeEnable = false,
    bool isElevated = true,
    bool isLeadingEnable = false,
    List<Widget>? actions,
    VoidCallback? onPressed}) {
  return AppBar(
    // backgroundColor: Theme.of(context).cardColor,
      leading: isLeadingEnable
          ? IconButton(
              onPressed: () {
                onPressed!();
              },
              icon: const Icon(Icons.clear))
          : null,
      elevation: isElevated ? null : 0,
      title: Wrap(
        children: [
          if (isHomeEnable)
            SizedBox(
              height: AppBar().preferredSize.height / 2,
              width: AppBar().preferredSize.height / 2,
              child: Image.asset(
                'lib/assets/images/appIcon.png',
                fit: BoxFit.fill,
              ),
            ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: isHomeEnable ? AppSizes.imageRadius : 0),
            child: Text(
              heading,
              // style: Theme.of(context).textTheme.headline3,
            ),
          ),
        ],
      ),
      actions: actions);
}
