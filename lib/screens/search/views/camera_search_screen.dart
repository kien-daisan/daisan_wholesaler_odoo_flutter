// import 'package:camera/camera.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_structure/constants/app_constants.dart';
import 'package:flutter_project_structure/constants/app_string_constant.dart';
import 'package:flutter_project_structure/customWidgtes/common_tool_bar.dart';
import 'package:flutter_project_structure/helper/app_localizations.dart';
import 'package:flutter_project_structure/helper/loader.dart';
// import 'package:google_ml_kit/google_ml_kit.dart';

class CameraSearch extends StatefulWidget {
  CameraSearch({Key? key, required this.searchType}) : super(key: key);

  String searchType;

  @override
  State<CameraSearch> createState() => _CameraSearchState();
}

class _CameraSearchState extends State<CameraSearch> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
  // bool isTextSearch = false;
  // CameraController? _camera;
  // bool cameraInitialized = false;
  // final textDetector = GoogleMlKit.vision.textDetector();
  // final imageLabeler = GoogleMlKit.vision.imageLabeler();
  // Set<String> textData = {};
  // List<String> data = [];
  // double xScale = 0;
  // double yScale = 0;
  // final double deviceRatio = AppSizes.width / AppSizes.height;
  // AppLocalizations? localization;

//   @override
//   void initState() {
//     if (widget.searchType == AppConstant.textSearch) {
//       isTextSearch = true;
//     }
//     super.initState();
//     _initializeCamera();
//   }
//
//   void _initializeCamera() async {
//     // Get list of cameras of the device
//     List<CameraDescription> cameras = await availableCameras();
//
// // Create the CameraController
//     _camera = CameraController(cameras[0], ResolutionPreset.low);
// // Initialize the CameraController
//     _camera?.initialize().then((_) async {
//       // await _camera.setFlashMode(FlashMode.torch);
//       // _camera.set
//       // Start ImageStream
//       await _camera
//           ?.startImageStream((CameraImage image) => _processCameraImage(image));
//       setState(() {
//         cameraInitialized = true;
//       });
//     });
//   }
//
//   InputImage getInputImage(CameraImage cameraImage) {
//     final WriteBuffer allBytes = WriteBuffer();
//     for (Plane plane in cameraImage.planes) {
//       allBytes.putUint8List(plane.bytes);
//     }
//     final bytes = allBytes.done().buffer.asUint8List();
//
//     final Size imageSize =
//         Size(cameraImage.width.toDouble(), cameraImage.height.toDouble());
//
//     final InputImageRotation imageRotation =
//         InputImageRotationMethods.fromRawValue(
//                 _camera!.description.sensorOrientation) ??
//             InputImageRotation.Rotation_0deg;
//
//     final InputImageFormat inputImageFormat =
//         InputImageFormatMethods.fromRawValue(cameraImage.format.raw) ??
//             InputImageFormat.NV21;
//
//     final planeData = cameraImage.planes.map(
//       (Plane plane) {
//         return InputImagePlaneMetadata(
//           bytesPerRow: plane.bytesPerRow,
//           height: plane.height,
//           width: plane.width,
//         );
//       },
//     ).toList();
//
//     final inputImageData = InputImageData(
//       size: imageSize,
//       imageRotation: imageRotation,
//       inputImageFormat: inputImageFormat,
//       planeData: planeData,
//     );
//
//     return InputImage.fromBytes(bytes: bytes, inputImageData: inputImageData);
//   }
//
//   void _processCameraImage(CameraImage image) async {
//     xScale = _camera!.value.aspectRatio / deviceRatio;
//     yScale = deviceRatio / _camera!.value.aspectRatio;
//     InputImage inputImage = getInputImage(image);
//     if (isTextSearch) {
//       final RecognisedText recognisedText =
//           await textDetector.processImage(inputImage);
//
//       for (TextBlock block in recognisedText.blocks) {
//         final String text = block.text;
//         print("hello there>>>> $text");
//         textData.add(text);
//         data = textData.toList();
//       }
//       if (mounted) {
//         setState(() {});
//       }
//     } else {
//       final List<ImageLabel> labels =
//           await imageLabeler.processImage(inputImage);
//       for (ImageLabel label in labels) {
//         final String text = label.label;
//         textData.add(text);
//         data = textData.toList();
//       }
//       if (mounted) {
//         setState(() {});
//       }
//     }
//   }
//
//   @override
//   void dispose() {
//     _camera?.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     localization = AppLocalizations.of(context);
//     return Scaffold(
//       appBar: commonToolBar(
//           localization?.translate(AppStringConstant.search) ?? "", context),
//       body: Center(
//           child: (cameraInitialized)
//               ? Stack(
//                   children: [
//                     AspectRatio(
//                       aspectRatio: _camera!.value.aspectRatio,
//                       child: Transform(
//                           alignment: Alignment.center,
//                           transform: Matrix4.diagonal3Values(1, xScale, 1),
//                           child: CameraPreview(
//                             _camera!,
//                             child: textData.isEmpty
//                                 ? Center(
//                                     child: Text(localization?.translate(
//                                             AppStringConstant.noResult) ??
//                                         ""),
//                                   )
//                                 : SizedBox(
//                                     height: AppSizes.height / 2,
//                                     child: ListView.separated(
//                                         itemBuilder: (context, index) {
//                                           return InkWell(
//                                             onTap: () {
//                                               Navigator.pop(
//                                                   context, data[index]);
//                                             },
//                                             child: Container(
//                                               margin: const EdgeInsets.all(
//                                                   AppSizes.linePadding),
//                                               child: Text(
//                                                 data[index],
//                                                 style: Theme.of(context)
//                                                     .textTheme
//                                                     .bodySmall
//                                                     ?.apply(
//                                                         color: AppColors.white),
//                                               ),
//                                             ),
//                                           );
//                                         },
//                                         separatorBuilder:
//                                             (BuildContext context, int index) =>
//                                                 const Divider(
//                                                   thickness: 1,
//                                                   height: 1,
//                                                 ),
//                                         itemCount: textData.length),
//                                   ),
//                           )),
//                     ),
//                   ],
//                 )
//               : Loader()),
//     );
//   }
}
