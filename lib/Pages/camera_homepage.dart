// // import 'dart:io';

// // import 'package:camera/camera.dart';
// // import 'package:field_king/Pages/global.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter/services.dart';
// // import 'package:path_provider/path_provider.dart';

// // class CameraScreen extends StatefulWidget {
// //   const CameraScreen({super.key});

// //   @override
// //   State<CameraScreen> createState() => _CameraScreenState();
// // }

// // class _CameraScreenState extends State<CameraScreen>
// //     with WidgetsBindingObserver {
// //   CameraController? _controller;
// //   bool _isCameraInitialized = false;
// //   late final List<CameraDescription> _cameras;
// //   bool _isRecording = false;

// //   FlashMode? _currentFlashMode;
// //   double _minAvailableZoom = 1.0;
// //   double _maxAvailableZoom = 1.0;
// //   double _currentZoomLevel = 1.0;

// //   double _minAvailableExposureOffset = 0.0;
// //   double _maxAvailableExposureOffset = 0.0;
// //   double _currentExposureOffset = 0.0;

// //   CameraController? controller;
// //   bool _isRearCameraSelected = true;
// //   void onNewCameraSelected(CameraDescription cameraDescription) async {
// //     final previousCameraController = controller;
// //     // Instantiating the camera controller

// //     final CameraController cameraController = CameraController(
// //       cameraDescription,
// //       currentResolutionPreset,
// //       imageFormatGroup: ImageFormatGroup.jpeg,
// //     );

// //     // Dispose the previous controller
// //     await previousCameraController?.dispose();

// //     // Replace with the new controller
// //     if (mounted) {
// //       setState(() {
// //         controller = cameraController;
// //       });
// //     }

// //     // Update UI if controller updated
// //     cameraController.addListener(() {
// //       if (mounted) setState(() {});
// //     });

// //     // Initialize controller
// //     try {
// //       await cameraController.initialize();
// //     } on CameraException catch (e) {
// //       print('Error initializing camera: $e');
// //     }

// //     // Update the Boolean
// //     if (mounted) {
// //       setState(() {
// //         _isCameraInitialized = controller!.value.isInitialized;
// //       });
// //     }
// //     cameraController
// //         .getMaxZoomLevel()
// //         .then((value) => _maxAvailableZoom = value);

// //     cameraController
// //         .getMinZoomLevel()
// //         .then((value) => _minAvailableZoom = value);
// //     cameraController
// //         .getMinExposureOffset()
// //         .then((value) => _minAvailableExposureOffset = value);

// //     cameraController
// //         .getMaxExposureOffset()
// //         .then((value) => _maxAvailableExposureOffset = value);
// //   }

// //   @override
// //   void dispose() {
// //     controller?.dispose();
// //     super.dispose();
// //   }

// //   @override
// //   void initState() {
// //     SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
// //     onNewCameraSelected(cameras[0]);
// //     super.initState();
// //   }

// //   @override
// //   void didChangeAppLifecycleState(AppLifecycleState state) {
// //     final CameraController? cameraController = controller;

// //     // App state changed before we got the chance to initialize.
// //     if (cameraController == null || !cameraController.value.isInitialized) {
// //       return;
// //     }

// //     if (state == AppLifecycleState.inactive) {
// //       // Free up memory when camera not active
// //       cameraController.dispose();
// //     } else if (state == AppLifecycleState.resumed) {
// //       // Reinitialize the camera with same properties
// //       onNewCameraSelected(cameraController.description);
// //     }
// //   }

// //   final resolutionPresets = ResolutionPreset.values;
// //   ResolutionPreset currentResolutionPreset = ResolutionPreset.high;
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         leadingWidth: 0,
// //         leading: Container(),
// //         title: Row(
// //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //           mainAxisSize: MainAxisSize.max,
// //           children: [
// //             Icon(
// //               Icons.close,
// //             ),
// //             Row(
// //               children: [
// //                 InkWell(
// //                   onTap: () {
// //                     setState(() {
// //                       _isCameraInitialized = false;
// //                     });
// //                     onNewCameraSelected(
// //                       cameras[_isRearCameraSelected ? 0 : 1],
// //                     );
// //                     setState(() {
// //                       _isRearCameraSelected = !_isRearCameraSelected;
// //                     });
// //                   },
// //                   child: Icon(
// //                     Icons.cameraswitch_outlined,
// //                     color: Colors.black,
// //                     size: 30,
// //                   ),
// //                 ),
// //                 SizedBox(
// //                   width: 10,
// //                 ),
// //                 InkWell(
// //                   onTap: () async {
// //                     // setState(() {
// //                     //   _isCameraInitialized = false;
// //                     // });
// //                     // onNewCameraSelected(
// //                     //   cameras[_isRearCameraSelected ? 1 : 0],
// //                     // );
// //                     // setState(() {
// //                     //   _isRearCameraSelected = !_isRearCameraSelected;
// //                     // });
// //                     setState(() {
// //                       _currentFlashMode = FlashMode.auto;
// //                     });
// //                     await controller!.setFlashMode(
// //                       FlashMode.auto,
// //                     );
// //                   },
// //                   child: Icon(
// //                     Icons.flash_on,
// //                     color: _currentFlashMode == FlashMode.always
// //                         ? Colors.amber
// //                         : Colors.black,
// //                   ),
// //                 ),
// //               ],
// //             )
// //           ],
// //         ),
// //       ),
// //       body: Column(
// //         children: [
// //           _isCameraInitialized
// //               ? Stack(
// //                   alignment: Alignment.topRight,
// //                   children: [
// //                     AspectRatio(
// //                       aspectRatio: 1 / controller!.value.aspectRatio,
// //                       child: controller!.buildPreview(),
// //                     ),
// //                     DropdownButton<ResolutionPreset>(
// //                       dropdownColor: Colors.black87,
// //                       underline: Container(),
// //                       value: currentResolutionPreset,
// //                       items: [
// //                         for (ResolutionPreset preset in resolutionPresets)
// //                           DropdownMenuItem(
// //                             child: Text(
// //                               preset.toString().split('.')[1].toUpperCase(),
// //                               style: TextStyle(color: Colors.white),
// //                             ),
// //                             value: preset,
// //                           )
// //                       ],
// //                       onChanged: (value) {
// //                         setState(() {
// //                           currentResolutionPreset = value!;
// //                           _isCameraInitialized = false;
// //                         });
// //                         onNewCameraSelected(controller!.description);
// //                       },
// //                       hint: Text("Select item"),
// //                     )
// //                   ],
// //                 )
// //               : Container(),
// //           Padding(
// //             padding: const EdgeInsets.symmetric(
// //               horizontal: 20,
// //               vertical: 10,
// //             ),
// //             child: Row(
// //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //               children: [
// //                 Container(
// //                   color: Colors.yellow,
// //                   padding: EdgeInsets.all(
// //                     20,
// //                   ),
// //                   child: Text('1'),
// //                 ),
// //                 InkWell(
// //                   onTap: () async {
// //                     XFile? rawImage = await takePicture();
// //                     File imageFile = File(rawImage!.path);

// //                     int currentUnix = DateTime.now().millisecondsSinceEpoch;
// //                     final directory = await getApplicationDocumentsDirectory();
// //                     String fileFormat = imageFile.path.split('.').last;

// //                     await imageFile.copy(
// //                       '${directory.path}/$currentUnix.$fileFormat',
// //                     );
// //                   },
// //                   child: Icon(
// //                     Icons.camera,
// //                     size: 40,
// //                   ),
// //                 ),
// //                 Text(
// //                   'END',
// //                   style: TextStyle(
// //                     fontSize: 20,
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           )
// //         ],
// //       ),
// //     );
// //   }

// //   Future<XFile?> takePicture() async {
// //     final CameraController? cameraController = controller;
// //     if (cameraController!.value.isTakingPicture) {
// //       // A capture is already pending, do nothing.
// //       return null;
// //     }
// //     try {
// //       XFile file = await cameraController.takePicture();
// //       return file;
// //     } on CameraException catch (e) {
// //       print('Error occured while taking picture: $e');
// //       return null;
// //     }
// //   }
// // }
// //================================================================================================================================================================================================================
// // import 'dart:io';

// // import 'package:camera/camera.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter/services.dart';
// // import 'package:path_provider/path_provider.dart';

// // class CameraScreen extends StatefulWidget {
// //   const CameraScreen({super.key});

// //   @override
// //   State<CameraScreen> createState() => _CameraScreenState();
// // }

// // class _CameraScreenState extends State<CameraScreen>
// //     with WidgetsBindingObserver {
// //   CameraController? _controller;
// //   bool _isCameraInitialized = false;
// //   late List<CameraDescription> _cameras;
// //   bool _isRecording = false;

// //   FlashMode? _currentFlashMode;
// //   double _minAvailableZoom = 1.0;
// //   double _maxAvailableZoom = 1.0;
// //   double _currentZoomLevel = 1.0;

// //   double _minAvailableExposureOffset = 0.0;
// //   double _maxAvailableExposureOffset = 0.0;
// //   double _currentExposureOffset = 0.0;

// //   bool _isRearCameraSelected = true;
// //   String? _imagePath;

// //   ResolutionPreset currentResolutionPreset = ResolutionPreset.high;

// //   @override
// //   void initState() {
// //     super.initState();
// //     WidgetsBinding.instance.addObserver(this);
// //     SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
// //     _initializeCameras();
// //   }

// //   Future<void> _initializeCameras() async {
// //     _cameras = await availableCameras();
// //     if (_cameras.isNotEmpty) {
// //       onNewCameraSelected(_cameras[0]);
// //     }
// //   }

// //   void onNewCameraSelected(CameraDescription cameraDescription) async {
// //     final previousCameraController = _controller;
// //     final CameraController cameraController = CameraController(
// //       cameraDescription,
// //       currentResolutionPreset,
// //       imageFormatGroup: ImageFormatGroup.jpeg,
// //     );

// //     await previousCameraController?.dispose();

// //     if (mounted) {
// //       setState(() {
// //         _controller = cameraController;
// //       });
// //     }

// //     cameraController.addListener(() {
// //       if (mounted) setState(() {});
// //     });

// //     try {
// //       await cameraController.initialize();
// //     } on CameraException catch (e) {
// //       print('Error initializing camera: $e');
// //     }

// //     if (mounted) {
// //       setState(() {
// //         _isCameraInitialized = cameraController.value.isInitialized;
// //       });
// //     }

// //     _maxAvailableZoom = await cameraController.getMaxZoomLevel();
// //     _minAvailableZoom = await cameraController.getMinZoomLevel();
// //     _minAvailableExposureOffset = await cameraController.getMinExposureOffset();
// //     _maxAvailableExposureOffset = await cameraController.getMaxExposureOffset();
// //   }

