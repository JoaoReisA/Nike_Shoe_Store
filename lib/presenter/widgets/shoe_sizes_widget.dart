import 'package:flutter/material.dart';

class ShoeSizesWidget extends StatelessWidget {
  const ShoeSizesWidget({Key? key, required this.text}) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Text('US $text', style: TextStyle(fontWeight: FontWeight.bold, fontSize:11)),
    );
  }
}
