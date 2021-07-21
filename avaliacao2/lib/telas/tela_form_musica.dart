import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:avaliacao2/model/artista.dart';
import 'package:avaliacao2/model/musica.dart';
import 'package:avaliacao2/providers/musica.dart';
import 'package:provider/provider.dart';

//import '../models/montadora.dart';

class TelaFormMusicaState extends StatelessWidget {
  final form = GlobalKey<FormState>();
  final dadosForm = Map<String, Object>();

  void saveForm(BuildContext context, idArtista, musica, type) {
    var formValido = form.currentState.validate();
    form.currentState.save();

    final novaMusica = Musicas(
      nomeMusica: type == 0 ? musica.id.toString() : musica.id.toString(),
      duracao: dadosForm['duracao'].toString(),
      estilo: dadosForm['estilo'].toString(),
      musicaArtista: type == 1 ? Random().nextDouble().toString() : musica.id,
    );

    if (formValido) {
      if (type == 1) {
        Provider.of<MusicasProvider>(context, listen: false)
            .postMusicas(novaMusica);
      } else {
        //Provider.of<MusicasProvider>(context, listen: false).patchMusica(novaMusica);
      }
      Navigator.of(context).pushReplacementNamed('/');
    }
  }

  @override
  Widget build(BuildContext context) {
    var idArtista;
    var musica;
    var type = 0;

    if (ModalRoute.of(context).settings.arguments.runtimeType.toString() ==
        'String') {
      idArtista = ModalRoute.of(context).settings.arguments as String;
      type = 1;
    } else {
      musica = ModalRoute.of(context).settings.arguments as Musicas;
    }

    return Scaffold(
        appBar: AppBar(
          title: Text("Musicas"),
          actions: [
            IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                type == 0
                    ? saveForm(context, idArtista, musica, type)
                    : saveForm(context, idArtista, musica, type);
              },
            )
          ],
        ),
        body: Padding(
            padding: EdgeInsets.all(15),
            child: Form(
                key: form,
                child: ListView(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(labelText: "Nome"),
                      textInputAction: TextInputAction.next,
                      initialValue: type == 0 ? musica.nome : '',
                      onSaved: (value) {
                        dadosForm['nome'] = value;
                      },
                      validator: (value) {
                        if (value.trim().isEmpty) {
                          return "Nome inválido";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: "Duração"),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      initialValue: type == 0 ? musica.duracao : '',
                      onSaved: (value) {
                        dadosForm['duracao'] = value;
                      },
                      validator: (value) {
                        if (value.trim().isEmpty) {
                          return "Duração da música inválida";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: "Estilo"),
                      textInputAction: TextInputAction.next,
                      initialValue: type == 0 ? musica.estilo : '',
                      onSaved: (value) {
                        dadosForm['estilo'] = value;
                      },
                      validator: (value) {
                        if (value.trim().isEmpty) {
                          return "Estilo inválido";
                        }
                        return null;
                      },
                      onFieldSubmitted: (_) {
                        type == 0
                            ? saveForm(context, idArtista, musica, type)
                            : saveForm(context, idArtista, musica, type);
                      },
                    ),
                  ],
                ))));
  }
}
