import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_eccommerce_user/controller/item_details_page_controller.dart';
import 'package:my_eccommerce_user/view/widgets/general_button.dart';

class DeleteReviewDialog extends StatelessWidget {
  const DeleteReviewDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ItemDetailsPageController>();
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(10),
        alignment: Alignment.center,
        height: Get.height * 0.25,
        color: Colors.transparent,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Padding(
            padding: const EdgeInsets.all(1.0),
            child: controller.isDeleteCurrentUserReviewDialogLoading
                ? const Center(child: CircularProgressIndicator())
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "Are you sure that you want to delete your review?",
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GeneralButton(
                              onPressed: () {
                                Get.back();
                              },
                              minSize: const Size(80, 40),
                              child: const Text("Cancel")),
                          const SizedBox(width: 10),
                          GeneralButton(
                            onPressed: () {
                              controller.deleteCurrentUserReview();
                            },
                            minSize: const Size(80, 40),
                            child: const Text("Confirm"),
                          ),
                        ],
                      )
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
