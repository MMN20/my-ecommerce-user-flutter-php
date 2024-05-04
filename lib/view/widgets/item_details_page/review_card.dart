import 'package:flutter/material.dart';
import 'package:my_eccommerce_user/data/model/review.dart';

class ReviewCard extends StatelessWidget {
  const ReviewCard({super.key, required this.review});
  final Review review;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: ListTile(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ...List<Widget>.generate(5, (index2) {
              bool isAmber = index2 + 1 <= review.rating!;
              return Icon(
                Icons.star,
                color: isAmber ? Colors.amber : Colors.grey,
              );
            })
          ],
        ),
        subtitle: Text(
          review.comment!,
        ),
      ),
    );
  }
}
