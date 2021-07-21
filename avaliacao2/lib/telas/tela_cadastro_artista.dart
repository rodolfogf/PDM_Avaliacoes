import 'package:flutter/material.dart';
import 'package:avaliacao2/componentes/drawer_personalizado.dart';
import 'package:avaliacao2/componentes/artista_item_lista.dart';
import 'package:avaliacao2/providers/artista.dart';
import 'package:avaliacao2/utils/rotas.dart';
import 'package:provider/provider.dart';

class TelaCadastroArtista extends StatefulWidget {
  @override
  _TelaCadastroArtistaState createState() => _TelaCadastroArtistaState();
}

class _TelaCadastroArtistaState extends State<TelaCadastroArtista> {
  bool _isLoading = false;

  Future<void> _atualizarLista(BuildContext context) {
    return Provider.of<ArtistasProvider>(context, listen: false)
        .buscaArtistas();
  }

  @override
  void initState() {
    super.initState();
    Provider.of<ArtistasProvider>(context, listen: false)
        .buscaArtistas()
        .then((_) {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final artistas = Provider.of<ArtistasProvider>(context).getArtistas;
    return Scaffold(
        appBar: AppBar(
          title: Text("Artistas"),
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).pushNamed(Rotas.FORM_ARTISTAS);
              },
            )
          ],
        ),
        drawer: DrawerPersonalisado(),
        body: RefreshIndicator(
          onRefresh: () => _atualizarLista(context),
          child: Padding(
            padding: EdgeInsets.all(15),
            child: ListView.builder(
              itemCount: artistas.length,
              itemBuilder: (ctx, i) => Column(
                children: [
                  ItemListaArtista(artistas[i]),
                  Divider(),
                ],
              ),
            ),
          ),
        ));
  }
}
