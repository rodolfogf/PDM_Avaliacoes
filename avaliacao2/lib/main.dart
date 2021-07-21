import 'package:flutter/material.dart';
import 'package:avaliacao2/providers/artista.dart';
import 'package:avaliacao2/telas/tela_cadastro-artistas.dart';
import 'package:avaliacao2/telas/tela_form_artista.dart';
import 'package:avaliacao2/providers/musica.dart';
import 'telas/tela_musica.dart';
import 'telas/tela_detalhes_musica.dart';
import 'package:avaliacao2/telas/tela_form_musica.dart';
import 'package:avaliacao2/utils/rotas.dart';
import 'package:provider/provider.dart';
import 'telas/tela_guias.dart';
//import 'telas/tela_parametros.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ArtistasProvider>(
          create: (ctx) => ArtistasProvider(),
        ),
        ChangeNotifierProvider<MusicasProvider>(
          create: (ctx) => MusicasProvider(),
        )
      ],
      child: MaterialApp(
        theme: ThemeData(primarySwatch: Colors.yellow),
        routes: {
          Rotas.HOME: (ctx) => TelaTabulacao(),
          Rotas.CAD_ARTISTAS: (ctx) => TelaCadastroArtista(),
          Rotas.FORM_ARTISTAS: (ctx) => TelaFormArtista(),
          Rotas.MUSICAS: (ctx) => TelaMusicas(),
          Rotas.DETALHES_MUSICAS: (ctx) => TelaDetalhesMusica(),
          Rotas.FORM_MUSICAS: (ctx) => TelaFormMusicaState(),
        },
        onGenerateRoute: (settings) {
          print(settings.name);
          return null;
        },
        onUnknownRoute: (settings) {
          print("Rota não encontrada");
          return null;
        },
      ),
    );
  }
}