// //   @override
// //   void dispose() {
// //     WidgetsBinding.instance.removeObserver(this);
// //     _controller?.dispose();
// //     super.dispose();
// //   }

// //   @override
// //   void didChangeAppLifecycleState(AppLifecycleState state) {
// //     final CameraController? cameraController = _controller;

// //     if (cameraController == null || !cameraController.value.isInitialized) {
// //       return;
// //     }

// //     if (state == AppLifecycleState.inactive) {
// //       cameraController.dispose();
// //     } else if (state == AppLifecycleState.resumed) {
// //       onNewCameraSelected(cameraController.description);
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         leadingWidth: 0,
// //         leading: Container(),
// //         title: Row(
// //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //           mainAxisSize: MainAxisSize.max,
// //           children: [
// //             Icon(
// //               Icons.close,
// //             ),
// //             Row(
// //               children: [
// //                 InkWell(
// //                   onTap: () {
// //                     setState(() {
// //                       _isCameraInitialized = false;
// //                     });
// //                     onNewCameraSelected(
// //                       _cameras[_isRearCameraSelected ? 0 : 1],
// //                     );
// //                     setState(() {
// //                       _isRearCameraSelected = !_isRearCameraSelected;
// //                     });
// //                   },
// //                   child: Icon(
// //                     Icons.cameraswitch_outlined,
// //                     color: Colors.black,
// //                     size: 30,
// //                   ),
// //                 ),
// //                 SizedBox(
// //                   width: 10,
// //                 ),
// //                 InkWell(
// //                   onTap: () async {
// //                     setState(() {
// //                       _currentFlashMode = FlashMode.auto;
// //                     });
// //                     await _controller!.setFlashMode(
// //                       FlashMode.auto,
// //                     );
// //                   },
// //                   child: Icon(
// //                     Icons.flash_on,
// //                     color: _currentFlashMode == FlashMode.always
// //                         ? Colors.amber
// //                         : Colors.black,
// //                   ),
// //                 ),
// //               ],
// //             )
// //           ],
// //         ),
// //       ),
// //       body: Column(
// //         children: [
// //           _isCameraInitialized
// //               ? Stack(
// //                   alignment: Alignment.topRight,
// //                   children: [
// //                     AspectRatio(
// //                       aspectRatio: 1 / _controller!.value.aspectRatio,
// //                       child: _imagePath == null
// //                           ? CameraPreview(_controller!)
// //                           : Image.file(File(_imagePath!)),
// //                     ),
// //                     DropdownButton<ResolutionPreset>(
// //                       dropdownColor: Colors.black87,
// //                       underline: Container(),
// //                       value: currentResolutionPreset,
// //                       items: [
// //                         for (ResolutionPreset preset in ResolutionPreset.values)
// //                           DropdownMenuItem(
// //                             child: Text(
// //                               preset.toString().split('.')[1].toUpperCase(),
// //                               style: TextStyle(color: Colors.white),
// //                             ),
// //                             value: preset,
// //                           )
// //                       ],
// //                       onChanged: (value) {
// //                         setState(() {
// //                           currentResolutionPreset = value!;
// //                           _isCameraInitialized = false;
// //                         });
// //                         onNewCameraSelected(_controller!.description);
// //                       },
// //                       hint: Text("Select item"),
// //                     )
// //                   ],
// //                 )
// //               : Container(),
// //           Padding(
// //             padding: const EdgeInsets.symmetric(
// //               horizontal: 20,
// //               vertical: 10,
// //             ),
// //             child: Row(
// //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //               children: [
// //                 _imagePath != null
// //                     ? Container(
// //                         color: Colors.yellow,
// //                         padding: EdgeInsets.all(
// //                           20,
// //                         ),
// //                         child: Text('1'),
// //                       )
// //                     : Container(
// //                         color: Colors.yellow,
// //                         padding: EdgeInsets.all(
// //                           20,
// //                         ),
// //                         child: Text('1'),
// //                       ),
// //                 InkWell(
// //                   onTap: () async {
// //                     XFile? rawImage = await takePicture();
// //                     if (rawImage != null) {
// //                       File imageFile = File(rawImage.path);

// //                       int currentUnix = DateTime.now().millisecondsSinceEpoch;
// //                       final directory =
// //                           await getApplicationDocumentsDirectory();
// //                       String fileFormat = imageFile.path.split('.').last;

// //                       String newFilePath =
// //                           '${directory.path}/$currentUnix.$fileFormat';
// //                       await imageFile.copy(newFilePath);

// //                       setState(() {
// //                         _imagePath = newFilePath;
// //                       });

// //                       // Display the captured image for 3 seconds
// //                       await Future.delayed(Duration(seconds: 3));

