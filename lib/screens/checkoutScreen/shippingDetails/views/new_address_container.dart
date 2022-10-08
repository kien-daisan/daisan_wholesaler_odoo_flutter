
import 'package:flutter/material.dart';
import 'package:flutter_project_structure/constants/app_constants.dart';

Widget addNewAddress(BuildContext context,String title, VoidCallback callback, ){
  return Padding(
    padding:  const EdgeInsets.all( AppSizes.imageRadius),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
            flex: 1,
            child: InkWell(
              onTap: callback,
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                 const Icon(
                    Icons.add,
                    size: 22,
                  ),
                  const SizedBox(
                    width: AppSizes.linePadding ,
                  ),
                  Text(title .toUpperCase(),
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(
                          fontSize: 12, fontWeight: FontWeight.bold))
                ],
              ),
            )),

      ],
    ),
  );
}