import 'package:flutter/material.dart';
import 'package:supermercado_virtual/common/custom_icom_button.dart';
import 'package:supermercado_virtual/models/item_size.dart';

class EditItemSize extends StatelessWidget {
  // A Key é um objeto que identifica o widget da nossa tela
  EditItemSize(
      {Key key, this.size, this.onRemove, this.onMoveDown, this.onMoveUp})
      : super(key: key);

  final ItemSize size;
  final VoidCallback onRemove;
  final VoidCallback onMoveUp;
  final VoidCallback onMoveDown;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 30,
          child: TextFormField(
            initialValue: size.name,
            decoration: const InputDecoration(
              labelText: 'Título',
              isDense: true,
            ),
            validator: (name) {
              if (name.isEmpty) return 'Inválido';
              return null;
            },
            // armazenando o nome no tamanho
            onChanged: (name) => size.name = name,
          ),
        ),
        // separação entre os campos
        const SizedBox(
          width: 6,
        ),
        Expanded(
          flex: 30,
          child: TextFormField(
            // se terão números inteiros ou quebrados também
            initialValue: size.stock?.toStringAsFixed(0),
            decoration:
                const InputDecoration(labelText: 'Estoque', isDense: true),
            keyboardType: TextInputType.numberWithOptions(decimal: false),
            validator: (stock) {
              // transformando o texto em inteiro
              if (int.tryParse(stock) == null) return 'Inválido';
              return null;
            },
            // lembrando que o estoque é um string, então estramos transformando em inteiro e armazenando no banco de dados
            onChanged: (stock) => size.stock = int.tryParse(stock),
          ),
        ),
        const SizedBox(
          width: 6,
        ),
        Expanded(
          flex: 40,
          child: TextFormField(
            // quando estamos criando um novo item o preço é nulo então não executar o restante da linha caso seja nulo
            initialValue: size.price?.toStringAsFixed(2),
            decoration: const InputDecoration(
                labelText: 'Preço', isDense: true, prefixText: 'R\$'),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            validator: (price) {
              // transformando em duble
              if (num.tryParse(price) == null) return 'Inválido';
              return null;
            },
            onChanged: (price) => size.price = num.tryParse(price),
          ),
        ),
        CustomIconButton(
          iconData: Icons.remove,
          color: Colors.red,
          onTap: onRemove,
        ),
        CustomIconButton(
          iconData: Icons.arrow_drop_up,
          color: Colors.black,
          onTap: onMoveUp,
        ),
        CustomIconButton(
          iconData: Icons.arrow_drop_down,
          color: Colors.black,
          onTap: onMoveDown,
        )
      ],
    );
  }
}
