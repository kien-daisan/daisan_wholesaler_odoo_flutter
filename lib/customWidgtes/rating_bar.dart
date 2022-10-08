import 'package:flutter/material.dart';

typedef void RatingChangeCallback(double rating);

class RatingBar extends StatefulWidget {
  final int starCount;
   double? rating;
  final RatingChangeCallback? onRatingChanged;
  final Color? color;
  final Color? borderColor;
  double? size;
   RatingBar({this.starCount = 5, this.rating = .0, this.onRatingChanged,this.size = 24 , this.color,this.borderColor, Key? key}) :super(key: key);

  @override
  State<RatingBar> createState() => _RatingBarState();
}

class _RatingBarState extends State<RatingBar> {
  Widget buildStar(BuildContext context, int index) {
    Icon icon;
    if (index >= widget.rating!) {
      icon = Icon(
        Icons.star_border,
        color: widget.borderColor ?? Theme.of(context).buttonColor,
        size: widget.size,
      );
    }
    else if (index > widget.rating! - 1 && index < widget.rating!) {
      icon = Icon(
        Icons.star_half,
        color: widget.color ?? Theme.of(context).primaryColor,
        size: widget.size,

      );
    } else {
      icon = Icon(
        Icons.star,
        color: widget.color ?? Theme.of(context).primaryColor,
        size: widget.size,
      );
    }
    return InkResponse(
      onTap: widget.onRatingChanged == null ? null : () => setState(() {
        widget.rating = index +1.0;
        widget.onRatingChanged!(index + 1.0);
      }),
      child: icon,
    );
  }

  @override
  Widget build(BuildContext context) {
    return  Row(children: List.generate(widget.starCount, (index) => buildStar(context, index)));
  }
}