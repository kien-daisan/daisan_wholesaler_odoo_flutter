
import 'package:flutter/material.dart';
import 'package:flutter_project_structure/constants/app_constants.dart';

AppBar commonToolBar(String heading, BuildContext context,
    { bool isElevated = true, bool isLeadingEnable = false}) {
  return AppBar(
    // backgroundColor: Theme.of(context).cardColor,
    leading: isLeadingEnable ? IconButton(onPressed: (){Navigator.pop(context);}, icon: const Icon(Icons.clear)) : null,
    elevation: isElevated ? null : 0,
    title: Text(
      heading,
      // style: Theme.of(context).textTheme.headline3?.copyWith(),
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
    ),
  );
}
