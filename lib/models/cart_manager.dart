import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:supermercado_virtual/models/product.dart';
import 'cart_product.dart';
import 'user.dart';
import 'user_manager.dart';

//em si a tela de carrinho de compras
class CartManager {
  // todos os produtos do carrinho
  List<CartProduct> items = [];

  User user;
  // update no main para atualizar o usuário e o carrinho
  void updateUser(UserManager userManager) {
    user = userManager.user;
    items.clear();

    if (user != null) {
      _loadCartItems();
    }
  }

  Future<void> _loadCartItems() async {
    final QuerySnapshot cartSnap = await user.cartReference.getDocuments();

    // carregando os itens
    // para chamar a função mesmo sem adicionar um item
    items = cartSnap.documents
        .map((d) => CartProduct.fromDocument(d)..addListener(_onItemUpdated))
        .toList();
  }

  void addToCart(Product product) {
    try {
      // averiguando se possui itens iguais para somar na quantidade
      // função stackable no cart_product.dart
      final e = items.firstWhere((p) => p.stackable(product));
      e.quantity++;
    } catch (e) {
      // transformando o produto em um produto que pode ser adicionado ao carrinho
      final cartProduct = CartProduct.fromProduct(product);
      // é proveniente do chandnotifier, toda vez que chamar o notifyListeners ele vai executar a função dentro do addListener
      cartProduct.addListener(_onItemUpdated);
      items.add(cartProduct);
      // adicionando os produtos no carrinho
      user.cartReference.add(cartProduct.toCartItemMap());
    }
  }

  void _onItemUpdated() {}
}
