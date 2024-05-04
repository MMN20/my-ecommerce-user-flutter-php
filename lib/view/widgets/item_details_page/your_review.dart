import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_eccommerce_user/controller/item_details_page_controller.dart';

class YourReview extends StatelessWidget {
  const YourReview({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ItemDetailsPageController>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(),
        const Text(
          "Your review",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10,
        ),
        ListTile(
          onTap: () {
            controller.showRatingBottomSheetForUpdating();
          },
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ...List<Widget>.generate(5, (index) {
                bool isAmber =
                    index + 1 <= controller.currentUserReview!.rating!;
                return Icon(
                  Icons.star,
                  color: isAmber ? Colors.amber : Colors.grey,
                );
              })
            ],
          ),
          subtitle: Text(controller.currentUserReview!.comment!),
          trailing: IconButton(
              onPressed: () {
                controller.showDeleteCurrentUserReviewDialog();
              },
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              )),
        )
      ],
    );
  }
}
