import 'package:flutter/material.dart';

class FirstAuthTitle extends StatelessWidget {
  const FirstAuthTitle({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
    );
  }
}
