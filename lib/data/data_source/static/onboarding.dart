import 'package:flutter/material.dart';
import 'package:my_eccommerce_user/core/assets/images.dart';
import 'package:my_eccommerce_user/data/model/onboadring.dart';
import 'package:my_eccommerce_user/view/screens/onboarding.dart';

List<OnBoardingModel> onBoarding = [
  OnBoardingModel(
      image: AppImageAssets.onBoarding1,
      title: "Purchase Online",
      body: "Choose between thousands of high quality products"),
  OnBoardingModel(
      image: AppImageAssets.onBoarding2,
      title: "Track Your Order",
      body: "Track your order in real time"),
  OnBoardingModel(
      image: AppImageAssets.onBoarding3,
      title: "Get Your Order!",
      body: "Enjoy your order with our services!"),
];
