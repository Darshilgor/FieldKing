// import 'package:field_king/Pages/camera_homepage.dart';
// import 'package:field_king/Pages/global.dart';
// import 'package:field_king/Pages/image_gallery_screen.dart';
// import 'package:field_king/Pages/view_gallery.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class CameraPage extends StatefulWidget {
//   const CameraPage({super.key});

//   @override
//   State<CameraPage> createState() => CameraPageState();
// }

// class CameraPageState extends State<CameraPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Camera Page'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             GestureDetector(
//               onTap: () async {
//                 await Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => CameraScreen()),
//                 );
//                 setState(() {});
//               },
//               child: Container(
//                 padding: EdgeInsets.all(20),
//                 color: Colors.red,
//                 child: Text(
//                   'Open Camera',
//                   style: TextStyle(color: Colors.white),
//                 ),
//               ),
//             ),
//             SizedBox(height: 20),
//             capturedImages.isNotEmpty
//                 ? ElevatedButton(
//                     onPressed: () {
//                       Get.to(() => ViewGallery(images: capturedImages));
//                     },
//                     child: Text('View Image'),
//                   )
//                 : Text('No image'),
//           ],
//         ),
//       ),
//     );
//   }
// }
