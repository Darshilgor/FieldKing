import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:field_king/packages/app/model/cart_list_model.dart';
import 'package:field_king/packages/app/model/get_product_model.dart';
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
    print('inside the add to cart');
    DocumentReference cartDocRef = FirebaseFirestore.instance
        .collection('Users')
        .doc(Preference.userId)
        .collection('Cart')
        .doc('cart');

    DocumentSnapshot cartDoc = await cartDocRef.get();

    if (cartDoc.exists) {
      print('inside the cartdoc is exits');
      print('cables details');
      print(cableDetails);
      List<dynamic> cartList = List.from(cartDoc.get('cartList') ?? []);

      cartList.add(cableDetails);
      print('cart list is');
      print(cartList);
      await cartDocRef.update(
        {
          'cartList': cartList,
          'updatedAt': Timestamp.now(),
        },
      );
    } else {
      print('iside the is not exits.');
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
//     print('inside the get cart');
//     return firebaseFirestore
//         .collection('Users')
//         .doc(Preference.userId)
//         .collection('Cart')
//         .doc('cart')
//         .snapshots()
//         .map((snapshot) => CartModel.fromFirestore(snapshot));
//   }

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
    Preference.totatotalOrderMeter = userSnapShot['totalOrderMeter'] == ''
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
}
