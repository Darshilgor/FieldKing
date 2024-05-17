import 'dart:io';

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class ImagePreviewPage extends StatefulWidget {
  ImagePreviewPage({
    required this.images,
    this.initialIndex = 0,
    super.key,
  }) : pageController = PageController(initialPage: initialIndex);

  var images;
  final int initialIndex;
  final PageController pageController;

  @override
  State<ImagePreviewPage> createState() => _ImagePreviewPageState();
}

class _ImagePreviewPageState extends State<ImagePreviewPage> {
  @override
  Widget build(BuildContext context) {
    return PhotoViewGallery(
      scrollPhysics: const BouncingScrollPhysics(),
      pageOptions: [
        PhotoViewGalleryPageOptions(
          imageProvider: FileImage(File(widget.images)),
          initialScale: PhotoViewComputedScale.contained * 1,
        ),
      ],
      loadingBuilder: (context, event) => const Center(
        child: SizedBox(
          width: 30.0,
          height: 30.0,
          child: CircularProgressIndicator(),
        ),
      ),
      // pageController: widget.pageController,
    );
  }
}
