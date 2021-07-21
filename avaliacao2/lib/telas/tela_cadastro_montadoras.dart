import 'package:flutter/material.dart';
import 'package:navegacao_roteiro/componentes/drawer_personalisado.dart';
import 'package:navegacao_roteiro/componentes/montadora_item_lista.dart';

import 'package:navegacao_roteiro/providers/montadoras.dart';
import 'package:navegacao_roteiro/utils/rotas.dart';
import 'package:provider/provider.dart';

class TelaCadastroMontadora extends StatefulWidget {
  @override
  _TelaCadastroMontadoraState createState() => _TelaCadastroMontadoraState();
}

class _TelaCadastroMontadoraState extends State<TelaCadastroMontadora> {
  bool _isLoading = false;
  @override
  void initState() {
    super.initState();
    Provider.of<MontadorasProvider>(context, listen: false)
        .buscaMontadoras()
        .then((_) {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final montadoras = Provider.of<MontadorasProvider>(context).getMontadoras;
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastro de Montadoras"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(Rotas.FORM_MONTADORAS);
            },
          )
        ],
      ),
      drawer: DrawerPersonalisado(),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: ListView.builder(
          itemCount: montadoras.length,
          itemBuilder: (ctx, i) => Column(
            children: [
              ItemListaMontadora(montadoras[i]),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
