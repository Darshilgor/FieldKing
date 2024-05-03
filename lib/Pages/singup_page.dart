import 'package:field_king/Pages/login_page.dart';
import 'package:field_king/Pages/otp_page.dart';
import 'package:field_king/services/cons.dart';
import 'package:field_king/services/navigator.dart';
import 'package:flutter/material.dart';
import 'package:field_king/Widgets/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController firstnamecontroller = TextEditingController();
  TextEditingController lastnamecontroller = TextEditingController();
  TextEditingController brandnamecontroller = TextEditingController();
  TextEditingController mobilenumbercontroller = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Text(''),
        title: Text(
          'Sign Up',
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 10,
          right: 10,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            textformfield(
              'Enter First Name',
              'Field',
              firstnamecontroller,
              15,
              '',
              TextInputType.name,
              onchange,
              onfieldsubmitted,
            ),
            textformfield(
              'Enter Last Name',
              'King',
              lastnamecontroller,
              15,
              '',
              TextInputType.name,
              onchange,
              onfieldsubmitted,
            ),
            textformfield(
              'Enter Your Brand Name',
              'Field King Brand',
              brandnamecontroller,
              15,
              '',
              TextInputType.name,
              onchange,
              onfieldsubmitted,
            ),
            textformfield(
              'Enter Mobile Number',
              '9409529203',
              mobilenumbercontroller,
              10,
              '',
              TextInputType.number,
              onchange,
              onfieldsubmitted,
            ),
            BlocConsumer<BlocPage, BlocState>(
              listener: (BuildContext context, BlocState state) {
                if (state is OtpSendState && state.id.isNotEmpty) {
                  print('state id is....$state.id');
                  hindprocessindicator(context);
                  callnextscreen(
                    context,
                    OtpPage(
                      id: state.id,
                      firstname: firstnamecontroller.text,
                      lastname: lastnamecontroller.text,
                      branname: brandnamecontroller.text,
                      mobilenumber: '+91${mobilenumbercontroller.text}',
                      signup: false,
                    ),
                  );
                }
              },
              builder: (BuildContext context, state) {
                return GestureDetector(
                  onTap: () {
                    showprocessindicator(context);
                    if (firstnamecontroller.text.isEmpty) {
                      showtoast(context, 'Enter First Name', 3);
                      hindprocessindicator(context);
                    } else if (lastnamecontroller.text.isEmpty) {
                      showtoast(context, 'Enter Last Name', 3);
                      hindprocessindicator(context);
                    } else if (brandnamecontroller.text.isEmpty) {
                      showtoast(context, 'Enter Brand Name', 3);
                      hindprocessindicator(context);
                    } else if (mobilenumbercontroller.text.isEmpty) {
                      showtoast(context, 'Enter Mobile Number', 3);
                      hindprocessindicator(context);
                    } else if (mobilenumbercontroller.text.length != 10) {
                      showtoast(context, 'Enter 10 digit mobile number', 3);
                      hindprocessindicator(context);
                    } else if (firstnamecontroller.text.isNotEmpty &&
                        lastnamecontroller.text.isNotEmpty &&
                        brandnamecontroller.text.isNotEmpty &&
                        mobilenumbercontroller.text.length == 10) {
                      BlocProvider.of<BlocPage>(context).verifyphonenumber(
                          context, '+91${mobilenumbercontroller.text}');
                    }
                  },
                  child: buttonwidget(
                    context,
                    'Send Otp',
                    bgcolor1,
                    bgcolor2,
                    Colors.white,
                  ),
                );
              },
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Already Register?  ',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    callnextscreen(
                      context,
                      LoginPage(),
                    );
                  },
                  child: Text(
                    'LogIn',
                    style: TextStyle(
                      fontSize: 18,
                      color: Color.fromARGB(255, 0, 140, 255),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  void onchange(String value) {}

  void onfieldsubmitted(String? value) {}
}
