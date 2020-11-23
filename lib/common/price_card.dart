import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supermercado_virtual/models/cart_manager.dart';

class PriceCard extends StatelessWidget {
  const PriceCard({this.buttonText, this.onPressed});

  final String buttonText;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    // Watch é para rebildar todo o widget
    final cartManager = context.watch<CartManager>();
    final productsPrice = cartManager.productsPrice;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
        child: Column(
          // para a coluna ocupar o máximo de espaço possível
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Resumo do pedido',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Theme.of(context).primaryColor),
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Text('Valor dos produtos'),
                Text(
                  'R\$ ${productsPrice.toStringAsFixed(2)}',
                ),
              ],
            ),
            const Divider(),
            const SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Total',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                Text(
                  'R\$ ${productsPrice.toStringAsFixed(2)}',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            RaisedButton(
              color: Theme.of(context).primaryColor,
              disabledColor: Theme.of(context).primaryColor.withAlpha(100),
              textColor: Colors.white,
              onPressed: onPressed,
              child: Text(buttonText),
            ),
          ],
        ),
      ),
    );
  }
}
