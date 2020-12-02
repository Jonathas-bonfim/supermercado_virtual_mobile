import 'dart:io';

import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:supermercado_virtual/models/product.dart';

import 'image_source_sheet.dart';

class ImagesForm extends StatelessWidget {
  ImagesForm(this.product);
  final Product product;

  @override
  Widget build(BuildContext context) {
    // permite transformar qualquer widget em formulário
    // O TIPO DYNAMIC É PARA PERMITIR ARQUIVOS E URL
    return FormField<List<dynamic>>(
      initialValue: product.images,
      builder: (state) {
        // colocando as imagens na tela
        return AspectRatio(
          aspectRatio: 1,
          child: Carousel(
            // o map<widget> é para aceitar adicionar um Material ao colocar uma nova imagem
            images: state.value.map<Widget>((image) {
              // Um widget em cima do outro
              return Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  if (image is String)
                    Image.network(
                      image,
                      fit: BoxFit.cover,
                    )
                  else
                    Image.file(
                      image as File,
                      fit: BoxFit.cover,
                    ),
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      icon: Icon(Icons.close),
                      color: Colors.red,
                      iconSize: 15,
                      onPressed: () {
                        state.value.remove(image);
                        // Avisando para o Widget que o estado dele foi alterado para o mesmo ser rebildado
                        state.didChange(state.value);
                      },
                    ),
                  )
                ],
              );
            }).toList()
              ..add(
                Material(
                  color: Colors.grey[100],
                  child: IconButton(
                    icon: Icon(Icons.add_a_photo),
                    color: Theme.of(context).primaryColor,
                    iconSize: 50,
                    onPressed: () {
                      if (Platform.isAndroid)
                        showModalBottomSheet(
                          context: context,
                          builder: (_) => ImageSourceSheet(),
                        );
                      else
                        showCupertinoModalPopup(
                          context: context,
                          builder: (_) => ImageSourceSheet(),
                        );
                    },
                  ),
                ),
              ),
            dotSize: 4,
            dotSpacing: 15,
            dotBgColor: Colors.transparent,
            dotColor: Theme.of(context).primaryColor,
            autoplay: false,
          ),
        );
      },
    );
  }
}
