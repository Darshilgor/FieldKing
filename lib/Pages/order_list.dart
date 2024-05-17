import 'package:field_king/services/text_label/text_label.dart';
import 'package:field_king/services/text_style/text_style.dart';
import 'package:flutter/material.dart';

class OrderList extends StatefulWidget {
  const OrderList({super.key});

  @override
  State<OrderList> createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          TextLabel.orderList,
          style: TextStyleClass.textstyle1,
        ),
      ),
    );
  }
}
