import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

Widget formfield(
  BuildContext context,
  String labeltext,
  String hinttext,
  TextEditingController controller,
  int maxlength,
  String countertext,
  TextInputType textinputtype,
  Function(String) onchanged,
  Function(String) onfieldsubmitted,
  TextInputFormatter filteredtextformate,
  LengthLimitingTextInputFormatter lengthLimitingTextInputFormatter, {
  FocusNode? focusNode,
  bool? readOnly,
}) {
  return SizedBox(
    height: 80,
    child: TextFormField(
      textInputAction: (labeltext == 'Enter Your Brand Name')
          ? TextInputAction.done
          : TextInputAction.next,
      focusNode: focusNode,
      enabled: true,
      readOnly: readOnly!,
      onChanged: (value) {
        onchanged(value);
        if (value.length == maxlength) {
          focusNode!.unfocus();
        }
      },
      onFieldSubmitted: (value) {
        onfieldsubmitted(value);
        // if (focusNode != null && focusNode.nextFocus() != null) {
        //   FocusScope.of(context).nextFocus();
        // }
      },
      inputFormatters: [
        filteredtextformate,
        lengthLimitingTextInputFormatter,
      ],
      enableSuggestions: true,
      maxLength: maxlength,
      controller: controller,
      keyboardType: textinputtype,
      decoration: InputDecoration(
        labelText: labeltext,
        hintText: hinttext,
        labelStyle: TextStyle(
          color: Color.fromARGB(255, 125, 125, 125),
        ),
        counter: Text(''),
        border: OutlineInputBorder(
          borderSide: BorderSide(width: 2),
          borderRadius: BorderRadius.circular(4),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 2, color: Colors.red),
          borderRadius: BorderRadius.circular(4),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide:
              BorderSide(width: 2, color: Color.fromARGB(255, 125, 125, 125)),
          borderRadius: BorderRadius.circular(4),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 2, color: Colors.red),
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    ),
  );
}

Widget buttonwidget(BuildContext context, String btntext, Color bgSecondry1,
    Color bgSecondry2, Color textcolor) {
  return Container(
    height: 50,
    width: MediaQuery.of(context).size.width,
    decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [bgSecondry1, bgSecondry2],
        ),
        borderRadius: BorderRadius.circular(3)),
    child: Center(
      child: Text(
        btntext,
        style: TextStyle(
          color: Colors.white,
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}

showtoast(BuildContext context, String msg, int duration) {
  showToast(
    context: context,
    msg,
    backgroundColor: const Color.fromARGB(255, 147, 147, 147),
    isHideKeyboard: true,
    duration: Duration(seconds: duration),
  );
}

showprocessindicator(context) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return Center(
        child: CircularProgressIndicator(
          backgroundColor:
              Color.fromARGB(255, 147, 147, 147), // Background color
          valueColor: AlwaysStoppedAnimation<Color>(
            Colors.white, // Color at the center of the gradient
          ),
        ),
      );
    },
  );
}

hideprocessindicator(context) {
  return Navigator.pop(context);
}

Widget otpformfield(
  BuildContext context,
  TextEditingController controller,
  bool bool,
  bool isLast,
) {
  return Expanded(
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 5),
      child: TextFormField(
        textInputAction: TextInputAction.done,
        textAlign: TextAlign.center,
        maxLength: 1,
        keyboardType: TextInputType.number,
        controller: controller,
        decoration: InputDecoration(
          counter: Text(''),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.teal),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 2),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 2),
          ),
          labelStyle: const TextStyle(fontSize: 16, color: Colors.white),
        ),
        onTap: () {},
        onChanged: (value) {
          if (value.isNotEmpty) {
            if (isLast == false) {
              FocusScope.of(context).nextFocus();
            } else {
              FocusScope.of(context).unfocus();
            }
          }
        },
      ),
    ),
  );
}
