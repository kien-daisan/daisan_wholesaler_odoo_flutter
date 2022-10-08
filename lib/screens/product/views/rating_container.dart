import 'package:flutter/material.dart';
import 'package:flutter_project_structure/constants/app_constants.dart';

class RatingContainer extends StatefulWidget {
  double rating;
  RatingContainer(this.rating, {Key? key}) : super(key: key);

  @override
  State<RatingContainer> createState() => _RatingContainerState();
}

class _RatingContainerState extends State<RatingContainer> {


  @override
  Widget build(BuildContext context) {
    return  Container(
      color: containerColor(widget.rating.toInt()),
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.normalPadding, vertical: AppSizes.normalPadding / 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("${widget.rating}",
            style: const TextStyle(color: AppColors.white, fontSize: 10),
          ),
          const SizedBox(
            width: 2.0,
          ),
          const Icon(
            Icons.star,
            color: AppColors.white,
            size: 10,
          )
        ],
      ),
    );
  }

  Color containerColor(int review){
    switch(review){
      case 1:
        return AppColors.red;
      case 2:
        return AppColors.lightRed;
      case 3:
        return AppColors.yellow;
      case 4:
        return AppColors.orange;
      case 5:
        return AppColors.green;
      default :
        return AppColors.black;
    }
  }

}
