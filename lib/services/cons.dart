import 'package:flutter/material.dart';

double screenwidth = 0;
double screenheight = 0;
const Color bgcolor1 = Color.fromARGB(255, 147, 147, 147);

const Color bgcolor2 = Color.fromARGB(255, 177, 177, 177);

const Color whitecolor = Colors.white;

class ScreenSize {
  screensize(BuildContext context) {
    screenwidth = MediaQuery.of(context).size.width;
    screenheight = MediaQuery.of(context).size.height;
  }
}
