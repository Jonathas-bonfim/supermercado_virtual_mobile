import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:supermercado_virtual/models/item_size.dart';

import 'product.dart';

class CartProduct extends ChangeNotifier {
  // Construtor que pega o produto e transforma em um produto no carrinho
  CartProduct.fromProduct(this.product) {
    productId = product.id;
    quantity = 1;
    size = product.selectedSize.name;
  }

  CartProduct.fromDocument(DocumentSnapshot document) {
    id = document.documentID;
    productId = document.data['pid'] as String;
    quantity = document.data['quantity'] as int;
    size = document.data['size'] as String;

    // buscando o produto
    firestore
        .document('products/$productId')
        .get()
        .then((doc) => product = Product.fromDocument(doc));
  }

  final Firestore firestore = Firestore.instance;

  String id;

  String productId;
  int quantity;
  String size;

  Product product;

  ItemSize get itemSize {
    // O product pode ser nulo, pois no carrinho ele não é adicionado,
    // lá vai apenas o tamanho, quantidade e o ID
    if (product == null) return null;
    return product.findSize(size);
  }

  num get unitPrice {
    if (product == null) return 0;
    // Caso o itemSize seja nulo para não retornar null na tela
    return itemSize?.price ?? 0;
  }

  Map<String, dynamic> toCartItemMap() {
    return {
      'pid': productId,
      'quantity': quantity,
      'size': size,
    };
  }

  // função para ver se os itens podem ser empilhados
  bool stackable(Product product) {
    return product.id == productId && product.selectedSize.name == size;
  }

  void increment() {
    quantity++;
    notifyListeners();
  }

  void decrement() {
    quantity--;
    notifyListeners();
  }
}
