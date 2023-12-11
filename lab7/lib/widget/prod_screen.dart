import 'package:flutter/material.dart';
import 'package:lab7/widget/prod_detail_screen.dart';

import '../object/product.dart';

class ProductScreen extends StatelessWidget {
  final List<Product> products;

  const ProductScreen({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Products')),
        body: ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) => ListTile(
                  title: Text(products[index].code),
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ProductDetailScreen(product: products[index]))),
                )));
  }
}
