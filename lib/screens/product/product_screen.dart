import 'package:flutter/material.dart';
import 'package:supermercado_virtual/models/product.dart';
import 'package:carousel_pro/carousel_pro.dart';

class ProductScreen extends StatelessWidget {
  ProductScreen(this.product);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 1,
            child: Carousel(
              images: product.images.map((url) {
                return NetworkImage(url);
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
