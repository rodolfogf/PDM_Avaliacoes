import 'package:flutter/material.dart';

import '../models/classes.dart';
import '../mockdata/animais.dart';
import '../componentes/item_animal.dart';

class TelaAnimais extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final classe = ModalRoute.of(context)!.settings.arguments as Classe;
    final animalFiltro = ANIMAIS_MOCK
        .where((element) => element.id_classe.contains(classe.id))
        .toList();
    return Scaffold(
        appBar: AppBar(
          title: Text('AnimalApp'),
        ),
        body: ListView.builder(
            itemCount: animalFiltro.length,
            itemBuilder: (ctx, index) {
              return ItemAnimal(animalFiltro[index]);
            }));
  }
}
