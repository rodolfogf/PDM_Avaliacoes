import 'package:flutter/material.dart';
import 'package:avaliacao2/models/musicas.dart';

class Artista {
  final String nomeArtista;
  final String imagemPerfil;
  final String email;
  final String senha;

  final List<Musicas> musicas;

  const Artista({
    @required this.nomeArtista,
    @required this.email,
    @required this.senha,
    this.musicas,
    this.imagemPerfil,
  });
}
