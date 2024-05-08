import "package:flutter/foundation.dart";
import "package:shared_preferences/shared_preferences.dart";

String firstname = "";
String lastname = "";
String brandname = "";
String mobilenumber = "";
String type = "";

Future setlocaldata(
    {String? firstname,
    String? lastname,
    String? brandname,
    String? mobilenumber,
    String? type,
    bool? signup}) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  await pref.setString("First Name", firstname ?? "");
  await pref.setString("Last Name", lastname ?? "");
  await pref.setString("Brand Name", brandname ?? "");
  await pref.setString("Mobile Number", mobilenumber ?? "");
  await pref.setString("Type", type ?? "");
  if (kDebugMode) {
    print(
        'variable is in shared preference page is....in setlocal data function....');
    print(firstname);
    print(lastname);
    print(brandname);
    print(mobilenumber);
    print(type);
  }
}

Future getlocaldata() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  firstname = pref.getString("First Name") ?? "";
  lastname = pref.getString("Last Name") ?? "";
  brandname = pref.getString("Brand Name") ?? "";
  mobilenumber = pref.getString("Mobile Number") ?? "";
  type = pref.getString("Type") ?? "";
}
