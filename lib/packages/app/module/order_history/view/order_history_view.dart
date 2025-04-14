import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:field_king/services/app_bar.dart';
import 'package:field_king/services/firebase_services/firebase_services.dart';
import 'package:flutter/material.dart';

class OrderHistoryView extends StatelessWidget {
  const OrderHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: Text(
          'Order history',
        ),
        isLeading: true,
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestoreServices.getOrderHistory(),
        builder: (context, snapshot) {
          return ListView.builder(
            itemCount: snapshot.data?.docs.length,
            itemBuilder: (context, index) {
              var order = snapshot.data?.docs[index];
              return Container(
                child: Text(order?['orderId'] ?? ''),
              );
            },
          );
        },
      ),
    );
  }
}
