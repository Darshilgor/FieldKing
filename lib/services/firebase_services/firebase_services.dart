import 'dart:convert';
import 'dart:core';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:field_king/packages/app/model/cart_list_model.dart';
import 'package:field_king/packages/app/model/createCartModel.dart';
import 'package:field_king/packages/app/model/get_product_model.dart';
import 'package:field_king/packages/app/model/order_history_model.dart';
import 'package:field_king/packages/app/model/user_chat_model.dart';
import 'package:field_king/packages/config.dart';
import 'package:field_king/services/general_controller/general_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:core' as core;

class FirebaseAuthServices {
  static Future<void> sendOTP({
    required String phoneNumber,
    required Function(String verificationId) onCodeSent,
    required Function(FirebaseAuthException e) onError,
  }) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    await auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: core.Duration(seconds: 60),
      verificationCompleted: (PhoneAuthCredential credential) {
        auth.signInWithCredential(credential).then(
          (user) {
            print(
                "Phone number automatically verified and user signed in: ${user.user?.uid}");
          },
        );
      },
      verificationFailed: (FirebaseAuthException e) {
        onError(e);
      },
      codeSent: (String verificationId, int? resendToken) {
        print("Verification ID: $verificationId");
        onCodeSent(verificationId);
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        print("Verification code retrieval timed out: $verificationId");
      },
    );
  }

  static Future<void> verifyOTP({
    required String verificationId,
    required String otp,
    required Function(User? user) onVerified,
    required Function(FirebaseAuthException e) onError,
  }) async {
    final FirebaseAuth auth = FirebaseAuth.instance;

    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otp,
      );

      UserCredential userCredential =
          await auth.signInWithCredential(credential);

      onVerified(userCredential.user);
    } on FirebaseAuthException catch (e) {
      onError(e);
    }
  }
}

class FirebaseFirestoreServices {
  static final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  /// add user details to firestore on sign up.
  static Future<void> addUserDetails({
    String? brandName,
    String? firstName,
    String? lastName,
    String? phoneNumber,
    String? address,
  }) async {
    Map<String, dynamic> user = {
      'brandName': brandName,
      'createdAt': FieldValue.serverTimestamp(),
      'deviceId': Preference.fcmToken,
      'firstName': firstName,
      'lastName': lastName,
      'phoneNo': phoneNumber,
      'profilePhoto': '',
      'totalOrderAmount': '',
      'totalOrderMeter': '',
      'userId': '',
      'address': address,
      'userType': (phoneNumber == '9409529203' || phoneNumber == '9426781202')
          ? 'Admin'
          : 'User',
      'contactList': [],
    };
    DocumentReference documentref =
        await firebaseFirestore.collection('Users').add(user);
    await documentref.update({'userId': documentref.id});
    Preference.userId = documentref.id;
  }

  /// get is show with out get from firestore.
  static Future<void> getIsShowWithOutGst() async {
    var isShowWithOutGst;
    DocumentSnapshot snapshot = await firebaseFirestore
        .collection('IsShowWithOutGST')
        .doc('IsShowWithOutGST')
        .get();
    isShowWithOutGst = snapshot.data();
    if (isShowWithOutGst['IsShowWithOutGST'] != null) {
      GeneralController.isShowWithOutGst.value =
          isShowWithOutGst['IsShowWithOutGST'];
    } else {
      GeneralController.isShowWithOutGst.value = false;
    }
  }

  /// get product list.
  static Future getProductList() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('Products').get();

