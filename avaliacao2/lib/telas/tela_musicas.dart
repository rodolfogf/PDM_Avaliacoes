import 'package:flutter/material.dart';

import '../models/artista.dart';
import '../mockdata/musicas.dart';
import '../componentes/item_musica.dart';

class TelaMusicas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final artista = ModalRoute.of(context)!.settings.arguments as Artista;
    final musicasFiltro = MUSICAS_MOCK
        .where((element) => element.id_artista.contains(artista.id))
        .toList();
    return Scaffold(
        appBar: AppBar(
          title: Text('Songlist App'),
        ),
        body: ListView.builder(
            itemCount: musicasFiltro.length,
            itemBuilder: (ctx, index) {
              return ItemMusica(musicasFiltro[index]);
            }));
  }
}
