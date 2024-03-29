import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supermercado_virtual/models/product.dart';
import 'package:supermercado_virtual/models/product_manager.dart';
import 'components/images_form.dart';
import 'components/sizes_form.dart';

class EditProductScreen extends StatelessWidget {
  // passando o produto por parâmetro para conseguir editar o próprio
  EditProductScreen(Product p)
      : editing = p != null,
        product = p != null ? p.clone() : Product();

  final Product product;
  final bool editing;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return ChangeNotifierProvider.value(
      value: product,
      child: Scaffold(
        appBar: AppBar(
          title: Text(editing ? 'Editar Produto' : 'Criar Produto'),
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
                          hintText: 'Nome do Produto',
                          border: InputBorder.none),
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                      validator: (name) {
                        if (name.length < 6)
                          return 'Nome do produto muito curto';
                        return null;
                      },
                      onSaved: (name) => product.name = name,
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
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
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
                      onSaved: (desc) => product.description = desc,
                    ),
                    SizesForm(product),
                    SizedBox(
                      height: 20,
                    ),

                    // para informar se estamos carregando algo ou não.
                    Consumer<Product>(
                      builder: (_, product, __) {
                        return SizedBox(
                          height: 44,
                          child: RaisedButton(
                            onPressed: !product.loading
                                ? () async {
                                    // para validar se os campos estão vazios, não precisa implementar o formkey já é gerado pelo flutter
                                    if (formKey.currentState.validate()) {
                                      formKey.currentState.save();
                                      // função para salvar
                                      await product.save();

                                      // informando ao produto que houve uma mudança
                                      context
                                          .read<ProductManager>()
                                          .update(product);

                                      Navigator.of(context).pop();
                                    }
                                  }
                                : null,
                            textColor: Colors.white,
                            color: primaryColor,
                            disabledColor: primaryColor.withAlpha(100),
                            child: product.loading
                                ? CircularProgressIndicator(
                                    valueColor:
                                        AlwaysStoppedAnimation(Colors.white),
                                  )
                                : const Text(
                                    'Salvar',
                                    style: TextStyle(fontSize: 18.0),
                                  ),
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
