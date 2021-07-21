import 'package:flutter/material.dart';
import 'package:avaliacao2/utils/rotas.dart';
import '../model/musica.dart';

class ItemMusica extends StatelessWidget {
  final Musicas musica;
  const ItemMusica(this.musica);

  void _selecionarMusica(BuildContext context) {
    Navigator.of(context).pushNamed(
      Rotas.DETALHES_MUSICAS,
      arguments: musica,
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _selecionarMusica(context);
      },
      splashColor: Colors.orange,
      child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          elevation: 4,
          margin: const EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15)),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Row(
                      children: [
                        Icon(Icons.info),
                        SizedBox(width: 5),
                        Text(
                          musica.musicasNome,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.timer),
                        SizedBox(width: 5),
                        Text(
                          musica.musicasDuracao,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.music_note),
                        SizedBox(width: 5),
                        Text(
                          musica.musicasEstilo,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          )),
    );
  }
}
