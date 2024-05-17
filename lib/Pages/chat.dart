import 'package:field_king/services/text_label/text_label.dart';
import 'package:field_king/services/text_style/text_style.dart';
import 'package:flutter/material.dart';

class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          TextLabel.chat,
          style: TextStyleClass.textstyle1,
        ),
      ),
    );
  }
}
