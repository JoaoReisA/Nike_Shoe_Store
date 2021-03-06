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
  Animation? _animationMovementIn;
  Animation? _animationMovementOut;
  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _animationResize = Tween(begin: 1.0, end: 0.0).animate(CurvedAnimation(
      parent: _controller!,
      curve: const Interval(0.0, 0.3),
    ));
    _animationMovementIn = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller!,
      curve: const Interval(
        0.45,
        0.6,
        curve: Curves.fastLinearToSlowEaseIn,
      ),
    ));
    _animationMovementOut = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller!,
      curve: const Interval(
        0.5,
        1,
        curve: Curves.elasticInOut,
      ),
    ));
    _controller!.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.of(context).pop();
      }
    });
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
                    if (_animationMovementIn!.value != 1)
                      Positioned(
                        top: size.height * 0.4 +
                            (_animationMovementIn!.value * size.height * 0.492),
                        left: size.width / 2 - panelSizeWidth / 2,
                        width: panelSizeWidth,
                        child: _buildBottomSheetAnimated(size),
                      ),
                    Positioned(
                        bottom:
                            40 * -(_animationMovementOut!.value * 2) as double,
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
    final double currentImageSize = (_imageSize * _animationResize!.value)
        .clamp(_finalImageSize, _imageSize) as double;
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
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(30),
            topRight: const Radius.circular(30),
            bottomLeft: _animationResize!.value == 1
                ? const Radius.circular(0)
                : const Radius.circular(30),
            bottomRight: _animationResize!.value == 1
                ? const Radius.circular(0)
                : const Radius.circular(30),
          ),
        ),
        child: Column(
            mainAxisAlignment: _animationResize!.value == 1
                ? MainAxisAlignment.start
                : MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Image.asset(
                    widget.shoe.images.first,
                    height: currentImageSize,
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
