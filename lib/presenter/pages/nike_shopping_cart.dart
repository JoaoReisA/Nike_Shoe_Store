import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nike_shoe_store/domain/entities/nike_shoes.dart';

const _buttonSizeWidth = 160.0;
const _buttonSizeHeight = 60.0;
const _buttonCircularSize = 60.0;
const _finalImageSize = 30.0;
const _imageSize = 120;

class NikeShoppingCart extends StatefulWidget {
  const NikeShoppingCart({Key? key, required this.shoe}) : super(key: key);
  final NikeShoe shoe;

  @override
  State<NikeShoppingCart> createState() => _NikeShoppingCartState();
}

class _NikeShoppingCartState extends State<NikeShoppingCart>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation? _animationResize;
  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));
    _animationResize = Tween(begin: 1.0, end: 0.0).animate(CurvedAnimation(
      parent: _controller!,
      curve: const Interval(0.0, 0.2),
    ));
    super.initState();
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Material(
      color: Colors.transparent,
      child: AnimatedBuilder(
          animation: _controller!,
          builder: (context, child) {
            final panelSizeWidth = (size.width * _animationResize!.value).clamp(
              _buttonCircularSize,
              size.width,
            );
            return Stack(
              fit: StackFit.expand,
              children: [
                Positioned.fill(
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      color: Colors.black87,
                    ),
                  ),
                ),
                Positioned.fill(
                    child: Stack(
                  children: [
                    Positioned(
                      top: size.height * 0.4,
                      left: size.width/2 - panelSizeWidth/2,
                      width: panelSizeWidth,
                      child: _buildBottomSheetAnimated(size),
                    ),
                    Positioned(
                        bottom: 40,
                        left: size.width / 2 -
                            (_buttonSizeWidth * _animationResize!.value).clamp(
                                  _buttonCircularSize,
                                  _buttonSizeWidth,
                                ) /
                                2,
                        child: TweenAnimationBuilder(
                            curve: Curves.easeIn,
                            duration: const Duration(milliseconds: 400),
                            tween: Tween(begin: 1.0, end: 0.0),
                            builder: (context, double value, child) {
                              return Transform.translate(
                                offset: Offset(0.0, value * size.height * 0.6),
                                child: InkWell(
                                  onTap: () {
                                    _controller!.forward();
                                  },
                                  child: Container(
                                    height: (_buttonSizeHeight *
                                            _animationResize!.value)
                                        .clamp(
                                      _buttonCircularSize,
                                      _buttonSizeHeight,
                                    ),
                                    width: (_buttonSizeWidth *
                                            _animationResize!.value)
                                        .clamp(
                                      _buttonCircularSize,
                                      _buttonSizeWidth,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Icon(
                                            Icons.shopping_cart,
                                            color: Colors.white,
                                          ),
                                          if (_animationResize!.value == 1) ...[
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            const Text(
                                              'ADD TO CART',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ]
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }))
                  ],
                ))
              ],
            );
          }),
    );
  }

  TweenAnimationBuilder<double> _buildBottomSheetAnimated(Size size) {
    final imageSize = 
    return TweenAnimationBuilder(
      child: Container(
        height: (size.height * 0.60 * _animationResize!.value).clamp(
          _buttonCircularSize,
          size.height * 0.6,
        ),
        width: (size.width * _animationResize!.value).clamp(
          _buttonCircularSize,
          size.width,
        ),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        ),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image.asset(
                widget.shoe.images.first,
                height: 200,
              ),
              if (_animationResize!.value == 1) ...[
                Column(
                  children: [
                    Text(
                      widget.shoe.name,
                      style: const TextStyle(
                        fontSize: 12,
                      ),
                    ),
                    Text('\$${widget.shoe.currentPrice.toInt().toString()}',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18)),
                  ],
                )
              ]
            ],
          )
        ]),
      ),
      curve: Curves.easeIn,
      duration: const Duration(milliseconds: 400),
      tween: Tween(begin: 1.0, end: 0.0),
      builder: (context, double value, child) {
        return Transform.translate(
          offset: Offset(0.0, value * size.height * 0.6),
          child: child,
        );
      },
    );
  }
}
