import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:p2/model/artista.dart';
import 'package:p2/model/musica.dart';
import 'package:p2/utils/variaveis.dart';

//verificar porque está acusando erro nas listas
class MusicasProvider with ChangeNotifier {
  List<Artista> _artista = [];
  List<Musicas> _musicas = [];

  List<Musicas> get getMusicas => [..._musicas];

  Future<void> postMusicas(Musicas musica) async {
    var url = Uri.https(
        Variaveis.BACKURL, '/artista/${musica.nomeMusica}/musica.json');
    http
        .post(url,
            body: jsonEncode({
              'nome': musica.nomeMusica,
              'duracao': musica.duracao,
              'estilo': musica.estilo,
            }))
        .then((value) {
      adicionarMusica(musica);
    });
  }

  void adicionarMusica(Musicas musica) {
    _musicas.add(musica);
    notifyListeners();
  }

  Future<void> deleteMusica(Musicas musica) async {
    var url = Uri.https(Variaveis.BACKURL,
        '/artistas/${musica.musicaArtista}/musicas/${musica.nomeMusica}.json');
    http
        .delete(url,
            body: jsonEncode({
              'nome': musica.nomeMusica,
              'duracao': musica.duracao,
              'estilo': musica.estilo,
            }))
        .then((value) {
      notifyListeners();
    });
  }

  Future<void> buscaMusicas() async {
    var url = Uri.https(Variaveis.BACKURL, '/artistas.json');
    var resposta = await http.get(url);
    Map<String, dynamic> data = json.decode(resposta.body);
    _artista.clear();
    _musicas.clear();
    data.forEach((idArtista, dadosArtista) {
      Map<String, dynamic> dadosMusica = dadosArtista['musicas'];
      dadosMusica.forEach((idMusica, musica) {
        adicionarMusica(Musicas(
          musicaArtista: idMusica,
          nomeMusica: musica['nome'],
          duracao: musica['duracao'],
          estilo: musica['estilo'],
        ));
      });
    });
    notifyListeners();
  }
}
