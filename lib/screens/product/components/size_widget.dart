import 'package:flutter/material.dart';
import 'package:supermercado_virtual/models/item_size.dart';
import 'package:supermercado_virtual/models/product.dart';
import 'package:provider/provider.dart';

class SizeWidget extends StatelessWidget {
  const SizeWidget({this.size});

  final ItemSize size;

  @override
  Widget build(BuildContext context) {
    // acesso ao produto selecionado
    // O context.watch rebilda toda a tela do produto já o consumer só a hierarquia selecionada
    final product = context.watch<Product>();
    // tamanho selecionado
    final selected = size == product.selectedSize;

    Color color;
    if (!size.hasStock)
      color = Colors.red.withAlpha(50);
    else if (selected)
      color = Theme.of(context).primaryColor;
    else
      color = Colors.grey;

    return GestureDetector(
      onTap: () {
        if (size.hasStock) {
          product.selectedSize = size;
        }
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: color),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              color: color,
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              child: Text(
                size.name,
                style: TextStyle(color: Colors.white),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Text(
                'R\$ ${size.price.toStringAsFixed(2)}',
                style: TextStyle(color: color),
              ),
            )
          ],
        ),
      ),
    );
  }
}
