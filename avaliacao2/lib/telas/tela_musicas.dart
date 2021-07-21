import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/artista.dart';
import '../componentes/item_musica.dart';
import 'package:avaliacao2/providers/musica.dart';
import 'package:avaliacao2/utils/rotas.dart';

class TelaMusicas extends StatefulWidget {
  @override
  _TelaMusicasState createState() => _TelaMusicasState();
}

class _TelaMusicasState extends State<TelaMusicas> {
  bool _isLoading = false;
  @override
  void initState() {
    super.initState();
    Provider.of<MusicasProvider>(context, listen: false)
        .buscaMusicas()
        .then((_) {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var musicas = [];
    final artista = ModalRoute.of(context).settings.arguments as Artista;
    final musicasFiltro = Provider.of<MusicasProvider>(context).getMusicas;
    musicasFiltro
        .map((e) => {
              if (e.musicaArtista == artista.nomeArtista) {musicas.add(e)}
            })
        .toList();
    return Scaffold(
        appBar: AppBar(
          title: Text('SongList App'),
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).pushNamed(Rotas.FORM_MUSICAS,
                    arguments: artista.nomeArtista);
              },
            )
          ],
        ),
        body: ListView.builder(
            itemCount: musicas.length,
            itemBuilder: (ctx, index) {
              return ItemMusica(musicas[index]);
            }));
  }
}
