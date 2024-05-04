import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_eccommerce_user/data/model/onboadring.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({super.key, required this.onBoardingModel});
  final OnBoardingModel onBoardingModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          onBoardingModel.image,
          height: 200,
          fit: BoxFit.cover,
        ),
        const SizedBox(
          height: 30,
        ),
        TitleText(
          text: onBoardingModel.title.tr,
        ),
        const SizedBox(
          height: 10,
        ),
        BodyText(
          body: onBoardingModel.body.tr,
        )
      ],
    );
  }
}

class TitleText extends StatelessWidget {
  const TitleText({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: Color.fromARGB(255, 71, 71, 71),
        fontSize: 20,
        fontFamily: "Cairo",
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class BodyText extends StatelessWidget {
  const BodyText({super.key, required this.body});
  final String body;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      child: Text(
        body,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Color.fromARGB(255, 89, 89, 90),
          fontSize: 18,
          fontFamily: "Cairo",
        ),
      ),
    );
  }
}
