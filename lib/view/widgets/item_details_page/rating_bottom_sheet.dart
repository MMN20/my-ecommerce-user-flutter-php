import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_eccommerce_user/view/widgets/general_button.dart';

class RatingBottomSheet extends StatelessWidget {
  const RatingBottomSheet(
      {super.key,
      required this.isAddingReviewLoading,
      required this.choosedRating,
      required this.onStarTap,
      required this.commentController,
      required this.onSendTap});
  final bool isAddingReviewLoading;
  final int choosedRating;
  final void Function(int) onStarTap;
  final TextEditingController commentController;
  final void Function() onSendTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height * 0.4,
      child: isAddingReviewLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Your review"),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ...List<Widget>.generate(5, (index) {
                      int currentPos = index + 1;
                      return InkWell(
                        splashFactory: NoSplash.splashFactory,
                        onTap: () {
                          onStarTap(currentPos);
                        },

                        // () {
                        //   choosedRating = currentPos;
                        //   update();
                        // },
                        child: Icon(
                          Icons.star,
                          size: 40,
                          color:
                              currentPos <= choosedRating ? Colors.amber : null,
                        ),
                      );
                    })
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: commentController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      hintText: "Message",
                    ),
                  ),
                ),
                GeneralButton(
                  onPressed: onSendTap,

                  // () {
                  //   addTheReview();
                  // },
                  child: const Text("Send"),
                )
              ],
            ),
    );
  }
}
