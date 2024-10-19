import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String text;
  final Function() onPressed;
  const MyButton({required this.text, required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(text),
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          fixedSize: Size(350, 50)),
    );
  }
}
