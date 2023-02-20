import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  final bool isPasswordType;
  final TextEditingController controller;
  late bool? passwordVisible;
  final String labelText;
  final String hintText;
  late String? error;
  late Icon prefixIcon;
  late Function? onPress;
  late bool? activeSuffixIcon = false;
  TextInput({
    Key? key,
    this.passwordVisible,
    required this.controller,
    required this.hintText,
    required this.isPasswordType,
    required this.labelText,
    this.error,
    required this.prefixIcon,
    this.onPress,
    this.activeSuffixIcon
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
        margin: EdgeInsets.only(left: 10, right: 10),
        height: 70,
        width: width * .9,
        child: TextFormField(
          controller: controller,
          keyboardType: TextInputType.text,
          obscureText: isPasswordType != false ? passwordVisible! : false,
          decoration: InputDecoration(
            labelText: labelText,
            hintText: hintText,
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(40.0)),
              borderSide: BorderSide(width: 1.0),
            ),
            enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(50)),
              borderSide: BorderSide(color: Colors.grey),
            ),
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(50)),
              borderSide: BorderSide(color: Colors.blueGrey),
            ),
            errorBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(50)),
              borderSide: BorderSide(color: Colors.redAccent),
            ),
            focusedErrorBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(50)),
              borderSide: BorderSide(color: Colors.orangeAccent),
            ),
            disabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(50)),
              borderSide: BorderSide(color: Colors.white),
            ),
            contentPadding: EdgeInsets.all(10.0),
            errorText: error,
            prefixIcon: prefixIcon,
            suffixIcon: activeSuffixIcon == true
                ? IconButton(
                    icon: Icon(isPasswordType == true
                        ? Icons.visibility
                        : Icons.visibility_off),
                    onPressed: () {
                      onPress!();
                    },
                  )
                : null,
          ),
        ));
  }
}
