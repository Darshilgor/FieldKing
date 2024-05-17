// import 'dart:io';
// import 'package:crop_your_image/crop_your_image.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:dotted_border/dotted_border.dart';

// class CropImage extends StatefulWidget {
//   final String image;
//   CropImage({super.key, required this.image});

//   @override
//   State<CropImage> createState() => _CropImageState();
// }

// class _CropImageState extends State<CropImage> {
//   final _cropController = CropController();
//   Uint8List? _imageData;
//   bool _loadingImage = false;
//   bool _isCropping = false;
//   bool _isCircleUi = false;
//   String _statusText = '';

//   @override
//   void initState() {
//     super.initState();
//     _loadImage(widget.image);
//   }

//   Future<void> _loadImage(String path) async {
//     setState(() {
//       _loadingImage = true;
//     });

//     final imageData = await File(path).readAsBytes();

//     setState(() {
//       _imageData = imageData;
//       _loadingImage = false;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Crop Image'),
//       ),
//       body: Container(
//         width: double.infinity,
//         height: double.infinity,
//         child: Center(
//           child: _loadingImage
//               ? CircularProgressIndicator()
//               : Column(
//                   children: [
//                     Expanded(
//                       child: _imageData == null
//                           ? Expanded(
//                               child: Padding(
//                                 padding: const EdgeInsets.all(16.0),
//                                 child: DottedBorder(
//                                   radius: const Radius.circular(12.0),
//                                   borderType: BorderType.RRect,
//                                   dashPattern: const [8, 4],
//                                   color: Theme.of(context)
//                                       .highlightColor
//                                       .withOpacity(0.4),
//                                   child: Center(
//                                     child: Column(
//                                       mainAxisSize: MainAxisSize.min,
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.center,
//                                       children: [
//                                         Icon(
//                                           Icons.image,
//                                           color:
//                                               Theme.of(context).highlightColor,
//                                           size: 80.0,
//                                         ),
//                                         const SizedBox(height: 24.0),
//                                         Text(
//                                           'Upload an image to start',
//                                           style: kIsWeb
//                                               ? Theme.of(context)
//                                                   .textTheme
//                                                   .headlineSmall!
//                                                   .copyWith(
//                                                       color: Theme.of(context)
//                                                           .highlightColor)
//                                               : Theme.of(context)
//                                                   .textTheme
//                                                   .bodyMedium!
//                                                   .copyWith(
//                                                       color: Theme.of(context)
//                                                           .highlightColor),
//                                         )
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             )
//                           : Stack(
//                               children: [
//                                 Crop(
//                                   controller: _cropController,
//                                   image: _imageData!,
//                                   onCropped: (croppedData) async {
//                                     final directory =
//                                         await getApplicationDocumentsDirectory();
//                                     final croppedImagePath =
//                                         '${directory.path}/${DateTime.now().millisecondsSinceEpoch}.png';

//                                     final file = File(croppedImagePath);
//                                     await file.writeAsBytes(croppedData);

//                                     Navigator.pop(context, croppedImagePath);
//                                   },
//                                   withCircleUi: _isCircleUi,
//                                   onStatusChanged: (status) => setState(() {
//                                     _statusText = <CropStatus, String>{
//                                           CropStatus.nothing:
//                                               'Crop has no image data',
//                                           CropStatus.loading:
//                                               'Crop is now loading given image',
//                                           CropStatus.ready:
//                                               'Crop is now ready!',
//                                           CropStatus.cropping:
//                                               'Crop is now cropping image',
//                                         }[status] ??
//                                         '';
//                                   }),
//                                 ),
//                                 Positioned(
//                                   right: 16,
//                                   bottom: 16,
//                                   child: GestureDetector(
//                                     onTapDown: (_) => setState(
//                                         () => _isCircleUi = !_isCircleUi),
//                                     child: CircleAvatar(
//                                       backgroundColor: _isCircleUi
//                                           ? Colors.blue.shade50
//                                           : Colors.blue,
//                                       child: Center(
//                                         child: Icon(_isCircleUi
//                                             ? Icons.crop
//                                             : Icons.crop_free_rounded),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                     ),
//                     if (_imageData != null)
//                       Padding(
//                         padding: const EdgeInsets.all(16),
//                         child: Column(
//                           children: [
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 IconButton(
//                                   icon: Icon(Icons.crop_7_5),
//                                   onPressed: () {
//                                     setState(() {
//                                       _isCircleUi = false;
//                                       _cropController
//                                         ..withCircleUi = false
//                                         ..aspectRatio = 16 / 4;
//                                     });
//                                   },
//                                 ),
//                                 IconButton(
//                                   icon: Icon(Icons.crop_16_9),
//                                   onPressed: () {
//                                     setState(() {
//                                       _isCircleUi = false;
//                                       _cropController
//                                         ..withCircleUi = false
//                                         ..aspectRatio = 16 / 9;
//                                     });
//                                   },
//                                 ),
//                                 IconButton(
//                                   icon: Icon(Icons.crop_5_4),
//                                   onPressed: () {
//                                     setState(() {
//                                       _isCircleUi = false;
//                                       _cropController
//                                         ..withCircleUi = false
//                                         ..aspectRatio = 4 / 3;
//                                     });
//                                   },
//                                 ),
//                                 IconButton(
//                                   icon: Icon(Icons.crop_square),
//                                   onPressed: () {
//                                     setState(() {
//                                       _isCircleUi = false;
//                                       _cropController
//                                         ..withCircleUi = false
//                                         ..aspectRatio = 1;
//                                     });
//                                   },
//                                 ),
//                                 IconButton(
//                                   icon: Icon(Icons.circle),
//                                   onPressed: () {
//                                     setState(() {
//                                       _isCircleUi = !_isCircleUi;
//                                       _cropController.withCircleUi =
//                                           _isCircleUi;
//                                     });
//                                   },
//                                 ),
//                               ],
//                             ),
//                             const SizedBox(height: 16),
//                             Container(
//                               width: double.infinity,
//                               child: ElevatedButton(
//                                 onPressed: () {
//                                   setState(() {
//                                     _isCropping = true;
//                                   });
//                                   _isCircleUi
//                                       ? _cropController.cropCircle()
//                                       : _cropController.crop();
//                                 },
//                                 child: Padding(
//                                   padding:
//                                       const EdgeInsets.symmetric(vertical: 16),
//                                   child: Text('CROP IT!'),
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(height: 40),
//                           ],
//                         ),
//                       ),
//                     const SizedBox(height: 16),
//                     Text(_statusText),
//                     const SizedBox(height: 16),
//                   ],
//                 ),
//         ),
//       ),
//     );
//   }
// }
