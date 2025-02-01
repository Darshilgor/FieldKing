import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:field_king/packages/app/model/get_product_model.dart';
import 'package:field_king/packages/config.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthServices {
  static Future<void> sendOTP({
    required String phoneNumber,
    required Function(String verificationId) onCodeSent,
    required Function(FirebaseAuthException e) onError,
  }) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    await auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: const Duration(seconds: 60),
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
    Preference.isShowWithOutGst = isShowWithOutGst['IsShowWithOutGST'];
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
}
