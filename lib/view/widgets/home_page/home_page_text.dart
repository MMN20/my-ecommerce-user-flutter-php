import 'package:flutter/material.dart';

class HomePageText extends StatelessWidget {
  const HomePageText({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontWeight: FontWeight.bold),
    );
  }
}
