import 'package:flutter/material.dart';
import 'package:supermercado_virtual/models/item_size.dart';

class EditItemSize extends StatelessWidget {
  EditItemSize({this.size});

  final ItemSize size;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            initialValue: size.name,
            decoration:
                const InputDecoration(labelText: 'Título', isDense: true),
          ),
        ),
        const SizedBox(
          width: 6,
        ),
        Expanded(
          child: TextFormField(
            initialValue: size.stock.toStringAsFixed(2),
            decoration:
                const InputDecoration(labelText: 'Estoque', isDense: true),
            keyboardType: TextInputType.numberWithOptions(decimal: false),
          ),
        ),
        const SizedBox(
          width: 6,
        ),
        Expanded(
          child: TextFormField(
            initialValue: size.price.toStringAsFixed(2),
            decoration:
                const InputDecoration(labelText: 'Preço', isDense: true),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
          ),
        ),
      ],
    );
  }
}
