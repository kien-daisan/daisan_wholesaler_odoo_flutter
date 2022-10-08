import 'package:flutter/material.dart';
import 'package:flutter_project_structure/constants/app_constants.dart';
import 'package:flutter_project_structure/constants/menu_images.dart';
import 'package:flutter_project_structure/customWidgtes/circle_page_indicator.dart';
import 'package:flutter_project_structure/helper/image_view.dart';


class ZoomImageView extends StatefulWidget {
  ZoomImageView({Key? key, this.productImages}) : super(key: key);
  List<String>? productImages;

  @override
  _ZoomImageViewState createState() => _ZoomImageViewState();
}

class _ZoomImageViewState extends State<ZoomImageView> {
  var _pageController = PageController(initialPage: 0);
  final _currentPageNotifier = ValueNotifier<int>(0);
  double? imageSize;
  @override
  Widget build(BuildContext context) {
    imageSize ??= (AppSizes.width / 4);
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Padding(
                  padding: const EdgeInsets.all(AppSizes.extraPadding),
                  child: Image.asset(
                    AppImages.cancelIcon,
                    width: AppSizes.extraPadding,
                    height: AppSizes.extraPadding,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                )),
            const SizedBox(height: AppSizes.extraPadding,),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: widget.productImages?.length,
                itemBuilder: (BuildContext context, int index) {
                  return ImageView(
                    url: widget.productImages?[index],
                  );
                },
                onPageChanged: (int index) {
                  _currentPageNotifier.value = index;
                },
              ),
            ),
            Center(child: _buildCircularIndicator(_currentPageNotifier)),

            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: AppSizes.marginFive,vertical:AppSizes.spacingDefault ),
            //   child: SizedBox(
            //     height: (AppSizes.width / 4),
            //     child: ListView.builder(
            //         physics: const ClampingScrollPhysics(),
            //         shrinkWrap: true,
            //         scrollDirection: Axis.horizontal,
            //         itemCount: widget.productImages?.length,
            //         itemBuilder: (BuildContext context, int index) {
            //           return GestureDetector(
            //             onTap: () {
            //               //todo
            //               setState(() {
            //                 _pageController = PageController(initialPage: index);
            //               });
            //             },
            //             child: ImageView(
            //               url: widget.productImages?[index].thumb,
            //               width: imageSize!,
            //               height: imageSize!,
            //               fit: BoxFit.fill,
            //             ),
            //           );
            //         }),
            //   ),
            // )

          ],
        ),
      ),
    );
  }
  Widget _buildCircularIndicator(_currentPageNotifier){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CirclePageIndicator(
        dotColor: AppColors.darkGray,
        selectedDotColor: Theme.of(context).bottomAppBarTheme.color ?? Colors.black,
        itemCount: widget.productImages?.length,
        currentPageNotifier: _currentPageNotifier,
        productImages: widget.productImages,
        onPageSelected: (int index) {
          _currentPageNotifier.value = index;
          setState(() {
            _pageController.animateToPage(index,curve: Curves.ease,duration: Duration(milliseconds: 300));
          });
        },
      ),
    );

  }
}
