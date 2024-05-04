import 'package:flutter/material.dart';
import 'package:my_eccommerce_user/core/utils/colors.dart';
import 'package:my_eccommerce_user/view/widgets/my_text_form_field.dart';

class HomeSearch extends StatelessWidget {
  const HomeSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Hero(
            tag: "search",
            child: Material(
              child: MyTextFormField(
                labelText: "search",
                controller: TextEditingController(),
                icon: const Icon(Icons.search),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
