import 'package:flutter/material.dart';

class NikeShoe {
  final String name;
  final double oldPrice;
  final double currentPrice;
  final List<String> images;
  final int modelNumber;
  final int color;
  NikeShoe({
    required this.name,
    required this.oldPrice,
    required this.currentPrice,
    required this.images,
    required this.modelNumber,
    required this.color,
  });
}

final shoes = <NikeShoe>[
  NikeShoe(
    name: 'AIR MAX 90 EZ BLACK',
    currentPrice: 149,
    oldPrice: 299,
    images: [
      'assets/images/shoes1_1.png',
      'assets/images/shoes1_2.png',
      'assets/images/shoes1_3.png',
    ],
    modelNumber: 90,
    color: 0xFFF6F6F6,
  ),
  NikeShoe(
    name: 'AIR MAX 95',
    currentPrice: 299,
    oldPrice: 399,
    images: [
      'assets/images/shoes3_1.png',
      'assets/images/shoes3_2.png',
      'assets/images/shoes3_3.png',
    ],
    modelNumber: 95,
    color: 0xFFF6F5EB,
  ),
  NikeShoe(
    name: 'AIR MAX 270 GOLD',
    currentPrice: 199,
    oldPrice: 349,
    images: [
      'assets/images/shoes2_1.png',
      'assets/images/shoes2_2.png',
      'assets/images/shoes2_3.png',
    ],
    modelNumber: 270,
    color: 0xFFFEF7ED,

  ),
  NikeShoe(
    name: 'AIR MAX 98 FREE',
    currentPrice: 149,
    oldPrice: 299,
    images: [
      'assets/images/shoes4_1.png',
      'assets/images/shoes4_2.png',
      'assets/images/shoes4_3.png',
    ],
    modelNumber: 98,
    color: 0xFFEDF3FE,
  ),
];
