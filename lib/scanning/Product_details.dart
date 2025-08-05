import 'package:flutter/material.dart';
import 'package:trackncheck/components/Card.dart';
import 'package:trackncheck/scanning/Result_page.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CardWidget(
        title: "Product details",
        description: "xdasmxbdajkwdbjkawsbdjab",
        onTap: () => ResultPage(),
      ),
    );
  }
}
