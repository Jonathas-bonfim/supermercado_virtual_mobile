import 'package:flutter/material.dart';

class SingUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar Conta'),
        centerTitle: true,
      ),
    body: Center(
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: ListView(
            padding: const EdgeInsets.all(16),
            shrinkWrap: true,
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(hintText: 'Nome Completo'),
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                decoration: const InputDecoration(hintText: 'E-mail'),
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                decoration: const InputDecoration(hintText: 'Senha'),
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                decoration: const InputDecoration(hintText: 'Repita a senha'),
              ),
              const SizedBox(
                height: 16,),
              SizedBox(
                height: 44,
                child: RaisedButton(
                  color: Theme.of(context).primaryColor,
                  disabledColor: Theme.of(context).primaryColor.withAlpha(100),
                  textColor: Colors.white,
                  onPressed: () {},
                  child: const Text('Criar Conta'),
                ),
              )
            ],
          ),
        ),
      ),  
    );
  }
}