// //                       setState(() {
// //                         _imagePath = null;
// //                       });
// //                     }
// //                   },
// //                   child: Icon(
// //                     Icons.camera,
// //                     size: 40,
// //                   ),
// //                 ),
// //                 Text(
// //                   'END',
// //                   style: TextStyle(
// //                     fontSize: 20,
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   Future<XFile?> takePicture() async {
// //     if (_controller == null ||
// //         !_controller!.value.isInitialized ||
// //         _controller!.value.isTakingPicture) {
// //       return null;
// //     }
// //     try {
// //       XFile file = await _controller!.takePicture();
// //       return file;
// //     } on CameraException catch (e) {
// //       print('Error occurred while taking picture: $e');
// //       return null;
// //     }
// //   }
// // }

// // import 'dart:io';

// // import 'package:camera/camera.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter/services.dart';
// // import 'package:path_provider/path_provider.dart';

// // class CameraScreen extends StatefulWidget {
// //   const CameraScreen({super.key});

// //   @override
// //   State<CameraScreen> createState() => _CameraScreenState();
// // }

// // class _CameraScreenState extends State<CameraScreen>
// //     with WidgetsBindingObserver {
// //   CameraController? _controller;
// //   bool _isCameraInitialized = false;
// //   late List<CameraDescription> _cameras;
// //   bool _isRecording = false;

// //   FlashMode? _currentFlashMode;
// //   double _minAvailableZoom = 1.0;
// //   double _maxAvailableZoom = 1.0;
// //   double _currentZoomLevel = 1.0;

// //   double _minAvailableExposureOffset = 0.0;
// //   double _maxAvailableExposureOffset = 0.0;
// //   double _currentExposureOffset = 0.0;

// //   bool _isRearCameraSelected = true;
// //   String? _imagePath;
// //   List<String> _capturedImages = [];

// //   ResolutionPreset currentResolutionPreset = ResolutionPreset.high;

// //   @override
// //   void initState() {
// //     super.initState();
// //     WidgetsBinding.instance.addObserver(this);
// //     SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
// //     _initializeCameras();
// //   }

// //   Future<void> _initializeCameras() async {
// //     _cameras = await availableCameras();
// //     if (_cameras.isNotEmpty) {
// //       onNewCameraSelected(_cameras[0]);
// //     }
// //   }

// //   void onNewCameraSelected(CameraDescription cameraDescription) async {
// //     final previousCameraController = _controller;
// //     final CameraController cameraController = CameraController(
// //       cameraDescription,
// //       currentResolutionPreset,
// //       imageFormatGroup: ImageFormatGroup.jpeg,
// //     );

// //     await previousCameraController?.dispose();

// //     if (mounted) {
// //       setState(() {
// //         _controller = cameraController;
// //       });
// //     }

// //     cameraController.addListener(() {
// //       if (mounted) setState(() {});
// //     });

// //     try {
// //       await cameraController.initialize();
// //     } on CameraException catch (e) {
// //       print('Error initializing camera: $e');
// //     }

// //     if (mounted) {
// //       setState(() {
// //         _isCameraInitialized = cameraController.value.isInitialized;
// //       });
// //     }

// //     _maxAvailableZoom = await cameraController.getMaxZoomLevel();
// //     _minAvailableZoom = await cameraController.getMinZoomLevel();
// //     _minAvailableExposureOffset = await cameraController.getMinExposureOffset();
// //     _maxAvailableExposureOffset = await cameraController.getMaxExposureOffset();
// //   }

// //   @override
// //   void dispose() {
// //     WidgetsBinding.instance.removeObserver(this);
// //     _controller?.dispose();
// //     super.dispose();
// //   }

// //   @override
// //   void didChangeAppLifecycleState(AppLifecycleState state) {
// //     final CameraController? cameraController = _controller;

// //     if (cameraController == null || !cameraController.value.isInitialized) {
// //       return;
// //     }

// //     if (state == AppLifecycleState.inactive) {
// //       cameraController.dispose();
// //     } else if (state == AppLifecycleState.resumed) {
// //       onNewCameraSelected(cameraController.description);
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         leadingWidth: 0,
// //         leading: Container(),
// //         title: Row(
// //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //           mainAxisSize: MainAxisSize.max,
// //           children: [
// //             Icon(
// //               Icons.close,
// //             ),
// //             Row(
// //               children: [
// //                 InkWell(
// //                   onTap: () {
// //                     setState(() {
// //                       _isCameraInitialized = false;
// //                     });
// //                     onNewCameraSelected(
// //                       _cameras[_isRearCameraSelected ? 0 : 1],
// //                     );
// //                     setState(() {
// //                       _isRearCameraSelected = !_isRearCameraSelected;
// //                     });
// //                   },
// //                   child: Icon(
// //                     Icons.cameraswitch_outlined,
// //                     color: Colors.black,
// //                     size: 30,
// //                   ),
// //                 ),
// //                 SizedBox(
// //                   width: 10,
// //                 ),
// //                 InkWell(
// //                   onTap: () async {
// //                     setState(() {
// //                       _currentFlashMode = FlashMode.auto;
// //                     });
// //                     await _controller!.setFlashMode(
// //                       FlashMode.auto,
// //                     );
// //                   },
// //                   child: Icon(
// //                     Icons.flash_on,
// //                     color: _currentFlashMode == FlashMode.always
// //                         ? Colors.amber
// //                         : Colors.black,
// //                   ),
// //                 ),
// //               ],
// //             )
// //           ],
// //         ),
// //       ),
// //       body: Column(
// //         children: [
// //           _isCameraInitialized
// //               ? Stack(
// //                   alignment: Alignment.topRight,
// //                   children: [
// //                     AspectRatio(
// //                       aspectRatio: 1 / _controller!.value.aspectRatio,
// //                       child: _imagePath == null
// //                           ? CameraPreview(_controller!)
// //                           : Image.file(File(_imagePath!)),
// //                     ),
// //                     DropdownButton<ResolutionPreset>(
// //                       dropdownColor: Colors.black87,
// //                       underline: Container(),
// //                       value: currentResolutionPreset,
// //                       items: [
// //                         for (ResolutionPreset preset in ResolutionPreset.values)
// //                           DropdownMenuItem(
// //                             child: Text(
// //                               preset.toString().split('.')[1].toUpperCase(),
// //                               style: TextStyle(color: Colors.white),
// //                             ),
// //                             value: preset,
// //                           )
// //                       ],
// //                       onChanged: (value) {
// //                         setState(() {
// //                           currentResolutionPreset = value!;
// //                           _isCameraInitialized = false;
// //                         });
// //                         onNewCameraSelected(_controller!.description);
// //                       },
// //                       hint: Text("Select item"),
// //                     )
// //                   ],
// //                 )
// //               : Container(),
// //           Padding(
// //             padding: const EdgeInsets.symmetric(
// //               horizontal: 20,
// //               vertical: 10,
// //             ),
// //             child: Row(
// //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //               children: [
// //                 _imagePath != null
// //                     ? Container(
// //                         color: Colors.yellow,
// //                         padding: EdgeInsets.all(20),
// //                         child: Image.file(
// //                           File(_imagePath!),
// //                           fit: BoxFit.cover,
// //                         ),
// //                       )
// //                     : Container(
// //                         color: Colors.yellow,
// //                         padding: EdgeInsets.all(20),
// //                         child: Text('${_capturedImages.length}'),
// //                       ),
// //                 InkWell(
// //                   onTap: () async {
// //                     XFile? rawImage = await takePicture();
// //                     if (rawImage != null) {
// //                       File imageFile = File(rawImage.path);

// //                       int currentUnix = DateTime.now().millisecondsSinceEpoch;
// //                       final directory =
// //                           await getApplicationDocumentsDirectory();
// //                       String fileFormat = imageFile.path.split('.').last;

// //                       String newFilePath =
// //                           '${directory.path}/$currentUnix.$fileFormat';
// //                       await imageFile.copy(newFilePath);

// //                       setState(() {
// //                         _imagePath = newFilePath;
// //                         _capturedImages.add(newFilePath);
// //                       });

// //                       // Display the captured image for 3 seconds
// //                       await Future.delayed(Duration(seconds: 3));

// //                       setState(() {
// //                         _imagePath = null;
// //                       });
// //                     }
// //                   },
// //                   child: Icon(
// //                     Icons.camera,
// //                     size: 40,
// //                   ),
// //                 ),
// //                 Text(
// //                   'END',
// //                   style: TextStyle(
// //                     fontSize: 20,
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   Future<XFile?> takePicture() async {
// //     if (_controller == null ||
// //         !_controller!.value.isInitialized ||
// //         _controller!.value.isTakingPicture) {
// //       return null;
// //     }
// //     try {
// //       XFile file = await _controller!.takePicture();
// //       return file;
// //     } on CameraException catch (e) {
// //       print('Error occurred while taking picture: $e');
// //       return null;
// //     }
// //   }
// // }

// //=================================================================================================================================================

// // import 'dart:io';

// // import 'package:camera/camera.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter/services.dart';
// // import 'package:path_provider/path_provider.dart';

// // class CameraScreen extends StatefulWidget {
// //   const CameraScreen({super.key});

// //   @override
// //   State<CameraScreen> createState() => _CameraScreenState();
// // }

// // class _CameraScreenState extends State<CameraScreen>
// //     with WidgetsBindingObserver {
// //   CameraController? _controller;
// //   bool _isCameraInitialized = false;
// //   late List<CameraDescription> _cameras;
// //   bool _isRecording = false;

// //   FlashMode? _currentFlashMode;
// //   double _minAvailableZoom = 1.0;
// //   double _maxAvailableZoom = 1.0;
// //   double _currentZoomLevel = 1.0;

// //   double _minAvailableExposureOffset = 0.0;
// //   double _maxAvailableExposureOffset = 0.0;
// //   double _currentExposureOffset = 0.0;

// //   bool _isRearCameraSelected = true;
// //   String? _imagePath;
// //   List<String> _capturedImages = [];
// //   bool _showCapturedImages = false;

// //   ResolutionPreset currentResolutionPreset = ResolutionPreset.high;

// //   @override
// //   void initState() {
// //     super.initState();
// //     WidgetsBinding.instance.addObserver(this);
// //     SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
// //     _initializeCameras();
// //   }

// //   Future<void> _initializeCameras() async {
// //     _cameras = await availableCameras();
// //     if (_cameras.isNotEmpty) {
// //       onNewCameraSelected(_cameras[0]);
// //     }
// //   }

// //   void onNewCameraSelected(CameraDescription cameraDescription) async {
// //     final previousCameraController = _controller;
// //     final CameraController cameraController = CameraController(
// //       cameraDescription,
// //       currentResolutionPreset,
// //       imageFormatGroup: ImageFormatGroup.jpeg,
// //     );

// //     await previousCameraController?.dispose();

// //     if (mounted) {
// //       setState(() {
// //         _controller = cameraController;
// //       });
// //     }

// //     cameraController.addListener(() {
// //       if (mounted) setState(() {});
// //     });

// //     try {
// //       await cameraController.initialize();
// //     } on CameraException catch (e) {
// //       print('Error initializing camera: $e');
// //     }

// //     if (mounted) {
// //       setState(() {
// //         _isCameraInitialized = cameraController.value.isInitialized;
// //       });
// //     }

// //     _maxAvailableZoom = await cameraController.getMaxZoomLevel();
// //     _minAvailableZoom = await cameraController.getMinZoomLevel();
// //     _minAvailableExposureOffset = await cameraController.getMinExposureOffset();
// //     _maxAvailableExposureOffset = await cameraController.getMaxExposureOffset();
// //   }

// //   @override
// //   void dispose() {
// //     WidgetsBinding.instance.removeObserver(this);
// //     _controller?.dispose();
// //     super.dispose();
// //   }

// //   @override
// //   void didChangeAppLifecycleState(AppLifecycleState state) {
// //     final CameraController? cameraController = _controller;

// //     if (cameraController == null || !cameraController.value.isInitialized) {
// //       return;
// //     }

// //     if (state == AppLifecycleState.inactive) {
// //       cameraController.dispose();
// //     } else if (state == AppLifecycleState.resumed) {
// //       onNewCameraSelected(cameraController.description);
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return WillPopScope(
// //       onWillPop: () async {
// //         // Perform navigation when back button is pressed
// //         Navigator.of(context).pop();
// //         return false; // Return false to prevent default behavior
// //       },
// //       child: Scaffold(
// //         appBar: AppBar(
// //           leadingWidth: 0,
// //           leading: Container(),
// //           title: Row(
// //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //             mainAxisSize: MainAxisSize.max,
// //             children: [
// //               Icon(
// //                 Icons.close,
// //               ),
// //               Row(
// //                 children: [
// //                   InkWell(
// //                     onTap: () {
// //                       setState(() {
// //                         _isCameraInitialized = false;
// //                       });
// //                       onNewCameraSelected(
// //                         _cameras[_isRearCameraSelected ? 0 : 1],
// //                       );
// //                       setState(() {
// //                         _isRearCameraSelected = !_isRearCameraSelected;
// //                       });
// //                     },
// //                     child: Icon(
// //                       Icons.cameraswitch_outlined,
// //                       color: Colors.black,
// //                       size: 30,
// //                     ),
// //                   ),
// //                   SizedBox(
// //                     width: 10,
// //                   ),
// //                   InkWell(
// //                     onTap: () async {
// //                       setState(() {
// //                         if (_currentFlashMode == FlashMode.auto) {
// //                           _currentFlashMode = FlashMode.always;
// //                         } else if (_currentFlashMode == FlashMode.always) {
// //                           _currentFlashMode = FlashMode.off;
// //                         } else {
// //                           _currentFlashMode = FlashMode.auto;
// //                         }
// //                       });
// //                       await _controller!.setFlashMode(_currentFlashMode!);
// //                     },
// //                     child: Icon(
// //                       Icons.flash_on,
// //                       color: _currentFlashMode != FlashMode.off
// //                           ? Colors.amber
// //                           : Colors.black,
// //                     ),
// //                   ),
// //                 ],
// //               )
// //             ],
// //           ),
// //         ),
// //         body: Column(
// //           children: [
// //             _isCameraInitialized
// //                 ? Stack(
// //                     alignment: Alignment.topRight,
// //                     children: [
// //                       AspectRatio(
// //                         aspectRatio: 1 / _controller!.value.aspectRatio,
// //                         child: _showCapturedImages
// //                             ? PageView.builder(
// //                                 itemCount: _capturedImages.length,
// //                                 itemBuilder: (context, index) {
// //                                   return Image.file(
// //                                       File(_capturedImages[index]));
// //                                 },
// //                               )
// //                             : CameraPreview(_controller!),
// //                       ),
// //                       DropdownButton<ResolutionPreset>(
// //                         dropdownColor: Colors.black87,
// //                         underline: Container(),
// //                         value: currentResolutionPreset,
// //                         items: [
// //                           for (ResolutionPreset preset
// //                               in ResolutionPreset.values)
// //                             DropdownMenuItem(
// //                               child: Text(
// //                                 preset.toString().split('.')[1].toUpperCase(),
// //                                 style: TextStyle(color: Colors.white),
// //                               ),
// //                               value: preset,
// //                             )
// //                         ],
// //                         onChanged: (value) {
// //                           setState(() {
// //                             currentResolutionPreset = value!;
// //                             _isCameraInitialized = false;
// //                           });
// //                           onNewCameraSelected(_controller!.description);
// //                         },
// //                         hint: Text("Select item"),
// //                       )
// //                     ],
// //                   )
// //                 : Container(),
// //             Padding(
// //               padding: const EdgeInsets.symmetric(
// //                 horizontal: 20,
// //                 vertical: 10,
// //               ),
// //               child: Row(
// //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                 children: [
// //                   GestureDetector(
// //                     onTap: () {
// //                       if (_capturedImages.isNotEmpty) {
// //                         setState(() {
// //                           _showCapturedImages = !_showCapturedImages;
// //                         });
// //                       }
// //                     },
// //                     child: Container(
// //                       color: Colors.yellow,
// //                       padding: EdgeInsets.all(20),
// //                       child: Text('${_capturedImages.length}'),
// //                     ),
// //                   ),
// //                   GestureDetector(
// //                     onTap: () async {
// //                       XFile? rawImage = await takePicture();
// //                       if (rawImage != null) {
// //                         File imageFile = File(rawImage.path);

// //                         int currentUnix = DateTime.now().millisecondsSinceEpoch;
// //                         final directory =
// //                             await getApplicationDocumentsDirectory();
// //                         String fileFormat = imageFile.path.split('.').last;

// //                         String newFilePath =
// //                             '${directory.path}/$currentUnix.$fileFormat';
// //                         await imageFile.copy(newFilePath);

// //                         setState(() {
// //                           _imagePath = newFilePath;
// //                           _showCapturedImages =
// //                               true; // Show the captured image immediately
// //                         });

// //                         // After 3 seconds, add the photo to the list and hide the image
// //                         await Future.delayed(Duration(seconds: 3));

// //                         setState(() {
// //                           _capturedImages.add(newFilePath);
// //                           _showCapturedImages =
// //                               false; // Hide the captured image
// //                         });
// //                       }
// //                     },
// //                     child: Icon(
// //                       Icons.camera,
// //                       size: 40,
// //                     ),
// //                   ),
// //                   Text(
// //                     'END',
// //                     style: TextStyle(
// //                       fontSize: 20,
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   Future<XFile?> takePicture() async {
// //     if (_controller == null ||
// //         !_controller!.value.isInitialized ||
// //         _controller!.value.isTakingPicture) {
// //       return null;
// //     }
// //     try {
// //       XFile file = await _controller!.takePicture();
// //       return file;
// //     } on CameraException catch (e) {
// //       print('Error occurred while taking picture: $e');
// //       return null;
// //     }
// //   }
// // }
// //==========================================================================================================================

// // import 'dart:io';
// // import 'package:camera/camera.dart';
// // import 'package:field_king/Pages/global.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter/services.dart';
// // import 'package:path_provider/path_provider.dart';
// // import 'image_gallery_screen.dart'; // Ensure this is the correct import for your file
// // import 'package:field_king/Pages/camera_homepage.dart'; // Import the previous page

// // class CameraScreen extends StatefulWidget {
// //   const CameraScreen({super.key});

// //   @override
// //   State<CameraScreen> createState() => _CameraScreenState();
// // }

// // class _CameraScreenState extends State<CameraScreen>
// //     with WidgetsBindingObserver {
// //   CameraController? _controller;
// //   bool _isCameraInitialized = false;
// //   late List<CameraDescription> _cameras;

// //   FlashMode _currentFlashMode = FlashMode.auto; // Set default to auto

// //   bool _isRearCameraSelected = true;
// //   String? _imagePath;
// //   List<String> _capturedImages = [];
// //   bool _showCapturedImages = false;

// //   @override
// //   void initState() {
// //     super.initState();
// //     WidgetsBinding.instance.addObserver(this);
// //     SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
// //     _initializeCameras();
// //   }

// //   Future<void> _initializeCameras() async {
// //     _cameras = await availableCameras();
// //     if (_cameras.isNotEmpty) {
// //       onNewCameraSelected(_cameras[0]);
// //     }
// //   }

// //   void onNewCameraSelected(CameraDescription cameraDescription) async {
// //     final previousCameraController = _controller;
// //     final CameraController cameraController = CameraController(
// //       cameraDescription,
// //       ResolutionPreset.high,
// //       imageFormatGroup: ImageFormatGroup.jpeg,
// //     );

// //     await previousCameraController?.dispose();

// //     if (mounted) {
// //       setState(() {
// //         _controller = cameraController;
// //       });
// //     }

// //     cameraController.addListener(() {
// //       if (mounted) setState(() {});
// //     });

// //     try {
// //       await cameraController.initialize();
// //     } on CameraException catch (e) {
// //       print('Error initializing camera: $e');
// //     }

// //     if (mounted) {
// //       setState(() {
// //         _isCameraInitialized = cameraController.value.isInitialized;
// //       });
// //     }
// //   }

// //   @override
// //   void dispose() {
// //     WidgetsBinding.instance.removeObserver(this);
// //     _controller?.dispose();
// //     super.dispose();
// //   }

// //   @override
// //   void didChangeAppLifecycleState(AppLifecycleState state) {
// //     final CameraController? cameraController = _controller;

// //     if (cameraController == null || !cameraController.value.isInitialized) {
// //       return;
// //     }

// //     if (state == AppLifecycleState.inactive) {
// //       cameraController.dispose();
// //     } else if (state == AppLifecycleState.resumed) {
// //       onNewCameraSelected(cameraController.description);
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return WillPopScope(
// //       onWillPop: () async {
// //         Navigator.of(context).pop();
// //         return false;
// //       },
// //       child: Scaffold(
// //         appBar: AppBar(
// //           leadingWidth: 0,
// //           leading: Container(),
// //           title: Row(
// //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //             mainAxisSize: MainAxisSize.max,
// //             children: [
// //               Icon(
// //                 Icons.close,
// //               ),
// //               Row(
// //                 children: [
// //                   InkWell(
// //                     onTap: () {
// //                       setState(() {
// //                         _isCameraInitialized = false;
// //                       });
// //                       onNewCameraSelected(
// //                         _cameras[_isRearCameraSelected ? 0 : 1],
// //                       );
// //                       setState(() {
// //                         _isRearCameraSelected = !_isRearCameraSelected;
// //                       });
// //                     },
// //                     child: Icon(
// //                       Icons.cameraswitch_outlined,
// //                       color: Colors.black,
// //                       size: 30,
// //                     ),
// //                   ),
// //                   SizedBox(
// //                     width: 10,
// //                   ),
// //                   InkWell(
// //                     onTap: () async {
// //                       setState(() {
// //                         if (_currentFlashMode == FlashMode.auto) {
// //                           _currentFlashMode = FlashMode.always;
// //                         } else {
// //                           _currentFlashMode = FlashMode.auto;
// //                         }
// //                       });
// //                       await _controller!.setFlashMode(_currentFlashMode);
// //                     },
// //                     child: Icon(
// //                       _currentFlashMode == FlashMode.auto
// //                           ? Icons.flash_auto
// //                           : Icons.flash_on,
// //                       color: _currentFlashMode != FlashMode.off
// //                           ? Colors.amber
// //                           : Colors.black,
// //                     ),
// //                   ),
// //                 ],
// //               )
// //             ],
// //           ),
// //         ),
// //         body: Column(
// //           children: [
// //             _isCameraInitialized
// //                 ? Stack(
// //                     alignment: Alignment.topRight,
// //                     children: [
// //                       AspectRatio(
// //                         aspectRatio: 1 / _controller!.value.aspectRatio,
// //                         child: _showCapturedImages && _imagePath != null
// //                             ? Image.file(File(_imagePath!))
// //                             : CameraPreview(_controller!),
// //                       ),
// //                     ],
// //                   )
// //                 : Container(),
// //             Padding(
// //               padding: const EdgeInsets.symmetric(
// //                 horizontal: 20,
// //                 vertical: 10,
// //               ),
// //               child: Row(
// //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                 children: [
// //                   GestureDetector(
// //                     onTap: () {
// //                       if (_capturedImages.isNotEmpty) {
// //                         Navigator.push(
// //                           context,
// //                           MaterialPageRoute(
// //                             builder: (context) =>
// //                                 ImagePreviewPage(images: _capturedImages),
// //                           ),
// //                         );
// //                       }
// //                     },
// //                     child: Container(
// //                       color: Colors.yellow,
// //                       padding: EdgeInsets.all(20),
// //                       child: Text('${_capturedImages.length}'),
// //                     ),
// //                   ),
// //                   GestureDetector(
// //                     onTap: () async {
// //                       XFile? rawImage = await takePicture();
// //                       if (rawImage != null) {
// //                         File imageFile = File(rawImage.path);

// //                         int currentUnix = DateTime.now().millisecondsSinceEpoch;
// //                         final directory =
// //                             await getApplicationDocumentsDirectory();
// //                         String fileFormat = imageFile.path.split('.').last;

// //                         String newFilePath =
// //                             '${directory.path}/$currentUnix.$fileFormat';
// //                         await imageFile.copy(newFilePath);

// //                         setState(() {
// //                           _imagePath = newFilePath;
// //                           _showCapturedImages = true;
// //                         });

// //                         await Future.delayed(Duration(seconds: 3));

// //                         setState(() {
// //                           _capturedImages.add(newFilePath);
// //                           _showCapturedImages = false;
// //                         });
// //                       }
// //                     },
// //                     child: Icon(
// //                       Icons.camera,
// //                       size: 40,
// //                     ),
// //                   ),
// //                   GestureDetector(
// //                     onTap: () {
// //                       capturedImages = List.from(_capturedImages);
// //                       Navigator.of(context).pop();
// //                     },
// //                     child: Text(
// //                       'END',
// //                       style: TextStyle(
// //                         fontSize: 20,
// //                       ),
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   Future<XFile?> takePicture() async {
// //     if (_controller == null ||
// //         !_controller!.value.isInitialized ||
// //         _controller!.value.isTakingPicture) {
// //       return null;
// //     }
// //     try {
// //       XFile file = await _controller!.takePicture();
// //       return file;
// //     } on CameraException catch (e) {
// //       print('Error occurred while taking picture: $e');
// //       return null;
// //     }
// //   }
// // }

// // import 'dart:io';
// // import 'package:camera/camera.dart';
// // import 'package:field_king/Pages/global.dart';
// // import 'package:field_king/Pages/view_gallery.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter/services.dart';
// // import 'package:path_provider/path_provider.dart';
// // import 'image_gallery_screen.dart';

// // class CameraScreen extends StatefulWidget {
// //   const CameraScreen({super.key});

// //   @override
// //   State<CameraScreen> createState() => _CameraScreenState();
// // }

// // class _CameraScreenState extends State<CameraScreen>
// //     with WidgetsBindingObserver {
// //   CameraController? _controller;
// //   bool _isCameraInitialized = false;
// //   late List<CameraDescription> _cameras;

// //   FlashMode _currentFlashMode = FlashMode.auto; // Set default to auto

// //   bool _isRearCameraSelected = true;
// //   String? _imagePath;
// //   List<String> _capturedImages = [];
// //   bool _showCapturedImages = false;

// //   @override
// //   void initState() {
// //     super.initState();
// //     WidgetsBinding.instance.addObserver(this);
// //     SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
// //     _initializeCameras();
// //   }

// //   Future<void> _initializeCameras() async {
// //     _cameras = await availableCameras();
// //     if (_cameras.isNotEmpty) {
// //       onNewCameraSelected(_cameras[0]);
// //     }
// //   }

// //   void onNewCameraSelected(CameraDescription cameraDescription) async {
// //     final previousCameraController = _controller;
// //     final CameraController cameraController = CameraController(
// //       cameraDescription,
// //       ResolutionPreset.high,
// //       imageFormatGroup: ImageFormatGroup.jpeg,
// //     );

// //     await previousCameraController?.dispose();

// //     if (mounted) {
// //       setState(() {
// //         _controller = cameraController;
// //       });
// //     }

// //     cameraController.addListener(() {
// //       if (mounted) setState(() {});
// //     });

// //     try {
// //       await cameraController.initialize();
// //     } on CameraException catch (e) {
// //       print('Error initializing camera: $e');
// //     }

// //     if (mounted) {
// //       setState(() {
// //         _isCameraInitialized = cameraController.value.isInitialized;
// //       });
// //     }
// //   }

// //   @override
// //   void dispose() {
// //     WidgetsBinding.instance.removeObserver(this);
// //     _controller?.dispose();
// //     super.dispose();
// //   }

// //   @override
// //   void didChangeAppLifecycleState(AppLifecycleState state) {
// //     final CameraController? cameraController = _controller;

// //     if (cameraController == null || !cameraController.value.isInitialized) {
// //       return;
// //     }

// //     if (state == AppLifecycleState.inactive) {
// //       cameraController.dispose();
// //     } else if (state == AppLifecycleState.resumed) {
// //       onNewCameraSelected(cameraController.description);
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return WillPopScope(
// //       onWillPop: () async {
// //         Navigator.of(context).pop();
// //         return false;
// //       },
// //       child: Scaffold(
// //         appBar: AppBar(
// //           leadingWidth: 0,
// //           leading: Container(),
// //           title: Row(
// //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //             mainAxisSize: MainAxisSize.max,
// //             children: [
// //               InkWell(
// //                 onTap: () {
// //                   Navigator.pop(context);
// //                 },
// //                 child: Icon(
// //                   Icons.close,
// //                 ),
// //               ),
// //               Row(
// //                 children: [
// //                   InkWell(
// //                     onTap: () {
// //                       setState(() {
// //                         _isCameraInitialized = false;
// //                       });
// //                       onNewCameraSelected(
// //                         _cameras[_isRearCameraSelected ? 0 : 1],
// //                       );
// //                       setState(() {
// //                         _isRearCameraSelected = !_isRearCameraSelected;
// //                       });
// //                     },
// //                     child: Icon(
// //                       Icons.cameraswitch_outlined,
// //                       color: Colors.black,
// //                       size: 30,
// //                     ),
// //                   ),
// //                   SizedBox(
// //                     width: 10,
// //                   ),
// //                   InkWell(
// //                     onTap: () async {
// //                       setState(() {
// //                         if (_currentFlashMode == FlashMode.auto) {
// //                           _currentFlashMode = FlashMode.always;
// //                         } else {
// //                           _currentFlashMode = FlashMode.auto;
// //                         }
// //                       });
// //                       await _controller!.setFlashMode(_currentFlashMode);
// //                     },
// //                     child: Icon(
// //                       _currentFlashMode == FlashMode.auto
// //                           ? Icons.flash_auto
// //                           : Icons.flash_on,
// //                       color: _currentFlashMode != FlashMode.off
// //                           ? Colors.amber
// //                           : Colors.black,
// //                     ),
// //                   ),
// //                 ],
// //               )
// //             ],
// //           ),
// //         ),
// //         body: Column(
// //           children: [
// //             _isCameraInitialized
// //                 ? Stack(
// //                     alignment: Alignment.topRight,
// //                     children: [
// //                       AspectRatio(
// //                         aspectRatio: 1 / _controller!.value.aspectRatio,
// //                         child: _showCapturedImages && _imagePath != null
// //                             ? Image.file(File(_imagePath!))
// //                             : CameraPreview(_controller!),
// //                       ),
// //                     ],
// //                   )
// //                 : Container(),
// //             Padding(
// //               padding: const EdgeInsets.symmetric(
// //                 horizontal: 20,
// //                 vertical: 10,
// //               ),
// //               child: Row(
// //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                 children: [
// //                   GestureDetector(
// //                     onTap: () {
// //                       if (_capturedImages.isNotEmpty) {
// //                         Navigator.push(
// //                           context,
// //                           MaterialPageRoute(
// //                             builder: (context) =>
// //                                 ViewGallery(images: _capturedImages),
// //                           ),
// //                         );
// //                       }
// //                     },
// //                     child: Container(
// //                       color: Colors.yellow,
// //                       padding: EdgeInsets.all(20),
// //                       child: Text('${_capturedImages.length}'),
// //                     ),
// //                   ),
// //                   GestureDetector(
// //                     onTap: () async {
// //                       XFile? rawImage = await takePicture();
// //                       if (rawImage != null) {
// //                         File imageFile = File(rawImage.path);

// //                         int currentUnix = DateTime.now().millisecondsSinceEpoch;
// //                         final directory =
// //                             await getApplicationDocumentsDirectory();
// //                         String fileFormat = imageFile.path.split('.').last;

// //                         String newFilePath =
// //                             '${directory.path}/$currentUnix.$fileFormat';
// //                         await imageFile.copy(newFilePath);

// //                         setState(() {
// //                           _imagePath = newFilePath;
// //                           _showCapturedImages = true;
// //                         });

// //                         await Future.delayed(Duration(seconds: 3));

// //                         setState(() {
// //                           _capturedImages.add(newFilePath);
// //                           _showCapturedImages = false;
// //                         });
// //                       }
// //                     },
// //                     child: Icon(
// //                       Icons.camera,
// //                       size: 40,
// //                     ),
// //                   ),
// //                   GestureDetector(
// //                     onTap: () {
// //                       capturedImages = List.from(_capturedImages);
// //                       Navigator.of(context).pop();
// //                     },
// //                     child: Text(
// //                       'END',
// //                       style: TextStyle(
// //                         fontSize: 20,
// //                       ),
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   Future<XFile?> takePicture() async {
// //     if (_controller == null ||
// //         !_controller!.value.isInitialized ||
// //         _controller!.value.isTakingPicture) {
// //       return null;
// //     }
// //     try {
// //       XFile file = await _controller!.takePicture();
// //       return file;
// //     } on CameraException catch (e) {
// //       print('Error occurred while taking picture: $e');
// //       return null;
// //     }
// //   }
// // }

// // import 'dart:io';
// // import 'package:camera/camera.dart';
// // import 'package:field_king/Pages/global.dart';
// // import 'package:field_king/Pages/view_gallery.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter/services.dart';
// // import 'package:path_provider/path_provider.dart';
// // import 'image_gallery_screen.dart';

// // class CameraScreen extends StatefulWidget {
// //   const CameraScreen({super.key});

// //   @override
// //   State<CameraScreen> createState() => _CameraScreenState();
// // }

// // class _CameraScreenState extends State<CameraScreen>
// //     with WidgetsBindingObserver {
// //   CameraController? _controller;
// //   bool _isCameraInitialized = false;
// //   late List<CameraDescription> _cameras;

// //   FlashMode _currentFlashMode = FlashMode.auto; // Set default to auto

// //   bool _isRearCameraSelected = true;
// //   String? _imagePath;
// //   List<String> _capturedImages = [];
// //   bool _showCapturedImages = false;

// //   @override
// //   void initState() {
// //     super.initState();
// //     WidgetsBinding.instance.addObserver(this);
// //     SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
// //     _initializeCameras();
// //   }

// //   Future<void> _initializeCameras() async {
// //     _cameras = await availableCameras();
// //     if (_cameras.isNotEmpty) {
// //       onNewCameraSelected(_cameras[0]);
// //     }
// //   }

// //   void onNewCameraSelected(CameraDescription cameraDescription) async {
// //     final previousCameraController = _controller;
// //     final CameraController cameraController = CameraController(
// //       cameraDescription,
// //       ResolutionPreset.high,
// //       imageFormatGroup: ImageFormatGroup.jpeg,
// //     );

// //     await previousCameraController?.dispose();

// //     if (mounted) {
// //       setState(() {
// //         _controller = cameraController;
// //       });
// //     }

// //     cameraController.addListener(() {
// //       if (mounted) setState(() {});
// //     });

// //     try {
// //       await cameraController.initialize();
// //     } on CameraException catch (e) {
// //       print('Error initializing camera: $e');
// //     }

// //     if (mounted) {
// //       setState(() {
// //         _isCameraInitialized = cameraController.value.isInitialized;
// //       });
// //     }
// //   }

// //   @override
// //   void dispose() {
// //     WidgetsBinding.instance.removeObserver(this);
// //     _controller?.dispose();
// //     super.dispose();
// //   }

// //   @override
// //   void didChangeAppLifecycleState(AppLifecycleState state) {
// //     final CameraController? cameraController = _controller;

// //     if (cameraController == null || !cameraController.value.isInitialized) {
// //       return;
// //     }

// //     if (state == AppLifecycleState.inactive) {
// //       cameraController.dispose();
// //     } else if (state == AppLifecycleState.resumed) {
// //       onNewCameraSelected(cameraController.description);
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return WillPopScope(
// //       onWillPop: () async {
// //         Navigator.of(context).pop();
// //         return false;
// //       },
// //       child: Scaffold(
// //         appBar: AppBar(
// //           leadingWidth: 0,
// //           leading: Container(),
// //           title: Row(
// //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //             mainAxisSize: MainAxisSize.max,
// //             children: [
// //               InkWell(
// //                 onTap: () {
// //                   Navigator.pop(context);
// //                 },
// //                 child: Icon(
// //                   Icons.close,
// //                 ),
// //               ),
// //               Row(
// //                 children: [
// //                   InkWell(
// //                     onTap: () {
// //                       setState(() {
// //                         _isCameraInitialized = false;
// //                       });
// //                       onNewCameraSelected(
// //                         _cameras[_isRearCameraSelected ? 1 : 0],
// //                       );
// //                       setState(() {
// //                         _isRearCameraSelected = !_isRearCameraSelected;
// //                       });
// //                     },
// //                     child: Icon(
// //                       Icons.cameraswitch_outlined,
// //                       color: Colors.black,
// //                       size: 30,
// //                     ),
// //                   ),
// //                   SizedBox(
// //                     width: 10,
// //                   ),
// //                   InkWell(
// //                     onTap: () async {
// //                       setState(() {
// //                         if (_currentFlashMode == FlashMode.auto) {
// //                           _currentFlashMode = FlashMode.always;
// //                         } else {
// //                           _currentFlashMode = FlashMode.auto;
// //                         }
// //                       });
// //                       await _controller!.setFlashMode(_currentFlashMode);
// //                     },
// //                     child: Icon(
// //                       _currentFlashMode == FlashMode.auto
// //                           ? Icons.flash_auto
// //                           : Icons.flash_on,
// //                       color: _currentFlashMode != FlashMode.off
// //                           ? Colors.amber
// //                           : Colors.black,
// //                     ),
// //                   ),
// //                 ],
// //               )
// //             ],
// //           ),
// //         ),
// //         body: Column(
// //           children: [
// //             _isCameraInitialized
// //                 ? Stack(
// //                     alignment: Alignment.topRight,
// //                     children: [
// //                       AspectRatio(
// //                         aspectRatio: 1 / _controller!.value.aspectRatio,
// //                         child: _showCapturedImages && _imagePath != null
// //                             ? Image.file(File(_imagePath!))
// //                             : CameraPreview(_controller!),
// //                       ),
// //                     ],
// //                   )
// //                 : Container(
// //                     width: MediaQuery.of(context).size.width,
// //                     height: MediaQuery.of(context).size.height * 0.83,
// //                   ),
// //             Padding(
// //               padding: const EdgeInsets.symmetric(
// //                 horizontal: 20,
// //                 vertical: 10,
// //               ),
// //               child: Row(
// //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                 children: [
// //                   GestureDetector(
// //                     onTap: () {
// //                       if (_capturedImages.isNotEmpty) {
// //                         Navigator.push(
// //                           context,
// //                           MaterialPageRoute(
// //                             builder: (context) =>
// //                                 ViewGallery(images: _capturedImages),
// //                           ),
// //                         );
// //                       }
// //                     },
// //                     child: Container(
// //                       color: Colors.yellow,
// //                       padding: EdgeInsets.all(20),
// //                       child: Text('${_capturedImages.length}'),
// //                     ),
// //                   ),
// //                   GestureDetector(
// //                     onTap: () async {
// //                       XFile? rawImage = await takePicture();
// //                       if (rawImage != null) {
// //                         File imageFile = File(rawImage.path);

// //                         int currentUnix = DateTime.now().millisecondsSinceEpoch;
// //                         final directory =
// //                             await getApplicationDocumentsDirectory();
// //                         String fileFormat = imageFile.path.split('.').last;

// //                         String newFilePath =
// //                             '${directory.path}/$currentUnix.$fileFormat';
// //                         await imageFile.copy(newFilePath);

// //                         setState(() {
// //                           _imagePath = newFilePath;
// //                           _showCapturedImages = true;
// //                         });

// //                         await Future.delayed(Duration(seconds: 3));

// //                         setState(() {
// //                           _capturedImages.add(newFilePath);
// //                           _showCapturedImages = false;
// //                         });
// //                       }
// //                     },
// //                     child: Icon(
// //                       Icons.camera,
// //                       size: 40,
// //                     ),
// //                   ),
// //                   GestureDetector(
// //                     onTap: () {
// //                       // capturedImages = List.from(_capturedImages);
// //                       capturedImages.addAll(_capturedImages);
// //                       Navigator.of(context).pop();
// //                     },
// //                     child: Text(
// //                       'END',
// //                       style: TextStyle(
// //                         fontSize: 20,
// //                       ),
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   Future<XFile?> takePicture() async {
// //     if (_controller == null ||
// //         !_controller!.value.isInitialized ||
// //         _controller!.value.isTakingPicture) {
// //       return null;
// //     }
// //     try {
// //       XFile file = await _controller!.takePicture();
// //       return file;
// //     } on CameraException catch (e) {
// //       print('Error occurred while taking picture: $e');
// //       return null;
// //     }
// //   }
// // }

// // import 'dart:io';
// // import 'package:camera/camera.dart';
// // import 'package:field_king/Pages/global.dart';
// // import 'package:field_king/Pages/view_gallery.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter/services.dart';
// // import 'package:flutter/widgets.dart';
// // import 'package:path_provider/path_provider.dart';
// // import 'image_gallery_screen.dart';
// // import 'crop_image.dart'; // Make sure to import the CropImage class

// // class CameraScreen extends StatefulWidget {
// //   const CameraScreen({super.key});

// //   @override
// //   State<CameraScreen> createState() => _CameraScreenState();
// // }

// // class _CameraScreenState extends State<CameraScreen>
// //     with WidgetsBindingObserver {
// //   CameraController? _controller;
// //   bool _isCameraInitialized = false;
// //   late List<CameraDescription> _cameras;

// //   FlashMode _currentFlashMode = FlashMode.auto; // Set default to auto

// //   bool _isRearCameraSelected = true;
// //   String? _imagePath;
// //   List<String> _capturedImages = [];
// //   bool _showCapturedImages = false;

// //   double _rowPosition = 0;
// //   bool _isAnimatingRow = false;

// //   @override
// //   void initState() {
// //     super.initState();
// //     WidgetsBinding.instance.addObserver(this);
// //     SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
// //     _initializeCameras();
// //   }

// //   Future<void> _initializeCameras() async {
// //     _cameras = await availableCameras();
// //     if (_cameras.isNotEmpty) {
// //       onNewCameraSelected(_cameras[0]);
// //     }
// //   }

// //   void onNewCameraSelected(CameraDescription cameraDescription) async {
// //     final previousCameraController = _controller;
// //     final CameraController cameraController = CameraController(
// //       cameraDescription,
// //       ResolutionPreset.high,
// //       imageFormatGroup: ImageFormatGroup.jpeg,
// //     );

// //     await previousCameraController?.dispose();

// //     if (mounted) {
// //       setState(() {
// //         _controller = cameraController;
// //       });
// //     }

// //     cameraController.addListener(() {
// //       if (mounted) setState(() {});
// //     });

// //     try {
// //       await cameraController.initialize();
// //     } on CameraException catch (e) {
// //       print('Error initializing camera: $e');
// //     }

// //     if (mounted) {
// //       setState(() {
// //         _isCameraInitialized = cameraController.value.isInitialized;
// //       });
// //     }
// //   }

// //   @override
// //   void dispose() {
// //     WidgetsBinding.instance.removeObserver(this);
// //     _controller?.dispose();
// //     super.dispose();
// //   }

// //   @override
// //   void didChangeAppLifecycleState(AppLifecycleState state) {
// //     final CameraController? cameraController = _controller;

// //     if (cameraController == null || !cameraController.value.isInitialized) {
// //       return;
// //     }

// //     if (state == AppLifecycleState.inactive) {
// //       cameraController.dispose();
// //     } else if (state == AppLifecycleState.resumed) {
// //       onNewCameraSelected(cameraController.description);
// //     }
// //   }

// //   void _animateRow() {
// //     setState(() {
// //       _rowPosition = -100;
// //       _isAnimatingRow = true;
// //     });

// //     Future.delayed(Duration(seconds: 2), () {
// //       setState(() {
// //         _rowPosition = 0;
// //         _isAnimatingRow = false;
// //       });
// //     });
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return WillPopScope(
// //       onWillPop: () async {
// //         Navigator.of(context).pop();
// //         return false;
// //       },
// //       child: Scaffold(
// //         appBar: AppBar(
// //           leadingWidth: 0,
// //           leading: Container(),
// //           title: Row(
// //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //             mainAxisSize: MainAxisSize.max,
// //             children: [
// //               InkWell(
// //                 onTap: () {
// //                   Navigator.pop(context);
// //                 },
// //                 child: Icon(
// //                   Icons.close,
// //                 ),
// //               ),
// //               Row(
// //                 children: [
// //                   InkWell(
// //                     onTap: () {
// //                       setState(() {
// //                         _isCameraInitialized = false;
// //                       });
// //                       onNewCameraSelected(
// //                         _cameras[_isRearCameraSelected ? 1 : 0],
// //                       );
// //                       setState(() {
// //                         _isRearCameraSelected = !_isRearCameraSelected;
// //                       });
// //                       _animateRow();
// //                     },
// //                     child: Icon(
// //                       Icons.cameraswitch_outlined,
// //                       color: Colors.black,
// //                       size: 30,
// //                     ),
// //                   ),
// //                   SizedBox(
// //                     width: 10,
// //                   ),
// //                   InkWell(
// //                     onTap: () async {
// //                       setState(() {
// //                         if (_currentFlashMode == FlashMode.auto) {
// //                           _currentFlashMode = FlashMode.always;
// //                         } else {
// //                           _currentFlashMode = FlashMode.auto;
// //                         }
// //                       });
// //                       await _controller!.setFlashMode(_currentFlashMode);
// //                     },
// //                     child: Icon(
// //                       _currentFlashMode == FlashMode.auto
// //                           ? Icons.flash_auto
// //                           : Icons.flash_on,
// //                       color: _currentFlashMode != FlashMode.off
// //                           ? Colors.amber
// //                           : Colors.black,
// //                     ),
// //                   ),
// //                 ],
// //               )
// //             ],
// //           ),
// //         ),
// //         body: Stack(
// //           children: [
// //             Column(
// //               children: [
// //                 _isCameraInitialized
// //                     ? Stack(
// //                         alignment: Alignment.topRight,
// //                         children: [
// //                           AspectRatio(
// //                             aspectRatio: 1 / _controller!.value.aspectRatio,
// //                             child: _showCapturedImages && _imagePath != null
// //                                 ? Image.file(File(_imagePath!))
// //                                 : CameraPreview(_controller!),
// //                           ),
// //                         ],
// //                       )
// //                     : Container(
// //                         width: MediaQuery.of(context).size.width,
// //                         height: MediaQuery.of(context).size.height * 0.83,
// //                       ),
// //                 AnimatedPositioned(
// //                   duration: Duration(milliseconds: 300),
// //                   bottom: _isAnimatingRow ? _rowPosition : 0,
// //                   left: 0,
// //                   right: 0,
// //                   child: Padding(
// //                     padding: const EdgeInsets.symmetric(
// //                       horizontal: 20,
// //                       vertical: 10,
// //                     ),
// //                     child: Row(
// //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                       children: [
// //                         GestureDetector(
// //                           onTap: () {
// //                             if (_capturedImages.isNotEmpty) {
// //                               Navigator.push(
// //                                 context,
// //                                 MaterialPageRoute(
// //                                   builder: (context) =>
// //                                       ViewGallery(images: _capturedImages),
// //                                 ),
// //                               );
// //                             }
// //                           },
// //                           child: Container(
// //                             color: Colors.yellow,
// //                             padding: EdgeInsets.all(20),
// //                             child: Text('${_capturedImages.length}'),
// //                           ),
// //                         ),
// //                         GestureDetector(
// //                           onTap: () async {
// //                             XFile? rawImage = await takePicture();
// //                             if (rawImage != null) {
// //                               File imageFile = File(rawImage.path);

// //                               int currentUnix =
// //                                   DateTime.now().millisecondsSinceEpoch;
// //                               final directory =
// //                                   await getApplicationDocumentsDirectory();
// //                               String fileFormat =
// //                                   imageFile.path.split('.').last;

// //                               String newFilePath =
// //                                   '${directory.path}/$currentUnix.$fileFormat';
// //                               await imageFile.copy(newFilePath);

// //                               setState(() {
// //                                 _imagePath = newFilePath;
// //                                 _showCapturedImages = true;
// //                               });

// //                               // Navigate to the CropImage screen and get the cropped image
// //                               final croppedImage = await Navigator.push(
// //                                 context,
// //                                 MaterialPageRoute(
// //                                   builder: (context) =>
// //                                       CropImage(image: newFilePath),
// //                                 ),
// //                               );

// //                               if (croppedImage != null &&
// //                                   croppedImage is String) {
// //                                 setState(() {
// //                                   _capturedImages.add(croppedImage);
// //                                   _showCapturedImages = false;
// //                                 });
// //                               } else {
// //                                 setState(() {
// //                                   _showCapturedImages = false;
// //                                 });
// //                               }
// //                             }
// //                           },
// //                           child: Icon(
// //                             Icons.camera,
// //                             size: 40,
// //                           ),
// //                         ),
// //                         GestureDetector(
// //                           onTap: () {
// //                             capturedImages = List.from(_capturedImages);
// //                             Navigator.of(context).pop();
// //                           },
// //                           child: Text(
// //                             'END',
// //                             style: TextStyle(
// //                               fontSize: 20,
// //                             ),
// //                           ),
// //                         ),
// //                       ],
// //                     ),
// //                   ),
// //                 ),
// //               ],
// //             ),
// //             // AnimatedPositioned(
// //             //   duration: Duration(milliseconds: 300),
// //             //   bottom: _isAnimatingRow ? _rowPosition : 0,
// //             //   left: 0,
// //             //   right: 0,
// //             //   child: Padding(
// //             //     padding: const EdgeInsets.symmetric(
// //             //       horizontal: 20,
// //             //       vertical: 10,
// //             //     ),
// //             //     child: Row(
// //             //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //             //       children: [
// //             //         GestureDetector(
// //             //           onTap: () {
// //             //             if (_capturedImages.isNotEmpty) {
// //             //               Navigator.push(
// //             //                 context,
// //             //                 MaterialPageRoute(
// //             //                   builder: (context) =>
// //             //                       ViewGallery(images: _capturedImages),
// //             //                 ),
// //             //               );
// //             //             }
// //             //           },
// //             //           child: Container(
// //             //             color: Colors.yellow,
// //             //             padding: EdgeInsets.all(20),
// //             //             child: Text('${_capturedImages.length}'),
// //             //           ),
// //             //         ),
// //             //         GestureDetector(
// //             //           onTap: () async {
// //             //             XFile? rawImage = await takePicture();
// //             //             if (rawImage != null) {
// //             //               File imageFile = File(rawImage.path);

// //             //               int currentUnix =
// //             //                   DateTime.now().millisecondsSinceEpoch;
// //             //               final directory =
// //             //                   await getApplicationDocumentsDirectory();
// //             //               String fileFormat = imageFile.path.split('.').last;

// //             //               String newFilePath =
// //             //                   '${directory.path}/$currentUnix.$fileFormat';
// //             //               await imageFile.copy(newFilePath);

// //             //               setState(() {
// //             //                 _imagePath = newFilePath;
// //             //                 _showCapturedImages = true;
// //             //               });

// //             //               // Navigate to the CropImage screen and get the cropped image
// //             //               final croppedImage = await Navigator.push(
// //             //                 context,
// //             //                 MaterialPageRoute(
// //             //                   builder: (context) => CropImage(image: newFilePath),
// //             //                 ),
// //             //               );

// //             //               if (croppedImage != null && croppedImage is String) {
// //             //                 setState(() {
// //             //                   _capturedImages.add(croppedImage);
// //             //                   _showCapturedImages = false;
// //             //                 });
// //             //               } else {
// //             //                 setState(() {
// //             //                   _showCapturedImages = false;
// //             //                 });
// //             //               }
// //             //             }
// //             //           },
// //             //           child: Icon(
// //             //             Icons.camera,
// //             //             size: 40,
// //             //           ),
// //             //         ),
// //             //         GestureDetector(
// //             //           onTap: () {
// //             //             capturedImages = List.from(_capturedImages);
// //             //             Navigator.of(context).pop();
// //             //           },
// //             //           child: Text(
// //             //             'END',
// //             //             style: TextStyle(
// //             //               fontSize: 20,
// //             //             ),
// //             //           ),
// //             //         ),
// //             //       ],
// //             //     ),
// //             //   ),
// //             // ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   Future<XFile?> takePicture() async {
// //     if (!_controller!.value.isInitialized) {
// //       return null;
// //     }
// //     if (_controller!.value.isTakingPicture) {
// //       return null;
// //     }

// //     try {
// //       return await _controller!.takePicture();
// //     } on CameraException catch (e) {
// //       print('Error occurred while taking picture: $e');
// //       return null;
// //     }
// //   }
// // }

// // import 'dart:io';
// // import 'package:camera/camera.dart';
// // import 'package:field_king/Pages/global.dart';
// // import 'package:field_king/Pages/view_gallery.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter/services.dart';
// // import 'package:path_provider/path_provider.dart';
// // import 'crop_image.dart';

// // class CameraScreen extends StatefulWidget {
// //   const CameraScreen({super.key});

// //   @override
// //   State<CameraScreen> createState() => _CameraScreenState();
// // }

// // class _CameraScreenState extends State<CameraScreen>
// //     with WidgetsBindingObserver {
// //   bool _isRearCameraSelected = true;
// //   FlashMode _currentFlashMode = FlashMode.auto;
// //   CameraController? _controller;
// //   bool _isCameraInitialized = false;
// //   late List<CameraDescription> _cameras;

// //   String? _imagePath;
// //   List<String> _capturedImages = [];
// //   bool _showCapturedImages = false;

// //   double _rowPosition = 0;

// //   @override
// //   void initState() {
// //     super.initState();
// //     WidgetsBinding.instance.addObserver(this);
// //     SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
// //     _initializeCameras();
// //   }

// //   Future<void> _initializeCameras() async {
// //     _cameras = await availableCameras();
// //     if (_cameras.isNotEmpty) {
// //       onNewCameraSelected(_cameras[0]);
// //     }
// //   }

// //   void onNewCameraSelected(CameraDescription cameraDescription) async {
// //     final previousCameraController = _controller;
// //     final CameraController cameraController = CameraController(
// //       cameraDescription,
// //       ResolutionPreset.high,
// //       imageFormatGroup: ImageFormatGroup.jpeg,
// //     );

// //     await previousCameraController?.dispose();

// //     if (mounted) {
// //       setState(() {
// //         _controller = cameraController;
// //       });
// //     }

// //     cameraController.addListener(() {
// //       if (mounted) setState(() {});
// //     });

// //     try {
// //       await cameraController.initialize();
// //     } on CameraException catch (e) {
// //       print('Error initializing camera: $e');
// //     }

// //     if (mounted) {
// //       setState(() {
// //         _isCameraInitialized = cameraController.value.isInitialized;
// //       });
// //     }
// //   }

// //   @override
// //   void dispose() {
// //     WidgetsBinding.instance.removeObserver(this);
// //     _controller?.dispose();
// //     super.dispose();
// //   }

// //   @override
// //   void didChangeAppLifecycleState(AppLifecycleState state) {
// //     final CameraController? cameraController = _controller;

// //     if (cameraController == null || !cameraController.value.isInitialized) {
// //       return;
// //     }

// //     if (state == AppLifecycleState.inactive) {
// //       cameraController.dispose();
// //     } else if (state == AppLifecycleState.resumed) {
// //       onNewCameraSelected(cameraController.description);
// //     }
// //   }

// // //   void _animateRow() {
// // //     setState(() {
// // //       _rowPosition = -100;
// // //       _isAnimatingRow = true;
// // //     });
// //   @override
// //   Widget build(BuildContext context) {
// //     return WillPopScope(
// //       onWillPop: () async {
// //         Navigator.of(context).pop();
// //         return false;
// //       },
// //       child: Scaffold(
// //         appBar: AppBar(
// //           leadingWidth: 0,
// //           leading: Container(),
// //           title: Row(
// //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //             mainAxisSize: MainAxisSize.max,
// //             children: [
// //               InkWell(
// //                 onTap: () {
// //                   Navigator.pop(context);
// //                 },
// //                 child: Icon(
// //                   Icons.close,
// //                 ),
// //               ),
// //               Row(
// //                 children: [
// //                   InkWell(
// //                     onTap: () {
// //                       setState(() {
// //                         _isCameraInitialized = false;
// //                       });
// //                       onNewCameraSelected(
// //                         _cameras[_isRearCameraSelected ? 1 : 0],
// //                       );
// //                       setState(() {
// //                         _isRearCameraSelected = !_isRearCameraSelected;
// //                       });

// //                       // _animateRow();
// //                     },
// //                     child: Icon(
// //                       Icons.cameraswitch_outlined,
// //                       color: Colors.black,
// //                       size: 30,
// //                     ),
// //                   ),
// //                   SizedBox(
// //                     width: 10,
// //                   ),
// //                   InkWell(
// //                     onTap: () async {
// //                       setState(() {
// //                         if (_currentFlashMode == FlashMode.auto) {
// //                           _currentFlashMode = FlashMode.always;
// //                         } else {
// //                           _currentFlashMode = FlashMode.auto;
// //                         }
// //                       });
// //                       await _controller!.setFlashMode(_currentFlashMode);
// //                     },
// //                     child: Icon(
// //                       _currentFlashMode == FlashMode.auto
// //                           ? Icons.flash_auto
// //                           : Icons.flash_on,
// //                       color: _currentFlashMode != FlashMode.off
// //                           ? Colors.amber
// //                           : Colors.black,
// //                     ),
// //                   ),
// //                 ],
// //               )
// //             ],
// //           ),
// //         ),
// //         body: _isCameraInitialized
// //             ? Stack(
// //                 children: [
// //                   Column(
// //                     children: [
// //                       _isCameraInitialized
// //                           ? Stack(
// //                               alignment: Alignment.topRight,
// //                               children: [
// //                                 AspectRatio(
// //                                   aspectRatio:
// //                                       1 / _controller!.value.aspectRatio,
// //                                   child:
// //                                       _showCapturedImages && _imagePath != null
// //                                           ? Image.file(File(_imagePath!))
// //                                           : CameraPreview(_controller!),
// //                                 ),
// //                               ],
// //                             )
// //                           : Container(
// //                               width: MediaQuery.of(context).size.width,
// //                               height: MediaQuery.of(context).size.height * 0.83,
// //                             ),
// //                       AnimatedPositioned(
// //                         duration: Duration(milliseconds: 300),
// //                         // bottom: _isAnimatingRow ? _rowPosition : 0 ,
// //                         left: 0,
// //                         right: 0,
// //                         child: Padding(
// //                           padding: const EdgeInsets.symmetric(
// //                             horizontal: 20,
// //                             vertical: 10,
// //                           ),
// //                           child: Row(
// //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                             children: [
// //                               GestureDetector(
// //                                 onTap: () {
// //                                   if (_capturedImages.isNotEmpty) {
// //                                     Navigator.push(
// //                                       context,
// //                                       MaterialPageRoute(
// //                                         builder: (context) => ViewGallery(
// //                                             images: _capturedImages),
// //                                       ),
// //                                     );
// //                                   }
// //                                 },
// //                                 child: Container(
// //                                   color: Colors.yellow,
// //                                   padding: EdgeInsets.all(20),
// //                                   child: Text('${_capturedImages.length}'),
// //                                 ),
// //                               ),
// //                               GestureDetector(
// //                                 onTap: () async {
// //                                   XFile? rawImage = await takePicture();
// //                                   if (rawImage != null) {
// //                                     File imageFile = File(rawImage.path);

// //                                     int currentUnix =
// //                                         DateTime.now().millisecondsSinceEpoch;
// //                                     final directory =
// //                                         await getApplicationDocumentsDirectory();
// //                                     String fileFormat =
// //                                         imageFile.path.split('.').last;

// //                                     String newFilePath =
// //                                         '${directory.path}/$currentUnix.$fileFormat';
// //                                     await imageFile.copy(newFilePath);

// //                                     setState(() {
// //                                       _imagePath = newFilePath;
// //                                       _showCapturedImages = true;
// //                                     });

// //                                     // Navigate to the CropImage screen and get the cropped image
// //                                     final croppedImage = await Navigator.push(
// //                                       context,
// //                                       MaterialPageRoute(
// //                                         builder: (context) =>
// //                                             CropImage(image: newFilePath),
// //                                       ),
// //                                     );

// //                                     if (croppedImage != null &&
// //                                         croppedImage is String) {
// //                                       setState(() {
// //                                         _capturedImages.add(croppedImage);
// //                                         _showCapturedImages = false;
// //                                       });
// //                                     } else {
// //                                       setState(() {
// //                                         _showCapturedImages = false;
// //                                       });
// //                                     }
// //                                   }
// //                                 },
// //                                 child: Icon(
// //                                   Icons.camera,
// //                                   size: 40,
// //                                 ),
// //                               ),
// //                               GestureDetector(
// //                                 onTap: () {
// //                                   // capturedImages = List.from(_capturedImages);
// //                                   capturedImages.addAll(_capturedImages);
// //                                   Navigator.of(context).pop();
// //                                 },
// //                                 child: Text(
// //                                   'END',
// //                                   style: TextStyle(
// //                                     fontSize: 20,
// //                                   ),
// //                                 ),
// //                               ),
// //                             ],
// //                           ),
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                 ],
// //               )
// //             : Center(
// //                 child: CircularProgressIndicator(),
// //               ),
// //       ),
// //     );
// //   }

// //   Future<XFile?> takePicture() async {
// //     if (!_controller!.value.isInitialized) {
// //       return null;
// //     }
// //     if (_controller!.value.isTakingPicture) {
// //       return null;
// //     }

// //     try {
// //       return await _controller!.takePicture();
// //     } on CameraException catch (e) {
// //       print('Error occurred while taking picture: $e');
// //       return null;
// //     }
// //   }
// // }






// import 'dart:io';
// import 'package:camera/camera.dart';
// import 'package:field_king/Pages/global.dart';
// import 'package:field_king/Pages/view_gallery.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:path_provider/path_provider.dart';
// import 'crop_image.dart';

// class CameraScreen extends StatefulWidget {
//   const CameraScreen({super.key});

//   @override
//   State<CameraScreen> createState() => _CameraScreenState();
// }

// class _CameraScreenState extends State<CameraScreen> with WidgetsBindingObserver {
//   bool _isRearCameraSelected = true;
//   FlashMode _currentFlashMode = FlashMode.auto;
//   CameraController? _controller;
//   bool _isCameraInitialized = false;
//   late List<CameraDescription> _cameras;

//   String? _imagePath;
//   List<String> _capturedImages = [];
//   bool _showCapturedImages = false;

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addObserver(this);
//     SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
//     _initializeCameras();
//   }

//   Future<void> _initializeCameras() async {
//     _cameras = await availableCameras();
//     if (_cameras.isNotEmpty) {
//       onNewCameraSelected(_cameras[0]);
//     }
//   }

//   void onNewCameraSelected(CameraDescription cameraDescription) async {
//     final previousCameraController = _controller;
//     final CameraController cameraController = CameraController(
//       cameraDescription,
//       ResolutionPreset.high,
//       imageFormatGroup: ImageFormatGroup.jpeg,
//     );

//     await previousCameraController?.dispose();

//     if (mounted) {
//       setState(() {
//         _controller = cameraController;
//       });
//     }

//     cameraController.addListener(() {
//       if (mounted) setState(() {});
//     });

//     try {
//       await cameraController.initialize();
//     } on CameraException catch (e) {
//       print('Error initializing camera: $e');
//     }

//     if (mounted) {
//       setState(() {
//         _isCameraInitialized = cameraController.value.isInitialized;
//       });
//     }
//   }

//   @override
//   void dispose() {
//     WidgetsBinding.instance.removeObserver(this);
//     _controller?.dispose();
//     super.dispose();
//   }

//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     final CameraController? cameraController = _controller;

//     if (cameraController == null || !cameraController.value.isInitialized) {
//       return;
//     }

//     if (state == AppLifecycleState.inactive) {
//       cameraController.dispose();
//     } else if (state == AppLifecycleState.resumed) {
//       onNewCameraSelected(cameraController.description);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         Navigator.of(context).pop();
//         return false;
//       },
//       child: Scaffold(
//         appBar: AppBar(
//           leadingWidth: 0,
//           leading: Container(),
//           title: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             mainAxisSize: MainAxisSize.max,
//             children: [
//               InkWell(
//                 onTap: () {
//                   Navigator.pop(context);
//                 },
//                 child: Icon(
//                   Icons.close,
//                 ),
//               ),
//               Row(
//                 children: [
//                   InkWell(
//                     onTap: () {
//                       setState(() {
//                         _isCameraInitialized = false;
//                       });
//                       onNewCameraSelected(
//                         _cameras[_isRearCameraSelected ? 1 : 0],
//                       );
//                       setState(() {
//                         _isRearCameraSelected = !_isRearCameraSelected;
//                       });
//                     },
//                     child: Icon(
//                       Icons.cameraswitch_outlined,
//                       color: Colors.black,
//                       size: 30,
//                     ),
//                   ),
//                   SizedBox(
//                     width: 10,
//                   ),
//                   InkWell(
//                     onTap: () async {
//                       setState(() {
//                         if (_currentFlashMode == FlashMode.auto) {
//                           _currentFlashMode = FlashMode.always;
//                         } else {
//                           _currentFlashMode = FlashMode.auto;
//                         }
//                       });
//                       await _controller!.setFlashMode(_currentFlashMode);
//                     },
//                     child: Icon(
//                       _currentFlashMode == FlashMode.auto
//                           ? Icons.flash_auto
//                           : Icons.flash_on,
//                       color: _currentFlashMode != FlashMode.off
//                           ? Colors.amber
//                           : Colors.black,
//                     ),
//                   ),
//                 ],
//               )
//             ],
//           ),
//         ),
//         body: _isCameraInitialized
//             ? Stack(
//                 children: [
//                   Column(
//                     children: [
//                       _isCameraInitialized
//                           ? Stack(
//                               alignment: Alignment.topRight,
//                               children: [
//                                 AspectRatio(
//                                   aspectRatio:
//                                       1 / _controller!.value.aspectRatio,
//                                   child:
//                                       _showCapturedImages && _imagePath != null
//                                           ? Image.file(File(_imagePath!))
//                                           : CameraPreview(_controller!),
//                                 ),
//                               ],
//                             )
//                           : Container(
//                               width: MediaQuery.of(context).size.width,
//                               height: MediaQuery.of(context).size.height * 0.83,
//                             ),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(
//                           horizontal: 20,
//                           vertical: 10,
//                         ),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             GestureDetector(
//                               onTap: () {
//                                 if (_capturedImages.isNotEmpty) {
//                                   Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                       builder: (context) =>
//                                           ViewGallery(images: _capturedImages),
//                                     ),
//                                   );
//                                 }
//                               },
//                               child: Container(
//                                 color: Colors.yellow,
//                                 padding: EdgeInsets.all(20),
//                                 child: Text('${_capturedImages.length}'),
//                               ),
//                             ),
//                             GestureDetector(
//                               onTap: () async {
//                                 XFile? rawImage = await takePicture();
//                                 if (rawImage != null) {
//                                   File imageFile = File(rawImage.path);

//                                   int currentUnix =
//                                       DateTime.now().millisecondsSinceEpoch;
//                                   final directory =
//                                       await getApplicationDocumentsDirectory();
//                                   String fileFormat =
//                                       imageFile.path.split('.').last;

//                                   String newFilePath =
//                                       '${directory.path}/$currentUnix.$fileFormat';
//                                   await imageFile.copy(newFilePath);

//                                   setState(() {
//                                     _imagePath = newFilePath;
//                                     _showCapturedImages = true;
//                                   });

//                                   // Navigate to the CropImage screen and get the cropped image
//                                   final croppedImage = await Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                       builder: (context) =>
//                                           CropImage(image: newFilePath),
//                                     ),
//                                   );

//                                   if (croppedImage != null &&
//                                       croppedImage is String) {
//                                     setState(() {
//                                       _capturedImages.add(croppedImage);
//                                       _showCapturedImages = false;
//                                     });
//                                   } else {
//                                     setState(() {
//                                       _showCapturedImages = false;
//                                     });
//                                   }
//                                 }
//                               },
//                               child: Icon(
//                                 Icons.camera,
//                                 size: 40,
//                               ),
//                             ),
//                             GestureDetector(
//                               onTap: () {
//                                 capturedImages.addAll(_capturedImages);
//                                 Navigator.of(context).pop();
//                               },
//                               child: Text(
//                                 'END',
//                                 style: TextStyle(
//                                   fontSize: 20,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               )
//             : Center(
//                 child: CircularProgressIndicator(),
//               ),
//       ),
//     );
//   }

//   Future<XFile?> takePicture() async {
//     if (!_controller!.value.isInitialized) {
//       return null;
//     }
//     if (_controller!.value.isTakingPicture) {
//       return null;
//     }

//     try {
//       return await _controller!.takePicture();
//     } on CameraException catch (e) {
//       print('Error occurred while taking picture: $e');
//       return null;
//     }
//   }
// }
