import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RegistrationTextField extends StatelessWidget {
  final String hintText;
  final bool isObscured;
  final controller;

  RegistrationTextField({
    required this.hintText,
    this.isObscured = false,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: isObscured,
      controller: controller,
      cursorColor: Colors.blue,
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.blue),
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.blue,
            width: 5.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.blue,
            width: 3.0,
          ),
        ),
        labelText: hintText,
        labelStyle: TextStyle(color: Colors.blue),
      ),
    );
  }
}
