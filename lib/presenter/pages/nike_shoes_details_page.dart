import 'package:flutter/material.dart';

class NikeShoesDetailsPage extends StatelessWidget {
  const NikeShoesDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  FloatingActionButton(
                    heroTag: 'fav_1',
                    backgroundColor: Colors.white,
                    child: const Icon(
                      Icons.favorite,
                      color: Colors.black,
                    ),
                    onPressed: () {},
                  ),
                  const Spacer(),
                  FloatingActionButton(
                    heroTag: 'fav_2',
                    backgroundColor: Colors.black,
                    child: const Icon(Icons.shopping_cart),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
