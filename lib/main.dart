import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_eccommerce_user/core/utils/colors.dart';
import 'package:my_eccommerce_user/firebase_options.dart';
import 'package:my_eccommerce_user/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences sharedPreferences;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  sharedPreferences = await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: "Cairo",
        colorScheme: const ColorScheme.light(primary: AppColors.thirdColor10),
        scaffoldBackgroundColor: AppColors.mainColor60,
        appBarTheme: const AppBarTheme(color: AppColors.mainColor60),
        textTheme: const TextTheme(
          // Texts uses it
          bodyMedium: TextStyle(
            fontSize: 20,
            color: AppColors.thirdColor10,
          ),
          // TextForms uses it
          bodyLarge: TextStyle(fontSize: 15),
        ),
        useMaterial3: true,
      ),
      // home: const HomePage(),
      // home: const TRYYY(),
      getPages: pages,
    );
  }
}
