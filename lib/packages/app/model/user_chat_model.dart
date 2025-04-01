import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore

class Contact {
  String? name;
  String? phoneNo;

  Contact({this.name, this.phoneNo});

  /// Convert JSON to Contact Object
  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      name: json['name'],
      phoneNo: json['phoneNo'],
    );
  }

  /// Convert Contact Object to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phoneNo': phoneNo,
    };
  }
}

class UserChatModel {
  String? brandName;
  String? address;
  String? deviceId;
  List<Contact>? contactList; // List of Contact objects
  String? firstName;
  bool? isActive;
  DateTime? lastActive;
  DateTime? createdAt;
  String? lastName;
  String? phoneNo;
  String? profilePhoto;
  String? userId;
  String? userType;
  String? totalOrderAmount;
  String? totalOrderMeter;

  UserChatModel({
    this.brandName,
    this.deviceId,
    this.firstName,
    this.isActive,
    this.lastActive,
    this.lastName,
    this.phoneNo,
    this.profilePhoto,
    this.userId,
    this.userType,
    this.address,
    this.contactList,
    this.createdAt,
    this.totalOrderAmount,
    this.totalOrderMeter,
  });

  /// **Factory Constructor to Parse JSON Data**
  factory UserChatModel.fromJson(Map<String, dynamic> json) {
    return UserChatModel(
      brandName: json['brandName'],
      address: json['address'],
      deviceId: json['deviceId'],
      firstName: json['firstName'],
      isActive: json['isActive'],
      lastActive: json['lastActive'] != null
          ? (json['lastActive'] is Timestamp
              ? (json['lastActive'] as Timestamp).toDate()
              : DateTime.parse(json['lastActive']))
          : null,
      createdAt: json['createdAt'] != null
          ? (json['createdAt'] is Timestamp
              ? (json['createdAt'] as Timestamp).toDate()
              : DateTime.parse(json['createdAt']))
          : null,
      lastName: json['lastName'],
      phoneNo: json['phoneNo'],
      profilePhoto: json['profilePhoto'],
      userId: json['userId'],
      userType: json['userType'],
      contactList: json['contactList'] != null
          ? List<Contact>.from(json['contactList'].map((e) => Contact.fromJson(e)))
          : [],
      totalOrderAmount: json['totalOrderAmount'],
      totalOrderMeter: json['totalOrderMeter'],
    );
  }

  /// **Convert Object to JSON**
  Map<String, dynamic> toJson() {
    return {
      'brandName': brandName,
      'deviceId': deviceId,
      'firstName': firstName,
      'isActive': isActive,
      'lastActive': lastActive?.toIso8601String(), // Convert DateTime to String
      'createdAt': createdAt?.toIso8601String(), // Convert DateTime to String
      'lastName': lastName,
      'phoneNo': phoneNo,
      'profilePhoto': profilePhoto,
      'userId': userId,
      'userType': userType,
      'contactList': contactList?.map((e) => e.toJson()).toList(), // Convert List<Contact> to List<Map<String, dynamic>>
      'totalOrderAmount': totalOrderAmount,
      'totalOrderMeter': totalOrderMeter,
    };
  }
}
