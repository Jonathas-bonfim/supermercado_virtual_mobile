import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImageSourceSheet extends StatelessWidget {
  ImageSourceSheet({this.onImageSelected});
  final Function(File) onImageSelected;

  final ImagePicker picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    Future<void> editImage(String path) async {
      final croppedFile = await ImageCropper.cropImage(
          sourcePath: path,
          aspectRatio: const CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
          androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Editar Imagem',
            toolbarColor: Theme.of(context).primaryColor,
            toolbarWidgetColor: Colors.white,
          ),
          iosUiSettings: const IOSUiSettings(
              title: 'Editar Imagem',
              cancelButtonTitle: 'Cancelar',
              doneButtonTitle: 'Concluir'));

      if (croppedFile != null) {
        onImageSelected(croppedFile);
      }
    }

    if (Platform.isAndroid)
      return BottomSheet(
        // FUNÇÃO CHAMADA QUANDO SE FECHA O BOTTOM SHEET
        onClosing: () {},
        builder: (_) => Column(
          // ocupando o menor espaço possível
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            FlatButton(
              onPressed: () async {
                final PickedFile file =
                    await picker.getImage(source: ImageSource.camera);
                // passando o arquivo para função que acabamos de obter
                // Navigator.of(context).pop();
                // onImageSelected(File(file.path));
                editImage(file.path);
              },
              child: const Text('Câmera'),
            ),
            FlatButton(
              onPressed: () async {
                final PickedFile file =
                    await picker.getImage(source: ImageSource.gallery);
                //transformando o PickedFile em um file
                // File(file.path);
                // onImageSelected(File(file.path));
                editImage(file.path);
              },
              child: const Text('Galeria'),
            ),
          ],
        ),
      );
    else
      return CupertinoActionSheet(
        title: const Text('Selecionar foto para o item'),
        // message: const Text('Escollha a origem da foto'),
        cancelButton: CupertinoActionSheetAction(
          onPressed: Navigator.of(context).pop,
          child: const Text('Cancelar'),
        ),
        actions: [
          CupertinoActionSheetAction(
            onPressed: () async {
              final PickedFile file =
                  await picker.getImage(source: ImageSource.camera);
              editImage(file.path);
            },
            child: const Text('Câmera'),
          ),
          CupertinoActionSheetAction(
            onPressed: () async {
              final PickedFile file =
                  await picker.getImage(source: ImageSource.gallery);
              editImage(file.path);
            },
            child: const Text('Galeria'),
          ),
        ],
      );
  }
}
