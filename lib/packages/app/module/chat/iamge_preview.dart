import 'package:field_king/components/app_button.dart';
import 'package:field_king/packages/config.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:get/get_core/src/get_main.dart';

class ImagePreviewScreen extends StatelessWidget {
  final List<File> imageFiles;
  final VoidCallback onSend;

  ImagePreviewScreen({
    Key? key,
    required this.imageFiles,
    required this.onSend,
  }) : super(key: key);

  PageController pageController = PageController();
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.whiteColor,
        body: Container(
          color: Colors.black,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 20,
                  ),
                  child: PageView.builder(
                    controller: pageController,
                    itemCount: imageFiles.length,
                    onPageChanged: (index) {
                      currentIndex = index;
                    },
                    itemBuilder: (context, index) {
                      return Center(
                        child: Image.file(
                          imageFiles[index],
                          fit: BoxFit.contain,
                        ),
                      );
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 10,
                  right: 10,
                  top: 10,
                ),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: GestureDetector(
                    onTap: onSend,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.circle,
                      ),
                      padding: EdgeInsets.all(
                        13,
                      ),
                      child: Icon(
                        Icons.send,
                        color: AppColor.whiteColor,
                        size: 25,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
