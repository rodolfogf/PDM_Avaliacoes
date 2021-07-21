import 'package:flutter/material.dart';
import 'tela_artista.dart';
import 'package:avaliacao2/telas/tela_musica.dart';
import 'package:avaliacao2/componentes/drawer_personalizado.dart';

class TelaTabulacao extends StatefulWidget {
  @override
  _TelaTabulacaoState createState() => _TelaTabulacaoState();
}

class _TelaTabulacaoState extends State<TelaTabulacao> {
  int telaSelecionada = 0;
  final List<Widget> telas = [
    TelaArtista(),
    TelaMusicas(),
  ];

  void selecionarTela(int tela) {
    setState(() {
      telaSelecionada = tela;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("SongList App"),
        ),
        body: telas[telaSelecionada],
        drawer: DrawerPersonalisado(),
      ),
    );
  }
}
