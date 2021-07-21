import 'package:flutter/material.dart';
import 'package:avaliacao2/model/artista.dart';
import 'package:avaliacao2/providers/musica.dart';
import 'package:avaliacao2/utils/rotas.dart';
import 'package:provider/provider.dart';
import '../model/musica.dart';

class TelaDetalhesMusica extends StatelessWidget {
  void deleteMusica(context, musica) {
    Provider.of<MusicasProvider>(context, listen: false).deleteMusica(musica);
  }

  @override
  Widget build(BuildContext context) {
    final artista = ModalRoute.of(context).settings.arguments as Artista;
    final musica = ModalRoute.of(context).settings.arguments as Musicas;

    return Scaffold(
        appBar: AppBar(
          title: Text("Informações da Música"),
        ),
        body: Column(
          children: <Widget>[
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(artista.imagemPerfil, fit: BoxFit.cover),
            ),
            Center(
              child: Text(
                artista.artistaNome,
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
            Card(
              child: Text("Nome: ${musica.nomeMusica}"),
            ),
            Card(
              child: Text("Duração: ${musica.duracao}"),
            ),
            Card(
              child: Text("Estilo: ${musica.estilo}"),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    Navigator.of(context).pushNamed(
                      Rotas.FORM_MUSICAS,
                      arguments: musica,
                    );
                  },
                  color: Colors.grey,
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                              title: Text("Confirmação:"),
                              content: Text(
                                  "Excluir a música ${musica.nomeMusica}?"),
                              actions: [
                                TextButton(
                                  child: Text("Não"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                TextButton(
                                  child: Text("Sim"),
                                  onPressed: () {
                                    deleteMusica(context, musica);
                                    Navigator.of(context)
                                        .pushReplacementNamed('/');
                                  },
                                )
                              ],
                            ));
                  },
                  color: Colors.black,
                ),
              ],
            ),
          ],
        ));
  }
}
