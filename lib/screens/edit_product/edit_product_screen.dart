import 'package:flutter/material.dart';
import 'package:supermercado_virtual/models/product.dart';

import 'components/images_form.dart';

class EditProductSreen extends StatelessWidget {
  // passando o produto por parâmetro para conseguir editar o próprio
  const EditProductSreen(this.product);
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editando produto'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          ImagesForm(),
        ],
      ),
    );
  }
}
