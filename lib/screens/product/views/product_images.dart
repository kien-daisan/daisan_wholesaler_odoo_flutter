// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_project_structure/constants/app_constants.dart';
import 'package:flutter_project_structure/customWidgtes/circle_page_indicator.dart';
import 'package:flutter_project_structure/helper/image_view.dart';
import 'package:flutter_project_structure/screens/product/views/image_zoom_viewer.dart';

class ProductImages extends StatefulWidget {
  List<String> productImages;
  ProductImages(this.productImages, {Key? key}) : super(key: key);
  @override
  _ProductImagesState createState() => _ProductImagesState();
}

class _ProductImagesState extends State<ProductImages> {
  final _pageController = PageController(initialPage: 0);
  final _currentPageNotifier = ValueNotifier<int>(0);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: AppSizes.width,
          width: AppSizes.width,
          child:
          PageView.builder(
            controller: _pageController,
            itemCount: widget.productImages.length ,
            itemBuilder: (BuildContext context, int index){
              return GestureDetector(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => ZoomImageView(productImages: widget.productImages,)));
                },
                child: ImageView(url:widget.productImages[index] ,
                  fit: BoxFit.fill,),
              );
            },
            onPageChanged: (int index){
              _currentPageNotifier.value = index;
            },),
        ),
        Container(
          width: AppSizes.width,
          color: Theme.of(context).cardColor,
          child: Center(
            child: _buildCircularIndicator(_currentPageNotifier),
          ),
        )
      ],
    );
  }

  Widget _buildCircularIndicator(_currentPageNotifier){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CirclePageIndicator(
        dotColor: AppColors.darkGray,
        selectedDotColor: Theme.of(context).bottomAppBarTheme.color ?? Colors.black,
        itemCount: widget.productImages.length,
        currentPageNotifier: _currentPageNotifier,
      ),
    );

  }
}
