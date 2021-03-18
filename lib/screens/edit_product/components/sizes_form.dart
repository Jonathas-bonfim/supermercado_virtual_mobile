import 'package:flutter/material.dart';
import 'package:supermercado_virtual/common/custom_icom_button.dart';
import 'package:supermercado_virtual/models/item_size.dart';
import 'package:supermercado_virtual/models/product.dart';
import 'package:supermercado_virtual/screens/edit_product/components/edit_item_size.dart';

class SizesForm extends StatelessWidget {
  const SizesForm(this.product);
  final Product product;

  @override
  Widget build(BuildContext context) {
    return FormField<List<ItemSize>>(
      initialValue: List.from(product.sizes),
      // caso precisasse salvar os tamanhos, não é necessário pois eles são salvos automaticamente pois ja é uma cópia do produto
      // A lista é alterada automaticamente porque a lista já é passada por parâmetro
      onSaved: (sizes) => product.sizes = sizes,
      validator: (sizes) {
        if (sizes.isEmpty) return 'Insira um tamanho';
        return null;
      },
      builder: (state) {
        return Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Tamanhos',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ),
                CustomIconButton(
                  iconData: Icons.add,
                  color: Colors.black,
                  onTap: () {
                    // pegando a lista de tamanhos e adicionando um valor
                    state.value.add(ItemSize());
                    // informando que o estado mudou
                    state.didChange(state.value);
                  },
                )
              ],
            ),
            Column(
              // retornando um widget para cada tamanho
              children: state.value.map((size) {
                // O widget precisa retornar todos os campos que serão editados
                return EditItemSize(
                  // a key é um objeto que identifica um widget na tela.
                  key: ObjectKey(size),
                  size: size,
                  onRemove: () {
                    state.value.remove(size);
                    state.didChange(state.value);
                  },
                  onMoveUp: size != state.value.first
                      ? () {
                          // procurando o index do item onde será pressionado o botão e colocando na variável
                          final index = state.value.indexOf(size);
                          state.value.remove(size);
                          state.value.insert(index - 1, size);
                          state.didChange(state.value);
                        }
                      : null,
                  onMoveDown: size != state.value.last
                      ? () {
                          // // procurando o index do item onde será pressionado o botão e colocando na variável
                          final index = state.value.indexOf(size);
                          state.value.remove(size);
                          state.value.insert(index + 1, size);
                          state.didChange(state.value);
                        }
                      : null,
                );
              }).toList(),
            ),
            if (state.hasError)
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  state.errorText,
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 12,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
