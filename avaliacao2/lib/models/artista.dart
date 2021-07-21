import 'package:flutter/material.dart';
import 'package:models/musicas.dart';

class Artista {
  final String nome;
  final String imagem_perfil;
  final String email;
  final String senha;
  final String id;

  final List<Musicas> musicas;

  const Artista(
      {@required this.id,
      @required this.nome,
      @required this.senha,
      @required this.email,
      this.musicas,
      this.imagem_perfil});
}
