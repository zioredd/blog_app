import 'package:flutter/material.dart';

class AuthField extends StatelessWidget {
  final bool isObscure;
  final TextEditingController controller;
  final String hintText;
  const AuthField(
      {super.key,
      required this.hintText,
      required this.controller,
      this.isObscure = false});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(hintText: hintText),
      controller: controller,
      validator: (value) {
        if (value!.isEmpty) {
          return "$hintText is empty";
        } else {
          return null;
        }
      },
      obscureText: isObscure,
    );
  }
}
