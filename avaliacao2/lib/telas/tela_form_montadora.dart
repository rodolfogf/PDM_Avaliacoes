import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:navegacao_roteiro/models/montadora.dart';

import 'package:http/http.dart' as http;
import 'package:navegacao_roteiro/providers/montadoras.dart';
import 'package:navegacao_roteiro/utils/variaveis.dart';
import 'package:provider/provider.dart';

class TelaFormMontadora extends StatefulWidget {
  @override
  TelaFormMontadoraState createState() => TelaFormMontadoraState();
}

class TelaFormMontadoraState extends State<TelaFormMontadora> {
  final form = GlobalKey<FormState>();
  final dadosForm = Map<String, Object>();

  void saveForm(context) {
    var formValido = form.currentState.validate();

    form.currentState.save();

    final novaMontadora = Montadora(
        id: Random().nextDouble().toString(),
        nome: dadosForm['nome'],
        color: dadosForm['cor']);

    print(novaMontadora.id);
    print(novaMontadora.nome);

    if (formValido) {
      //var url = Uri.https(Variaveis.BACKURL, '/montadoras.json');
      // http
      //     .post(url,
      //         body: jsonEncode(
      //           {
      //             'nome': dadosForm['nome'],
      //             "cor": dadosForm['cor'],
      //           },
      //         ))
      //     .then((value) {

      //});
      Provider.of<MontadorasProvider>(context, listen: false)
          .adicionarMontadora(novaMontadora);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Formulário Montadora"),
        actions: [
          IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                saveForm(context);
              })
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Form(
          key: form,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Nome Montadora'),
                textInputAction: TextInputAction.next,
                onSaved: (value) {
                  dadosForm['nome'] = value;
                },
                validator: (value) {
                  if (value.trim().isEmpty) {
                    return "Informe um nome válido";
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Cor'),
                textInputAction: TextInputAction.done,
                onSaved: (value) {
                  dadosForm['cor'] = value;
                },
                onFieldSubmitted: (_) {
                  saveForm(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
