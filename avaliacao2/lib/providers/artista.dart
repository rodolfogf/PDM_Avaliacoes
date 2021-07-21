import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:avaliacao2/model/artista.dart';
import 'package:http/http.dart' as http;
import 'package:avaliacao2/utils/variaveis.dart';

class ArtistasProvider with ChangeNotifier {
  List<Artista> _artistas = [];

  List<Artista> get getArtistas => [..._artistas];

  void adicionarArtista(Artista artista) {
    _artistas.add(artista);
    notifyListeners();
  }

  Future<void> postArtista(Artista artista) async {
    var url = Uri.https(Variaveis.BACKURL, '/artista.json');
    http
        .post(url,
            body: jsonEncode({
              'nome': artista.nomeArtista,
              'email': artista.email,
              'senha': artista.senha,
              'imagem': artista.imagemPerfil,
              'musicas': artista.musicas,
            }))
        .then((value) {
      adicionarArtista(artista);
    });
  }

  Future<void> patchArtista(Artista artista) async {
    var url =
        Uri.https(Variaveis.BACKURL, '/artistas/${artista.nomeArtista}.json');
    http
        .patch(url,
            body: jsonEncode({
              'nome': artista.nomeArtista,
              'imagem': artista.imagemPerfil,
              'email': artista.email,
              'senha': artista.senha,
              'musicas': artista.musicas,
            }))
        .then((value) {
      buscaArtistas();
      notifyListeners();
    });
  }

  Future<void> deleteArtista(Artista artista) async {
    var url =
        Uri.https(Variaveis.BACKURL, '/artistas/${artista.nomeArtista}.json');
    http
        .delete(url,
            body: jsonEncode({
              'nome': artista.nomeArtista,
              'email': artista.email,
              'senha': artista.senha,
              'musicas': artista.musicas,
              'imagem': artista.imagemPerfil,
            }))
        .then((value) {
      buscaArtistas();
      notifyListeners();
    });
  }

  //PARA FAZER REQUISIÇÕSE SINCRONAS DEVEMOS RETORNAR O FUTURE
  Future<void> buscaArtistas() async {
    var url = Uri.https(Variaveis.BACKURL, '/artistas.json');
    var resposta = await http.get(url);
    Map<String, dynamic> data = json.decode(resposta.body);
    _artistas.clear();
    data.forEach((idArtista, dadosArtista) {
      adicionarArtista(Artista(
        nomeArtista: idArtista,
        imagemPerfil: dadosArtista['imagem'],
        email: dadosArtista['email'],
        senha: dadosArtista['senha'],
        musicas: dadosArtista['musicas'],
      ));
    });
    notifyListeners();
  }
}
