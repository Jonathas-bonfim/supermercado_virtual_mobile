import 'package:flutter/material.dart';

class ImageSourceSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      // FUNÇÃO CHAMADA QUANDO SE FECHA O BOTTOM SHEET
      onClosing: () {},
      builder: (_) => Column(
        // ocupando o menor espaço possível
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          FlatButton(
            onPressed: () {},
            child: const Text('Câmera'),
          ),
          FlatButton(
            onPressed: () {},
            child: const Text('Galeria'),
          ),
        ],
      ),
    );
  }
}
