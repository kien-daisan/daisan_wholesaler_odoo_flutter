import 'package:flutter/material.dart';
import 'package:flutter_project_structure/constants/app_constants.dart';
import 'package:lottie/lottie.dart';

Widget lottieAnimation( BuildContext context, String lottiePath,String title,String subtitle,
  String buttonTitle, VoidCallback? callback
 ) {
  return Center(
    child: SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Card(
        elevation: 0,
        child: Container(
          // height: AppSizes.height / 2,
          width: AppSizes.width - 50,
          decoration: BoxDecoration(
            border: Border.all(width: 1.0, color: Theme.of(context).colorScheme.secondaryContainer),
          ),
          child: Column(children: [
            Lottie.asset(lottiePath,
                width: AppSizes.width / 2,
                height: AppSizes.height / 3.5,
                fit: BoxFit.fill,
                repeat: false
            ),
            Text(title,
                style: Theme.of(context).textTheme.headline3),
             Padding(
                padding: const EdgeInsets.all(AppSizes.mediumPadding),
                child: Text(subtitle,
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(fontWeight: FontWeight.normal),
                ),
            ),
            // Text(subtitle,
            //   style: Theme.of(context).textTheme.bodyText1?.copyWith(fontWeight: FontWeight.normal),
            // ),
            // const Padding(padding: EdgeInsets.all(AppSizes.imageRadius)),
            ElevatedButton(
                onPressed: callback,
                style: ElevatedButton.styleFrom(primary: AppColors.black),
                child: Text(
                  buttonTitle,
                  style: const TextStyle(color: AppColors.white),
                ))
          ]),
        ),
      ),
    ),
  );
}


