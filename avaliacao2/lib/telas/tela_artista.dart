import 'package:flutter/material.dart';
import 'package:avaliacao2/providers/artista.dart';
import 'package:provider/provider.dart';
import '../componentes/item_artista.dart';

//! Verificar erro no provider !
class TelaArtista extends StatefulWidget {
  @override
  _TelaArtistaState createState() => _TelaArtistaState();
}

class _TelaArtistaState extends State<TelaArtista> {
  bool _isLoading = false;
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
    return GridView(
      padding: EdgeInsets.all(15),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 180,
        childAspectRatio: 1.25,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      children: artistas.map((e) {
        return ItemArtista(e);
      }).toList(),
    );
  }
}
