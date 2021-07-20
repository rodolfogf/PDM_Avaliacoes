import 'package:flutter/material.dart';
import '../models/classes.dart';

import '../models/animais.dart';

class TelaDados extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final animal = ModalRoute.of(context)!.settings.arguments as Animal;
    final classe = ModalRoute.of(context)!.settings.arguments as Classe;
    return Scaffold(
        appBar: AppBar(
          title: Text("Animal"),
        ),
        body: Column(
          children: <Widget>[
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(animal.foto, fit: BoxFit.cover),
            ),
            Center(
              child: Text(
                animal.id,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Card(
              child: Text(classe.nome),
            ),
          ],
        ));
  }
}
