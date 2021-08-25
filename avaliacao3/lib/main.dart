import 'package:avaliacao_final/providers/login.dart';
import 'package:avaliacao_final/providers/pessoa.dart';
import 'package:avaliacao_final/services/authentication_service.dart';
import 'package:avaliacao_final/telas/tela_home.dart';
import 'package:avaliacao_final/telas/tela_login.dart';
import 'package:avaliacao_final/telas/view_form_pessoa.dart';
import 'package:avaliacao_final/utils/rotas.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthenticationService>(
          create: (ctx) => AuthenticationService(),
        ),
        ChangeNotifierProvider<Login>(
          create: (ctx) => Login(),
        ),
        ChangeNotifierProvider<PessoaProvider>(
          create: (ctx) => PessoaProvider(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(primaryColor: Colors.limeAccent[700]),
        routes: {
          Rotas.AUTH: (ctx) => TelaLogin(),
          Rotas.HOME: (ctx) => TelaTabulacao(),
          Rotas.CAD_PESSOAS: (ctx) => ViewFormPessoa()
        },
        onGenerateRoute: (settings) {
          return null;
        },
        onUnknownRoute: (settings) {
          return null;
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
