import 'package:flutter/material.dart';
import 'package:supermercado_virtual/models/item_size.dart';
import 'package:supermercado_virtual/models/product.dart';
import 'package:supermercado_virtual/screens/edit_product/components/edit_item_size.dart';

class SizesForm extends StatelessWidget {
  const SizesForm(this.product);
  final Product product;

  @override
  Widget build(BuildContext context) {
    return FormField<List<ItemSize>>(
      initialValue: product.sizes,
      builder: (state) {
        return Column(
          // retornando um widget para cada tamanho
          children: state.value.map((size) {
            // O widget precisa retornar todos os campos que serão editados
            return EditItemSize(size: size);
          }).toList(),
        );
      },
    );
  }
}
