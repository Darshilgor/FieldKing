import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:field_king/Pages/home_page.dart';
import 'package:field_king/services/cons.dart';
import 'package:field_king/services/navigator.dart';
import 'package:field_king/services/shared_preference.dart';
import 'package:field_king/Widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OtpPage extends StatefulWidget {
  final String id;
  final String? firstname;
  final String? lastname;
  final String? branname;
  final String? mobilenumber;
  final bool signup;
  const OtpPage(
      {super.key,
      required this.id,
      this.firstname,
      this.lastname,
      this.branname,
      this.mobilenumber,
      required this.signup});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  TextEditingController controller3 = TextEditingController();
  TextEditingController controller4 = TextEditingController();
  TextEditingController controller5 = TextEditingController();
  TextEditingController controller6 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Enter OTP',
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    otptextformfield(context, controller1, true),
                    otptextformfield(context, controller2, true),
                    otptextformfield(context, controller3, true),
                    otptextformfield(context, controller4, true),
                    otptextformfield(context, controller5, true),
                    otptextformfield(context, controller6, true),
                  ],
                ),
                BlocConsumer<BlocPage, BlocState>(
                  listener: (context, state) async {
                    print(state.runtimeType);
                    if (state is SignInState) {
                      await FirebaseFirestore.instance
                          .collection('Users')
                          .doc(widget.mobilenumber)
                          .set({
                        'First Name': widget.firstname,
                        'Last Name': widget.lastname,
                        'Brand Name': widget.branname,
                        'Mobile No': widget.mobilenumber,
                        'Type': (widget.mobilenumber == '+919409529203' ||
                                widget.mobilenumber == '+919426781202')
                            ? 'Admin'
                            : 'Customer',
                      }).whenComplete(() async {
                        await setlocaldata(
                            firstname: widget.firstname,
                            lastname: widget.lastname,
                            brandname: widget.branname,
                            mobilenumber: widget.mobilenumber,
                            signup: true,
                            type: (widget.mobilenumber == '+919409529203' ||
                                    widget.mobilenumber == '+919426781202')
                                ? 'Admin'
                                : 'Customer');
                        await getlocaldata();
                      });
                      hindprocessindicator(context);
                      pushAndRemoveUntil(
                        context,
                        HomePage(),
                      );
                    }
                  },
                  builder: (context, state) {
                    return GestureDetector(
                      onTap: () {
                        showprocessindicator(context);
                        if (controller1.text.isNotEmpty &&
                            controller2.text.isNotEmpty &&
                            controller3.text.isNotEmpty &&
                            controller4.text.isNotEmpty &&
                            controller5.text.isNotEmpty &&
                            controller6.text.isNotEmpty) {
                          BlocProvider.of<BlocPage>(context).verifyotp(
                              context,
                              '${controller1.text}${controller2.text}${controller3.text}${controller4.text}${controller5.text}${controller6.text}',
                              widget.id);
                        }
                      },
                      child: buttonwidget(
                        context,
                        'Varify OTP',
                        bgcolor1,
                        bgcolor2,
                        Colors.white,
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 5,
                ),
                InkWell(
                  onTap: () {},
                  child: Text(
                    'Resend OTP',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
