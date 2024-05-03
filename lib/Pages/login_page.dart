import 'package:field_king/Pages/otp_page.dart';
import 'package:field_king/services/navigator.dart';
import 'package:field_king/Widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController mobilenumbercontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Log In',
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            textformfield(
                'Enter Mobile Number',
                '9409529203',
                mobilenumbercontroller,
                10,
                '',
                TextInputType.phone,
                onchange,
                onfieldsubmitted),
            BlocConsumer(
              listener: (context, state) {
                if (state is OtpSendState && state.id.isNotEmpty) {
                  print('state id is....$state.id');
                  hindprocessindicator(context);
                  callnextscreen(
                    context,
                    OtpPage(
                      id: state.id,
                      mobilenumber: '+91${mobilenumbercontroller.text}',
                      signup: true,
                    ),
                  );
                }
              },
              builder: (context, state) {
                return GestureDetector(
                  onTap: () async {
                    if (mobilenumbercontroller.text.isEmpty) {
                      showtoast(context, 'Enter Mobile Number', 3);
                    } else if (mobilenumbercontroller.text.length != 10) {
                      showtoast(context, 'Enter 10 Digit Mobile Numner', 3);
                    } else if (mobilenumbercontroller.text.length == 10) {
                      BlocProvider.of<BlocPage>(context).verifyphonenumber(
                          context, '+91${mobilenumbercontroller.text}');
                    }
                  },
                  child: buttonwidget(
                    context,
                    'Send Otp',
                    Color.fromARGB(255, 147, 147, 147),
                    Color.fromARGB(255, 147, 147, 147),
                    Colors.white,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  onchange(String p1) {}

  onfieldsubmitted(String p1) {}
}
