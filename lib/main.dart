import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supermercado_virtual/models/admin_users_manager.dart';
import 'package:supermercado_virtual/models/cart_manager.dart';
import 'package:supermercado_virtual/models/home_manager.dart';
import 'package:supermercado_virtual/models/product.dart';
import 'package:supermercado_virtual/models/product_manager.dart';
import 'package:supermercado_virtual/models/user_manager.dart';
import 'package:supermercado_virtual/screens/base/base_screen.dart';
import 'package:supermercado_virtual/screens/cart/cart_screen.dart';
import 'package:supermercado_virtual/screens/edit_product/edit_product_screen.dart';
import 'package:supermercado_virtual/screens/login/login_screen.dart';
import 'package:supermercado_virtual/screens/product/product_screen.dart';
import 'package:supermercado_virtual/screens/singup/singup_screen.dart';

void main() async {
  runApp(MyApp());

  QuerySnapshot snapshot =
      await Firestore.instance.collection('teste').getDocuments();
  for (DocumentSnapshot document in snapshot.documents) {
    print(document.data);
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //provider para poder acessar o user manager em todo o app
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserManager(),
          // para carregar a informação do provider ao iniciar o aplicativo
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => ProductManager(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => HomeManager(),
          lazy: false,
        ),
        // Sempre que houver uma Atualização no UserManager ele vai atualizar o CartManager
        // Primeiro vem o que é relacionado (UserManager), depois o tipo do provider (CartManager)
        ChangeNotifierProxyProvider<UserManager, CartManager>(
          create: (_) => CartManager(),
          lazy: false,
          update: (_, userManager, cartManager) =>
              // inserindo o userManager no cartManager
              cartManager..updateUser(userManager),
        ),
        ChangeNotifierProxyProvider<UserManager, AdminUsersManager>(
          // Criando o padrão
          create: (_) => AdminUsersManager(),
          lazy: false,
          update: (_, userManager, cartManager) =>
              AdminUsersManager()..updateUser(userManager),
        ),
      ],
      child: MaterialApp(
          title: 'Mercado Virtual',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            // cor principal do aplicativo
            primaryColor: const Color.fromARGB(255, 4, 125, 141),
            //cor principal de fundo
            scaffoldBackgroundColor: const Color.fromARGB(255, 4, 125, 141),
            // tirando a elevação da app bar par a tela
            appBarTheme: const AppBarTheme(elevation: 0),
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          initialRoute: '/base',
          onGenerateRoute: (settings) {
            switch (settings.name) {
              case '/singup':
                return MaterialPageRoute(builder: (_) => SingUpScreen());
              case '/login':
                return MaterialPageRoute(builder: (_) => LoginScreen());
              case '/product':
                return MaterialPageRoute(
                    builder: (_) =>
                        ProductScreen(settings.arguments as Product));
              case '/cart':
                return MaterialPageRoute(builder: (_) => CartScreen());
              case '/edit_product':
                return MaterialPageRoute(
                    builder: (_) => EditProductScreen(
                          // especificando qual objeto estamos passando por parâmetro, pois se tratando de argument pode ser qualquer coisa pois é do tipo
                          // dynamic, então estamos especificando que é um objeto do tipo Product
                          settings.arguments as Product,
                        ));
              case '/base':
              default:
                return MaterialPageRoute(builder: (_) => BaseScreen());
            }
          }),
    );
  }
}
