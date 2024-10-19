import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {

  final String hint;
  final controller;
  final bool isPassword;

  const MyTextField({required this.controller,required this.hint,required this.isPassword,super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 0),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        obscuringCharacter: '*',
        decoration: InputDecoration(
          enabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.white70)),
          focusedBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
          fillColor: Colors.white,
          filled: true,
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey)
        ),
      ),
    );
  }
}
