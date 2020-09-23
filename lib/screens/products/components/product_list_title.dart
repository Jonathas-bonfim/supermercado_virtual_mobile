import 'package:flutter/material.dart';
import 'package:supermercado_virtual/models/product.dart';

class ProductListTitle extends StatelessWidget {
  ProductListTitle(this.product);
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      child: Container(
        height: 100,
        padding: const EdgeInsets.all(8),
        child: Row(
          children: <Widget>[
            AspectRatio(
              aspectRatio: 1,
              child: Image.network(''),
            )
          ],
        ),
      ),
    );
  }
}
