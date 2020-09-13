import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supermercado_virtual/models/user_manager.dart';
import 'package:supermercado_virtual/screens/base/base_screen.dart';

void main() async {
  runApp(MyApp());

  QuerySnapshot snapshot = await Firestore.instance.collection('teste').getDocuments();
  for(DocumentSnapshot document in snapshot.documents){
    print(document.data);
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //provider para poder acessar o user manager em todo o app
    return ChangeNotifierProvider(
      create: (_) => UserManager(),
      child: MaterialApp(
        title: 'Mercado Virtual',
        theme: ThemeData(
          // cor principal do aplicativo
          primaryColor: const Color.fromARGB(255, 4, 125, 141),
          //cor principal de fundo
          scaffoldBackgroundColor: const Color.fromARGB(255, 4, 125, 141),
          // tirando a elevação da app bar par a tela
          appBarTheme: const AppBarTheme(
            elevation: 0
          ),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: BaseScreen(),
      ),
    );
  }
}