import 'package:field_king/services/text_label/text_label.dart';
import 'package:field_king/services/text_style/text_style.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          TextLabel.profile,
          style: TextStyleClass.textstyle1,
        ),
      ),
    );
  }
}
