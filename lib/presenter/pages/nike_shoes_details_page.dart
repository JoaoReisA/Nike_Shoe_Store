import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NikeShoesDetailsPage extends StatelessWidget {
  NikeShoesDetailsPage({Key? key}) : super(key: key);

  final ValueNotifier<bool> notifierButtonsVisible = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance?.addPostFrameCallback((_){
      notifierButtonsVisible.value = true;
    });
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          ValueListenableBuilder<bool>(
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
            valueListenable: notifierButtonsVisible,
            builder: (context, value, child) {
              return AnimatedPositioned(
                duration: const Duration(milliseconds: 600),
                left: 0,
                right: 0,
                bottom: value ? 0 : -kToolbarHeight,
                child: child!,
              );
            }
          )
        ],
      ),
    );
  }
}
