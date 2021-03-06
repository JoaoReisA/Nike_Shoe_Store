import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:nike_shoe_store/domain/entities/nike_shoes.dart';
import 'package:nike_shoe_store/presenter/pages/nike_shopping_cart.dart';
import 'package:nike_shoe_store/presenter/widgets/shake_transition.dart';
import 'package:nike_shoe_store/presenter/widgets/shoe_sizes_widget.dart';

class NikeShoesDetailsPage extends StatelessWidget {
  NikeShoesDetailsPage({Key? key, required this.shoe}) : super(key: key);
  final NikeShoe shoe;
  final ValueNotifier<bool> notifierButtonsVisible = ValueNotifier(false);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      notifierButtonsVisible.value = true;
    });
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Image.asset(
          'assets/images/nike_logo.png',
          height: 40,
        ),
        leading: const BackButton(
          color: Colors.black,
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned.fill(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildCarrousel(size),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ShakeTransition(
                      duration: const Duration(milliseconds: 1200),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            shoe.name,
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  shoe.oldPrice.toInt().toString(),
                                  style: const TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.lineThrough,
                                    fontSize: 13,
                                  ),
                                ),
                                Text(
                                  '\$${shoe.currentPrice.toInt().toString()}',
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
                    const SizedBox(height: 20),
                    const ShakeTransition(
                      duration: Duration(milliseconds: 1200),
                      child: Text(
                        'AVAILABLE SIZES',
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ShakeTransition(
                      duration: const Duration(milliseconds: 1200),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          ShoeSizesWidget(text: '6'),
                          ShoeSizesWidget(text: '7'),
                          ShoeSizesWidget(text: '8'),
                          ShoeSizesWidget(text: '9'),
                          ShoeSizesWidget(text: '11'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    const ShakeTransition(
                      duration: Duration(milliseconds: 1200),
                      child: Text(
                        'DESCRIPTION',
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              )
            ],
          )),
          _buildFloatingActionButtons(context)
        ],
      ),
    );
  }

  Widget _buildFloatingActionButtons(BuildContext context) {
    return ValueListenableBuilder<bool>(
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
                onPressed: () {
                  _openShoppingCart(context);
                },
              ),
            ],
          ),
        ),
        valueListenable: notifierButtonsVisible,
        builder: (context, value, child) {
          return AnimatedPositioned(
            duration: const Duration(milliseconds: 250),
            left: 0,
            right: 0,
            bottom: value ? 0 : -kToolbarHeight * 1.5,
            child: child!,
          );
        });
  }

  Widget _buildCarrousel(Size size) {
    return SizedBox(
      height: size.height * 0.5,
      child: Stack(
        children: [
          Hero(
            tag: 'backgound_${shoe.name}',
            child: Positioned.fill(
              child: Container(
                color: Color(shoe.color),
              ),
            ),
          ),
          Positioned(
            left: 70,
            right: 70,
            top: 10,
            child: Hero(
              tag: 'number_${shoe.name}',
              child: Material(
                color: Colors.transparent,
                child: ShakeTransition(
                  axis: Axis.vertical,
                  offset: 20,
                  child: FittedBox(
                    child: Text(
                      shoe.modelNumber.toString(),
                      style: const TextStyle(
                        color: Colors.black12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          PageView.builder(
              itemCount: shoe.images.length,
              itemBuilder: (context, index) {
                final tag = index == 0
                    ? 'image_${shoe.name}'
                    : 'image_${shoe.name}_$index';
                return Container(
                  alignment: Alignment.center,
                  child: Hero(
                    tag: tag,
                    child: ShakeTransition(
                      duration: const Duration(milliseconds: 350),
                      axis: Axis.vertical,
                      offset: 30,
                      child: Image.asset(
                        shoe.images[index],
                        height: 200,
                        width: 200,
                      ),
                    ),
                  ),
                );
              })
        ],
      ),
    );
  }

  void _openShoppingCart(BuildContext context) async{
    notifierButtonsVisible.value = false;
     await Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        pageBuilder: (_, animation1, __) {
          return FadeTransition(
            opacity: animation1,
            child: NikeShoppingCart(shoe: shoe),
          );
        },
      ),
    );
    notifierButtonsVisible.value = true;
  }
}
