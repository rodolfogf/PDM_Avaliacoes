import 'package:flutter/material.dart';
import 'package:navegacao_roteiro/utils/rotas.dart';

//importando meu modelo
import '../models/artista.dart';

//importando a tela de veículos
import '../telas/tela_musicas.dart';

class ItemMontadora extends StatelessWidget {
  final Artista artista;

  const ItemArtista(this.artista);

  void _selecionarMusica(BuildContext context) {
    //vamos fazer um push de tela
    // Navigator.of(context).push(MaterialPageRoute(builder: (_) {
    //   return TelaVeiculos();
    // }));

    Navigator.of(context).pushNamed(
      Rotas.MUSICAS,
      arguments: artista,
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _selecionarMusica(context);
      },
      splashColor: Colors.orange,
      child: Container(
        padding: EdgeInsets.all(15),
        child: Text(artista.nome),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: LinearGradient(colors: [
              Color(int.parse('0x${artista.color}')).withOpacity(0.5),
              Color(int.parse('0x${artista.color}')),
            ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
      ),
    );
  }
}
