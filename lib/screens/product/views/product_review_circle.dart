// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:flutter_project_structure/constants/app_constants.dart';
import 'package:flutter_project_structure/constants/app_string_constant.dart';
import 'package:flutter_project_structure/helper/app_localizations.dart';

class ProductReviewCircle extends StatefulWidget {
  const ProductReviewCircle({Key? key}) : super(key: key);

  @override
  _ProductReviewCircleState createState() => _ProductReviewCircleState();
}

class _ProductReviewCircleState extends State<ProductReviewCircle> {
  AppLocalizations? _localizations;

  @override
  void didChangeDependencies() {
    _localizations = AppLocalizations.of(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
        alignment: Alignment.center,
        children: [
      Center(
        child: CustomPaint(
          painter: OpenPainter(
              oneRating: 2.0,
              twoRating: 5.0,
              threeRating: 5.0,
              fourRating: 2.0,
              fiveRating: 7.0),
        ),
      ),
      Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [ ratingStar(_localizations?.translate(AppStringConstant.one) ?? '', AppColors.red),
            ratingStar(_localizations?.translate(AppStringConstant.two) ?? '', AppColors.lightRed),
            ratingStar(_localizations?.translate(AppStringConstant.three) ?? '', AppColors.yellow),
          ],),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [ratingStar(_localizations?.translate(AppStringConstant.four) ?? '', AppColors.orange),
            ratingStar(_localizations?.translate(AppStringConstant.five) ?? '', AppColors.green),
          ],),
        ],
      )
    ]);
  }

  Widget ratingStar(String rating, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: (AppSizes.linePadding),vertical: (AppSizes.linePadding/2)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(rating, style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 10),),
        Icon(Icons.star, color: color,size: 10,)
      ],
    ));
  }
}

class OpenPainter extends CustomPainter {
  final oneRating;
  final twoRating;
  final threeRating;
  final fourRating;
  final fiveRating;
  double pi = math.pi;

  OpenPainter(
      {this.oneRating,
      this.threeRating,
      this.twoRating,
      this.fiveRating,
      this.fourRating});

  @override
  void paint(Canvas canvas, Size size) {
    double strokeWidth = 7;
    Rect myRect =  Offset(-(AppSizes.width / 7.4), -(AppSizes.width / 7.4)) &
        Size(AppSizes.width / 3.5, AppSizes.width / 3.5);

    var paint1 = Paint()
      ..color = AppColors.red
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;
    var paint2 = Paint()
      ..color = AppColors.yellow
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;
    var paint3 = Paint()
      ..color = AppColors.green
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    double firstLineRadianStart = 0;
    double totalRating =
        (oneRating + twoRating + threeRating + fourRating + fiveRating);
    double _badReview = (oneRating + twoRating) / totalRating;
    double firstLineRadianEnd = getRadians(_badReview);
    canvas.drawArc(
        myRect, firstLineRadianStart, firstLineRadianEnd, false, paint1);
    double goodReview = (threeRating + fourRating) / totalRating;
    double secondLineRadianEnd = getRadians(goodReview);
    canvas.drawArc(
        myRect, firstLineRadianEnd, secondLineRadianEnd, false, paint2);
    double excellent = (fiveRating) / totalRating;
    double thirdLineRadianEnd = getRadians(excellent);
    canvas.drawArc(myRect, firstLineRadianEnd + secondLineRadianEnd,
        thirdLineRadianEnd, false, paint3);
  }

  double getRadians(double value) {
    return (360 * value) * pi / 180;
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
