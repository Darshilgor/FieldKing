import 'dart:io';

import 'package:field_king/Pages/image_gallery_screen.dart';
import 'package:flutter/material.dart';

class ViewGallery extends StatefulWidget {
  final List<dynamic> images;

  const ViewGallery({super.key, required this.images});

  @override
  State<ViewGallery> createState() => _ViewGalleryState();
}

class _ViewGalleryState extends State<ViewGallery> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
        itemCount: widget.images.length,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 10,
            ),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ImagePreviewPage(images: widget.images[index])),
                );
              },
              child: Container(
                child: Image(
                  fit: BoxFit.cover,
                  width: 200,
                  height: 200,
                  image: FileImage(
                    File(
                      widget.images[index],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
