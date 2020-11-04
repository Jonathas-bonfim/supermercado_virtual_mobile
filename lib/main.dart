import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supermercado_virtual/models/cart_manager.dart';
import 'package:supermercado_virtual/models/product.dart';
import 'package:supermercado_virtual/models/product_manager.dart';
import 'package:supermercado_virtual/models/user_manager.dart';
import 'package:supermercado_virtual/screens/base/base_screen.dart';
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
        Provider(
          create: (_) => CartManager(),
          lazy: false,
        ),
      ],
      child: MaterialApp(
          title: 'Mercado Virtual',
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
              case '/base':
              default:
                return MaterialPageRoute(builder: (_) => BaseScreen());
            }
          }),
    );
  }
}
