import 'package:flutter/material.dart';

import '../object/product.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(product.code)),
        body: Center(child: Text(product.description)));
  }
}
