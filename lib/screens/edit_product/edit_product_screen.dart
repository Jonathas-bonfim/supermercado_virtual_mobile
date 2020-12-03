import 'package:flutter/material.dart';
import 'package:supermercado_virtual/models/product.dart';

import 'components/images_form.dart';

class EditProductSreen extends StatelessWidget {
  // passando o produto por parâmetro para conseguir editar o próprio
  EditProductSreen(this.product);
  final Product product;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editando produto'),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Form(
        key: formKey,
        child: ListView(
          children: [
            ImagesForm(product),
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                // Para o botão ocupar todo o espaço disponível
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    initialValue: product.name,
                    decoration: const InputDecoration(
                        hintText: 'Nome do Produto', border: InputBorder.none),
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    validator: (name) {
                      if (name.length < 6) return 'Nome do produto muito curto';
                      return null;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      'A partir de',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 13,
                      ),
                    ),
                  ),
                  RaisedButton(
                    onPressed: () {
                      // para validar se os campos estão vazios, não precisa implementar o formkey já é gerado pelo flutter
                      if (formKey.currentState.validate()) {
                        print('Válido');
                      }
                    },
                    child: const Text('Salvar'),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
