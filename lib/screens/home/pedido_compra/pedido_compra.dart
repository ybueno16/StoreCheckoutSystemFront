import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:store_checkout_system/helpers/quantidade_helper.dart';

class PedidoCompraPage extends StatefulWidget {
  @override
  _PedidoCompra createState() => _PedidoCompra();
}

class _PedidoCompra extends State<PedidoCompraPage> {
  final nomeProdutoController = TextEditingController();
  final descricaoProdutoController = TextEditingController();
  final precoProdutoController = TextEditingController();
  final categoriaProdutoController = TextEditingController();
  var quantidadeProdutoController = TextEditingController();

  int quantidade = 1;

  void aumentarQuantidade() {
    setState(() {
      quantidade = QuantidadeHelper.aumentarQuantidade(
          quantidade, quantidadeProdutoController);
    });
  }

  void diminuirQuantidade() {
    setState(() {
      quantidade = QuantidadeHelper.diminuirQuantidade(
          quantidade, quantidadeProdutoController);
    });
  }

  @override
  void initState() {
    super.initState();
    quantidadeProdutoController = TextEditingController(text: '1');
  }

  @override
  void dispose() {
    quantidadeProdutoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
        },
      )),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: TextFormField(
                    controller: nomeProdutoController,
                    decoration: InputDecoration(
                      labelText: 'Nome do Produto',
                      prefixIcon: Padding(
                        child: Icon(Icons.shopping_bag),
                        padding: EdgeInsets.all(5),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: TextFormField(
                    controller: precoProdutoController,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      CurrencyTextInputFormatter(
                        locale: 'pt-BR',
                        decimalDigits: 2,
                        symbol: 'R\$ ',
                      ),
                    ],
                    decoration: InputDecoration(
                      labelText: 'Preço de Custo',
                      prefixIcon: Padding(
                        child: Icon(Icons.attach_money),
                        padding: const EdgeInsets.all(10),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: TextFormField(
                    controller: categoriaProdutoController,
                    decoration: InputDecoration(
                      labelText: 'Categoria do Produto',
                      prefixIcon: Padding(
                        child: Icon(Icons.category_rounded),
                        padding: EdgeInsets.all(5),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: TextField(
                    textAlignVertical: TextAlignVertical.top,
                    controller: descricaoProdutoController,
                    maxLines: null,
                    maxLength: 255,
                    maxLengthEnforcement: MaxLengthEnforcement.enforced,
                    decoration: InputDecoration(
                      labelText: 'Descrição do Produto',
                      prefixIcon: Padding(
                        child: Icon(Icons.description),
                        padding: const EdgeInsets.all(10),
                      ),
                    ),
                    buildCounter: (
                      context, {
                      required int currentLength,
                      required int? maxLength,
                      required bool isFocused,
                    }) {
                      return DefaultTextStyle(
                        style: TextStyle(color: Colors.grey),
                        child: Text(
                          '$currentLength/$maxLength caracteres',
                          semanticsLabel: 'contador caracteres',
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text('Quantidade: '),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    IconButton(
                      onPressed: diminuirQuantidade,
                      icon: Icon(
                        Icons.remove_circle_outlined,
                        color: Colors.green,
                      ),
                    ),
                    Container(
                      width: 50.0, // ajuste este valor conforme necessário
                      child: TextFormField(
                        controller: quantidadeProdutoController,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 0.0),
                        ),
                        onChanged: (value) {
                          setState(() {
                            quantidade = int.parse(value);
                          });
                        },
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.add_circle_rounded,
                        color: Colors.green,
                      ),
                      onPressed: aumentarQuantidade,
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
