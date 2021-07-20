import 'package:flutter/material.dart';
import 'telas/tela_animais.dart';
import 'telas/tela_animais_dados.dart';

void main() => runApp(Animais());

class Animais extends StatefulWidget {
  @override
  _AnimaisState createState() => _AnimaisState();
}

class _AnimaisState extends State<Animais> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        'telas/animais': (ctx) => TelaAnimais(),
        'telas/animais_dados': (ctx) => TelaDados(),
      },
      onGenerateRoute: (settings) {
        print(settings.name);
        return null;
      },
      home: Scaffold(
        appBar: AppBar(
          title: Text("AnimalApp"),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Row(
                children: [],
              )
            ],
          ),
        ),
      ),
    );
  }
}
