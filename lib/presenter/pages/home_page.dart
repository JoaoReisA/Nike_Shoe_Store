import 'package:flutter/material.dart';
import 'package:nike_shoe_store/domain/entities/nike_shoes.dart';
import 'package:nike_shoe_store/presenter/pages/nike_shoes_details_page.dart';
import 'package:nike_shoe_store/presenter/widgets/nike_shoes_item_widget.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key,}) : super(key: key);
  final ValueNotifier<bool> notifierBottomBarVisible = ValueNotifier(true);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(left: 20.0, top: 20.0, right: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Image.asset(
                    "assets/images/nike_logo.png",
                    height: 60,
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: shoes.length,
                      padding: const EdgeInsets.only(bottom: 20),
                      itemBuilder: (context, index) {
                        final item = shoes[index];
                        return NikeShoeItemWidget(
                          item: item,
                          onTap: () => _onShoesPressed(item, context),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            ValueListenableBuilder<bool>(
                child: Row(
                  children: const [
                    Expanded(child: Icon(Icons.home)),
                    Expanded(child: Icon(Icons.search)),
                    Expanded(child: Icon(Icons.favorite_border)),
                    Expanded(child: Icon(Icons.shopping_cart)),
                    Expanded(
                        child: CircleAvatar(
                      radius: 13,
                      backgroundImage:
                          AssetImage('assets/images/ronaldinho.jpeg'),
                    )),
                  ],
                ),
                valueListenable: notifierBottomBarVisible,
                builder: (context, value, child) {
                  return AnimatedPositioned(
                      duration: const Duration(milliseconds: 600),
                      left: 0,
                      right: 0,
                      bottom: value ? 0.0 : -kToolbarHeight,
                      height: kToolbarHeight,
                      child: Container(
                        color: Colors.white.withOpacity(0.7),
                        child: child,
                      ));
                })
          ],
        ));
  }

  void _onShoesPressed(NikeShoe item, BuildContext context) async {
    notifierBottomBarVisible.value = false;
    await Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) {
          return FadeTransition(
            opacity: animation1,
            child: NikeShoesDetailsPage(shoe: item,),
          );
        },
      ),
    );
    notifierBottomBarVisible.value = true;
  }
}
