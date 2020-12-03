import 'package:flutter/material.dart';
import 'package:supermercado_virtual/models/product.dart';

import 'components/images_form.dart';

GlobalKey<FormState> formKey = GlobalKey<FormState>();

class EditProductSreen extends StatelessWidget {
  // passando o produto por parâmetro para conseguir editar o próprio
  EditProductSreen(this.product);
  final Product product;

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
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
                  Text(
                    'R\$ ...',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text(
                      'Descrição',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ),
                  TextFormField(
                    initialValue: product.description,
                    style: const TextStyle(fontSize: 16),
                    decoration: const InputDecoration(
                        hintText: 'Descrição', border: InputBorder.none),
                    maxLines: null,
                    validator: (desc) {
                      if (desc.length < 10) return 'Descrição muito curta';
                      return null;
                    },
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
