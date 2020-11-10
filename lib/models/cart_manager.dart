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
    items = cartSnap.documents.map((d) => CartProduct.fromDocument(d)).toList();
  }

  void addToCart(Product product) {
    // transformando o produto em um produto que pode ser adicionado ao carrinho
    items.add(CartProduct.fromProduct(product));
  }
}
