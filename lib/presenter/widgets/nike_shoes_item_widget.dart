import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:nike_shoe_store/domain/entities/nike_shoes.dart';

class NikeShoeItemWidget extends StatelessWidget {
  const NikeShoeItemWidget({
    Key? key,
    required this.item,
    required this.onTap,
  }) : super(key: key);
  final NikeShoe item;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    const double itemHeight = 290.0;
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: SizedBox(
          height: itemHeight,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Color(item.color),
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: SizedBox(
                  height: itemHeight * 0.6,
                  child: FittedBox(
                      child: Text(
                    item.modelNumber.toString(),
                    style: const TextStyle(
                      color: Colors.black12,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
                ),
              ),
              Positioned(
                top: 20,
                left: 100,
                height: itemHeight * 0.65,
                child: Image.asset(
                  item.images.first,
                  fit: BoxFit.contain,
                ),
              ),
              const Positioned(
                left: 20,
                bottom: 20,
                child: Icon(
                  Icons.favorite_border,
                  color: Colors.grey,
                ),
              ),
              const Positioned(
                right: 20,
                bottom: 20,
                child: Icon(
                  Icons.shopping_cart_outlined,
                  color: Colors.grey,
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 25,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      item.name,
                      style: const TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '\$${item.oldPrice.toInt().toString()}',
                      style: const TextStyle(
                        color: Colors.red,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      '\$${item.currentPrice.toInt().toString()}',
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
