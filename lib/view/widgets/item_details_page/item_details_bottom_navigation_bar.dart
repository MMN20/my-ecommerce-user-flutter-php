import 'package:flutter/material.dart';

class ItemDetailsBottomNavigationBar extends StatelessWidget {
  const ItemDetailsBottomNavigationBar(
      {super.key,
      required this.isAddedToCart,
      required this.addToCartFunc,
      required this.onCartTap,
      required this.isLike,
      required this.likeUnlike,
      required this.isLoading,
      required this.onDelete});
  final bool isAddedToCart;
  final bool isLike;
  final bool isLoading;
  final void Function() addToCartFunc;
  final void Function() onCartTap;
  final void Function() likeUnlike;
  final void Function() onDelete;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(
          color: Colors.white,
          strokeWidth: 1,
        ),
      );
    }
    Widget otherWidget = isAddedToCart
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Added to ",
                style: TextStyle(color: Colors.white),
              ),
              InkWell(
                onTap: onCartTap,
                child: const Text(
                  "cart",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(width: 5),
              const Icon(
                Icons.task_alt_rounded,
                color: Colors.green,
              )
            ],
          )
        : InkWell(
            onTap: addToCartFunc,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Add to cart",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 5),
                Icon(
                  Icons.add_shopping_cart_outlined,
                  color: Colors.white,
                ),
              ],
            ),
          );
    return Stack(
      alignment: Alignment.centerLeft,
      children: [
        Center(child: otherWidget),
        InkWell(
          onTap: likeUnlike,
          child: Container(
            padding: const EdgeInsets.all(15.0),
            decoration: const BoxDecoration(),
            child: isLike
                ? const Icon(Icons.favorite, color: Colors.red)
                : const Icon(Icons.favorite_border, color: Colors.white),
          ),
        ),
        if (isAddedToCart)
          Positioned(
            top: 0,
            bottom: 0,
            right: 0,
            child: InkWell(
              onTap: onDelete,
              child: Container(
                padding: const EdgeInsets.all(15.0),
                decoration: const BoxDecoration(),
                child: const Icon(Icons.delete, color: Colors.red),
              ),
            ),
          ),
      ],
    );
  }
}
