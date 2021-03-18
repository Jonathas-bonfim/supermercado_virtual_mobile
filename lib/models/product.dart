import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:supermercado_virtual/models/item_size.dart';
import 'package:uuid/uuid.dart';

class Product extends ChangeNotifier {
  Product({this.id, this.name, this.description, this.images, this.sizes}) {
    images = images ?? [];
    sizes = sizes ?? [];
  }

  Product.fromDocument(DocumentSnapshot document) {
    id = document.documentID;
    name = document['name'] as String;
    description = document['description'] as String;
    // o firebase retorna uma lista dinamica e eu preciso de uma lista de string
    images = List<String>.from(document.data['images'] as List<dynamic>);
    // Aula 37
    sizes = (document.data['sizes'] as List<dynamic> ?? [])
        .map((s) => ItemSize.fromMap(s as Map<String, dynamic>))
        .toList();
  }

  final Firestore firestore = Firestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;

  DocumentReference get firestoreRef => firestore.document('products/$id');
  StorageReference get storageRef => storage.ref().child('products').child(id);

  String id;
  String name;
  String description;
  List<String> images;
  List<ItemSize> sizes;

  List<dynamic> newImages;

  bool _loading = false;
  bool get loading => _loading;
  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  ItemSize _selectedSize;
  ItemSize get selectedSize => _selectedSize;
  set selectedSize(ItemSize value) {
    _selectedSize = value;
    notifyListeners();
  }

  int get totalStock {
    int stock = 0;
    // Adicionando no estoque geral cada um dos estoques
    for (final size in sizes) {
      stock += size.stock;
    }
    return stock;
  }

  bool get hasStock {
    return totalStock > 0;
  }

  num get basePrice {
    num lowest = double.infinity;
    for (final size in sizes) {
      if (size.price < lowest && size.hasStock) lowest = size.price;
    }
    return lowest;
  }

  ItemSize findSize(String name) {
    // caso o tamanho do item não exista mais, ou seja, o dono não vende mais P
    try {
      return sizes.firstWhere((s) => s.name == name);
    } catch (e) {
      return null;
    }
  }

  // convertendo os tamanhhos para um mapa string dynamic para salvar
  // o toMap é uma função que irá receber os dados do ItemSize
  List<Map<String, dynamic>> exportSizeList() {
    return sizes.map((size) => size.toMap()).toList();
  }

  // salvando os dados no firebase
  Future<void> save() async {
    loading = true;
    final Map<String, dynamic> data = {
      'name': name,
      'description': description,
      'sizes': exportSizeList(),
    };

    // verificando se estou criando um novo produto ou atualizando
    if (id == null) {
      // salvando um novo produto
      final doc = await firestore.collection('products').add(data);
      // obtendo o id
      id = doc.documentID;
    } else {
      // se no lugar do update fosse um setData ele iria sobrescrever os dados que não foram preenchidos
      await firestoreRef.updateData(data);
    }

    final List<String> updateImages = [];

    // VERIFICANDO SE A IMAGEM QUE ESTÁ NA NEW IMAGE EXISTE NA IMAGEM DO PRODUTO, SE SIM ADICIONAR ELA NAS NOVAS IMAGENS PARA SER MANTIDA
    for (final newImage in newImages) {
      if (images.contains(newImage)) {
        updateImages.add(newImage as String);
      } else {
        // se o arquivo for novo => mandar para o storage
        // preparando o arquivo
        final StorageUploadTask task =
            storageRef.child(Uuid().v1()).putFile(newImage as File);
        // concluindo a subida do arquivo
        final StorageTaskSnapshot snapshot = await task.onComplete;
        // obtendo a url do arquivo que foi inserido no storage
        final String url = await snapshot.ref.getDownloadURL() as String;
        // adicionando a url na lista de arquivos a serem atualizados
        updateImages.add(url);
      }
    }
    // verificando se as imagens foram excluídas
    for (final image in images) {
      if (!newImages.contains(image)) {
        try {
          final ref = await storage.getReferenceFromUrl(image);
          await ref.delete();
        } catch (e) {
          debugPrint('Falha ao deletar $image');
        }
      }
    }
    await firestoreRef.updateData({'images': updateImages});
    images = updateImages;
    loading = false;
  }

  Product clone() {
    return Product(
      id: id,
      name: name,
      description: description,
      images: List.from(images),
      sizes: sizes.map((size) => size.clone()).toList(),
    );
  }

  @override
  String toString() {
    return 'Product{id: $id, name: $name, description: $description, images: $images, sizes: $sizes, newImages: $newImages}';
  }
}