    return snapshot.docs.map(
      (doc) {
        final data = doc.data() as Map<String, dynamic>;
        return Product.fromMap(doc.id, data);
      },
    ).toList();
  }

  /// add to cart.
  static Future<void> addToCart({Map<String, dynamic>? cableDetails}) async {
    DocumentReference cartDocRef = FirebaseFirestore.instance
        .collection('Users')
        .doc(Preference.userId)
        .collection('Cart')
        .doc('cart');

    DocumentSnapshot cartDoc = await cartDocRef.get();

    if (cartDoc.exists) {
      List<dynamic> cartList = List.from(cartDoc.get('cartList') ?? []);

      cartList.add(cableDetails);
      await cartDocRef.update(
        {
          'cartList': cartList,
          'updatedAt': Timestamp.now(),
        },
      );
    } else {
      await cartDocRef.set(
        {
          'cartList': [cableDetails],
          'createdAt': Timestamp.now(),
        },
      );
    }
  }

  /// get cart.
  static Future getCart() async {
    print('inside the get cart');
    DocumentSnapshot cartDoc = await firebaseFirestore
        .collection('Users')
        .doc(Preference.userId)
        .collection('Cart')
        .doc('cart')
        .get();
    if (cartDoc.exists) {
      print('cart is exits');
      print(cartDoc.id.length);
      return CartModel.fromMap(cartDoc.data() as Map<String, dynamic>);
    }
    return null;
  }

  /// stream builder of get cart.
  // static Stream<CartModel> getCart() {
  //   print('inside the get cart');
  //   return firebaseFirestore
  //       .collection('Users')
  //       .doc(Preference.userId)
  //       .collection('Cart')
  //       .doc('cart')
  //       .snapshots()
  //       .map((snapshot) => CartModel.fromFirestore(snapshot));
  // }

  // /// add to cart.
  // static Future<void> addToCart({Map<String, dynamic>? cableDetails}) async {
  //   print('Inside add to cart');

  //   if ((cableDetails ?? {}).isEmpty) {
  //     print('Error: cableDetails is empty!');
  //     return;
  //   }

  //   DocumentReference cartDocRef = FirebaseFirestore.instance
  //       .collection('Users')
  //       .doc(Preference.userId)
  //       .collection('Cart')
  //       .doc('cart');

  //   DocumentSnapshot cartDoc = await cartDocRef.get();

  //   if (cartDoc.exists) {
  //     print('Inside the cartdoc exists');
  //     print('Cable details: $cableDetails');

  //     List<dynamic> cartList = List.from(cartDoc.get('cartList') ?? []);
  //     cartList.add(cableDetails);
  //     print('Updated cartList: $cartList');

  //     await cartDocRef.update({
  //       'cartList': cartList,
  //       'updatedAt': Timestamp.now(),
  //     }).then((_) {
  //       print('Cart updated successfully!');
  //     }).catchError((error) {
  //       print('Error updating cart: $error');
  //     });
  //   } else {
  //     print('Cart document does not exist, creating new cart');

  //     await cartDocRef.set({
  //       'cartList': [cableDetails],
  //       'createdAt': Timestamp.now(),
  //     }).then((_) {
  //       print('Cart created successfully!');
  //     }).catchError((error) {
  //       print('Error creating cart: $error');
  //     });
  //   }
  // }
  static Future<bool> deleteCart({int? index}) async {
    DocumentReference cartDoc = await firebaseFirestore
        .collection('Users')
        .doc(Preference.userId)
        .collection('Cart')
        .doc('cart');

    DocumentSnapshot cartSnapshot = await cartDoc.get();
    if (cartSnapshot.exists) {
      List<dynamic> cartList = cartSnapshot['cartList'];

      if ((index ?? 0) < 0 || (index ?? 0) >= cartList.length) {
        return false;
      }

      cartList.removeAt(index ?? 0);

      await cartDoc.update({'cartList': cartList});
      return true;
    } else {
      return false;
    }
  }

  static Future<void> getUser() async {
    DocumentSnapshot userSnapShot = await firebaseFirestore
        .collection('Users')
        .doc(Preference.userId)
        .get();

    Preference.firstName = userSnapShot['firstName'];
    Preference.lastName = userSnapShot['lastName'];
    Preference.brandName = userSnapShot['brandName'];
    Preference.phoneNumber = userSnapShot['phoneNo'];
    Preference.profileImage = userSnapShot['profilePhoto'];
    Preference.totalOrderMeter = userSnapShot['totalOrderMeter'] == ''
        ? '0'
        : userSnapShot['totalOrderMeter'];
    Preference.totalOrderAmount = userSnapShot['totalOrderAmount'] == ''
        ? '0'
        : userSnapShot['totalOrderAmount'];
    Preference.deviceId = userSnapShot['deviceId'];
  }

  /// update profile.
  static Future<void> updateProfile({
    String? profileImage,
    String? firstName,
    String? lastName,
    String? brandName,
    String? phoneNumber,
  }) async {
    await firebaseFirestore.collection('Users').doc(Preference.userId).update({
      'profilePhoto': profileImage,
      'firstName': firstName,
      'lastName': lastName,
      'brandName': brandName,
      'phoneNo': phoneNumber,
    }).then(
      (value) {
        Preference.firstName = firstName;
        Preference.lastName = lastName;
        Preference.brandName = brandName;
        Preference.phoneNumber = phoneNumber;
        Preference.profileImage = profileImage;
      },
    );
  }

  static createOrder({
    Rx<CartModel?>? cart,
    String? firstname,
    String? lastName,
    String? brandName,
    String? phoneNo,
    String? location,
  }) async {
    if (cart == null ||
        cart.value == null ||
        cart.value!.cartList == null ||
        cart.value!.cartList!.isEmpty) {
      return;
    }

    /// add to order collection.
    double? totalOrderMeter = 0.0;
    double? totalOrderAmount = 0.0;
    List<Map<String, dynamic>> orderList =
        (cart.value ?? CartModel()).cartList!.map(
      (cartItem) {
        totalOrderMeter =
            (totalOrderMeter ?? 0.0) + double.parse(cartItem.orderMeter ?? '');
        totalOrderAmount = (totalOrderAmount ?? 0.0) +
            double.parse((cartItem.orderType == 'With GST')
                ? (double.parse(cartItem.orderMeter ?? '0') *
                        double.parse(cartItem.price ?? '0') *
                        (1.18))
                    .toStringAsFixed(2)
                : cartItem.orderType == '50%'
                    ? (((double.parse(cartItem.orderMeter ?? '0') / 2) *
                                double.parse(cartItem.chipestPrice ?? '0')) +
                            ((double.parse(cartItem.orderMeter ?? '0') / 2) *
                                double.parse(cartItem.price ?? '0') *
                                1.18))
                        .toStringAsFixed(2)
                    : (double.parse(cartItem.orderMeter ?? '0') *
                            double.parse(cartItem.chipestPrice ?? '0'))
                        .toStringAsFixed(2));

        return CreateOrderModel(
          ppmoo1: (cartItem.orderType == 'Without GST' ||
                  cartItem.orderType == '50%')
              ? cartItem.chipestPrice
              : '',
          ppmoo2:
              (cartItem.orderType == 'With GST' || cartItem.orderType == '50%')
                  ? cartItem.price
                  : '',
          flat: cartItem.flat,
          gej: cartItem.gej,
          isDelete: false,
          isWithGst: cartItem.orderType,
          orderStatus: "Pending",
          size: cartItem.size,
          subOrderId: generateRandomId(
            length: 20,
          ),
          totalAmount: cartItem.orderType == 'With GST'
              ? (double.parse(cartItem.price ?? '0') *
                      double.parse(cartItem.orderMeter ?? '0') *
                      1.18)
                  .toStringAsFixed(2)
              : cartItem.orderType == 'Without GST'
                  ? (double.parse(cartItem.orderMeter ?? '0') *
                          double.parse(cartItem.chipestPrice ?? '0'))
                      .toStringAsFixed(2)
                  : ((double.parse(cartItem.orderMeter ?? '0') / 2) *
                              (double.parse(cartItem.chipestPrice ?? '0')) +
                          (double.parse(cartItem.orderMeter ?? '0') / 2) *
                              (double.parse(cartItem.price ?? '0')) *
                              1.18)
                      .toStringAsFixed(2),
          totalMeter: cartItem.orderMeter,
          type: cartItem.type,
        ).toJson();
      },
    ).toList();

    DocumentReference documentReference = await firebaseFirestore
        .collection('Users')
        .doc(Preference.userId)
        .collection('Order')
        .add(
      {
        'createdAt': DateTime.now(),
        'paymentStatus': false,
        'paymentType': 'Offline',
        'order': orderList,
      },
    );
    Map<String, dynamic> userDetails = {
      'firstName': firstname,
      'lastName': lastName,
      'brandName': brandName,
      'phoneNo': phoneNo,
      'location': location,
    };
    await documentReference.update(
      {
        'orderId': documentReference.id,
        'totalOrderAmout': totalOrderAmount.toString(),
        'totalOrderMeter': totalOrderMeter.toString(),
        'userDetails': userDetails,
      },
    );

    /// remove cart items.
    await firebaseFirestore
        .collection('Users')
        .doc(Preference.userId)
        .collection('Cart')
        .doc('cart')
        .update(
      {
        'cartList': [],
        'updatedAt': DateTime.now(),
      },
    );

    DocumentSnapshot documentSnapshot = await firebaseFirestore
        .collection('Users')
        .doc(Preference.userId)
        .get();

    String? userProfileTotalOrderAmount =
        documentSnapshot.get('totalOrderAmount');
    String? userProfileTotalOrderMeter =
        documentSnapshot.get('totalOrderMeter');

    userProfileTotalOrderMeter =
        ((double.tryParse(userProfileTotalOrderMeter ?? '0') ?? 0.0) +
                (totalOrderMeter ?? 0.0))
            .toString();

    userProfileTotalOrderAmount =
        ((double.tryParse(userProfileTotalOrderAmount ?? '0') ?? 0.0) +
                (totalOrderAmount ?? 0.0))
            .toString();

    await firebaseFirestore.collection('Users').doc(Preference.userId).update(
      {
        'totalOrderAmount': userProfileTotalOrderAmount,
        'totalOrderMeter': userProfileTotalOrderMeter,
      },
    );
    Preference.totalOrderAmount = userProfileTotalOrderAmount;
    Preference.totalOrderMeter = userProfileTotalOrderMeter;
  }

  static String generateRandomId({int length = 20}) {
    const letters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz';
    final random = Random.secure();
    return List.generate(length, (_) => letters[random.nextInt(letters.length)])
        .join();
  }

  static Future<List<UserChatModel>> getAdminList() async {
    QuerySnapshot snapshot = await firebaseFirestore
        .collection('Users')
        .where('userType', isEqualTo: 'Admin')
        .get();

    List<UserChatModel> adminList = snapshot.docs.map((doc) {
      return UserChatModel.fromJson(doc.data() as Map<String, dynamic>);
    }).toList();

    return adminList;
  }

  static Stream<QuerySnapshot> getChatHistory({
    required String userId,
    required String adminId,
  }) {
    try {
      String chatId = '$adminId$userId';

      return firebaseFirestore
          .collection('Chats')
          .doc(chatId)
          .collection('Messages')
          .orderBy('timestamp', descending: false)
          .snapshots();
    } catch (e) {
      print("Error fetching chat history: $e");
      return const Stream.empty();
    }
  }

  static addChatWelcomeMessage({String? adminId, String? userId}) async {
    String chatId = '$adminId$userId';
    DocumentReference document = await firebaseFirestore
        .collection('Chats')
        .doc(chatId)
        .collection('Messages')
        .add(
      {
        'isRead': false,
        'mediaUrl': '',
        'message': 'Welcome to Field King',
        'messageType': 'text',
        'receiverId': userId,
        'senderId': adminId,
        'timestamp': DateTime.now(),
      },
    );
    await document.update(
      {
        'id': document.id,
      },
    );
    DocumentReference secondDocument = await firebaseFirestore
        .collection('Chats')
        .doc(chatId)
        .collection('Messages')
        .add(
      {
        'isRead': false,
        'mediaUrl': '',
        'message': 'How can we help you!',
        'messageType': 'text',
        'receiverId': userId,
        'senderId': adminId,
        'timestamp': DateTime.now(),
      },
    );
    await secondDocument.update(
      {
        'id': secondDocument.id,
      },
    );
  }

  static sendMessage({
    String? adminId,
    String? userId,
    String? message,
    String? messageType,
    bool? senderIsAdmin = false,
  }) async {
    String chatId = '$adminId$userId';

    DocumentReference document = await firebaseFirestore
        .collection('Chats')
        .doc(chatId)
        .collection('Messages')
        .add(
      {
        'isRead': false,
        'mediaUrl': '',
        'message': message,
        'messageType': messageType,
        'receiverId': senderIsAdmin == true ? userId : adminId,
        'senderId': senderIsAdmin == true ? adminId : userId,
        'timestamp': DateTime.now(),
      },
    );
    await document.update(
      {
        'id': document.id,
      },
    );
  }

  static getOrderHistory() {
    RxList<OrderHistoryModel> orderHistoryList = <OrderHistoryModel>[].obs;

    firebaseFirestore
        .collection('Users')
        .doc(Preference.userId)
        .collection('Order')
        .snapshots()
        .listen((snapshot) {
      orderHistoryList.value = snapshot.docs.map((e) {
        final data = e.data();
        return OrderHistoryModel.fromJson(data);
      }).toList();
    });

    return orderHistoryList;
  }
}
