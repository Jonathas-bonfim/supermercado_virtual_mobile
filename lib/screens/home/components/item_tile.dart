import 'package:flutter/material.dart';
import 'package:supermercado_virtual/models/product_manager.dart';
import 'package:supermercado_virtual/models/section_item.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class ItemTile extends StatelessWidget {
  const ItemTile(this.item);

  final SectionItem item;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (item.product != null) {
          final product =
              context.read<ProductManager>().finProductByID(item.product);
          if (product != null) {
            Navigator.of(context).pushNamed('/product', arguments: product);
          }
        }
      },
      child: AspectRatio(
        aspectRatio: 1,
        child: FadeInImage.memoryNetwork(
          // para a imagem aparecer mais suave
          placeholder: kTransparentImage,
          // carregando a imagem do item que fica na tela inicial
          image: item.image,
          // Para a imagem ocupar o máximo possível
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
