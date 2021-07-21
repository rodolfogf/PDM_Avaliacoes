import 'package:flutter/material.dart';
import 'package:avaliacao2/utils/rotas.dart';
import '../model/artista.dart';
import '../telas/tela_musica.dart';

class ItemArtista extends StatelessWidget {
  final Artista artista;
  const ItemArtista(this.artista);

  void _selecinarMusica(BuildContext context) {
    Navigator.of(context).pushNamed(
      Rotas.MUSICAS,
      arguments: artista,
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _selecinarMusica(context);
      },
      splashColor: Colors.deepPurple,
      child: Container(
        padding: EdgeInsets.all(15),
        child: Image.network(artista.artistaImagemPerfil),
      ),
    );
  }
}
