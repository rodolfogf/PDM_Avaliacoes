import 'package:flutter/material.dart';

class Musicas {
  final String musicaArtista;
  final String nomeMusica;
  final String duracao;
  final String estilo;

  const Musicas({
    @required this musicaArtista,
    @required this.nomeMusica,
    @required this.duracao,
    @required this.estilo,
  });
}
