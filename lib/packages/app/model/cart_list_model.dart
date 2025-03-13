import 'package:cloud_firestore/cloud_firestore.dart';

class CartItem {
  String? amp;
  String? chipestPrice;
  String? flat;
  String? gej;
  String? orderMeter;
  String? orderType;
  String? price;
  String? size;
  String? type;

  CartItem({
    this.amp,
    this.chipestPrice,
    this.flat,
    this.gej,
    this.orderMeter,
    this.orderType,
    this.price,
    this.size,
    this.type,
  });

  factory CartItem.fromMap(Map<String, dynamic> data) {
    return CartItem(
      amp: data['amp'] as String?,
      chipestPrice: data['chipestPrice'] as String?,
      flat: data['flat'] as String?,
      gej: data['gej'] as String?,
      orderMeter: data['orderMeter'] as String?,
      orderType: data['orderType'] as String?,
      price: data['price'] as String?,
      size: data['size'] as String?,
      type: data['type'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'amp': amp,
      'chipestPrice': chipestPrice,
      'flat': flat,
      'gej': gej,
      'orderMeter': orderMeter,
      'orderType': orderType,
      'price': price,
      'size': size,
      'type': type,
    };
  }
}

class CartModel {
  List<CartItem>? cartList;
  Timestamp? createdAt;
  Timestamp? updatedAt;

  CartModel({
    this.cartList,
    this.createdAt,
    this.updatedAt,
  });
factory CartModel.fromFirestore(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>?;

    if (data == null) {
      return CartModel(cartList: [], createdAt: null, updatedAt: null);
    }

    return CartModel(
      cartList: (data['cartList'] as List<dynamic>?)
          ?.map((item) => CartItem.fromMap(item as Map<String, dynamic>))
          .toList(),
      createdAt: data['createdAt'] as Timestamp?,
      updatedAt: data['updatedAt'] as Timestamp?,
    );
  }
  factory CartModel.fromMap(Map<String, dynamic> data) {
    return CartModel(
      cartList: (data['cartList'] as List<dynamic>?)
          ?.map((item) => CartItem.fromMap(item as Map<String, dynamic>))
          .toList(),
      createdAt: data['createdAt'],
      updatedAt: data['updatedAt'],
    );
  }
}
