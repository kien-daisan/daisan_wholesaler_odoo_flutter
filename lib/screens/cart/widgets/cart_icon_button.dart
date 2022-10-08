import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_structure/constants/app_constants.dart';

class CartIconButton extends StatelessWidget {
  const CartIconButton({
    required this.leadingIcon,
    required this.title,
    required this.onClick,
    Key? key,
  }) : super(key: key);

  final IconData leadingIcon;
  final String title;
  final VoidCallback onClick;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSizes.imageRadius),
      child: GestureDetector(
        onTap: onClick,
        child: Container(
          height: AppSizes.itemHeight,
          color: Theme.of(context).cardColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSizes.imageRadius),
                child: Icon(leadingIcon,color: Theme.of(context).iconTheme.color,size: 22,),
              ),
          Text(
                title,
                style:Theme.of(context).textTheme.subtitle2?.copyWith(fontSize: 13, fontWeight: FontWeight.bold))
            ],
          ),
        ),
      ),
    );
  }
}