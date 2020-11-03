import 'package:supermercado_virtual/models/product.dart';
import 'cart_product.dart';

//em si a tela de carrinho de compras
class CartManager {
  // todos os produtos do carrinho
  List<CartProduct> items = [];

  void addToCart(Product product) {
    // transformando o produto em um produto que pode ser adicionado ao carrinho
    items.add(CartProduct.fromProduct(product));
  }
}
