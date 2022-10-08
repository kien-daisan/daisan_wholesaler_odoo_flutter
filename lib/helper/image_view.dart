
import 'package:flutter/material.dart';

class ImageView extends StatelessWidget {
  final String? url;
  double height;
  double width;
  BoxFit fit;
  ImageView({this.url,this.width = 0.0, this.height = 0.0, this.fit = BoxFit.scaleDown});


  @override
  Widget build(BuildContext context) {
    return FadeInImage(
        placeholder: const AssetImage('lib/assets/images/placeholder.png', ),
        image: NetworkImage(url ?? ''),
        imageErrorBuilder:(context, error, stackTrace) {
          return Image.asset('lib/assets/images/placeholder.png',
              width: width != 0.0 ?  width : null,
              height:  height != 0.0 ?  height : null);
        },
        fit: fit,
        width:  width != 0.0 ?  width : null,height: height != 0.0 ?  height : null
    );
  }
}