import 'dart:math';
import 'package:flutter/material.dart';
import 'package:avaliacao2/model/artista.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:avaliacao2/providers/artista.dart';

class TelaFormArtista extends StatefulWidget {
  @override
  TelaFormArtistaState createState() => TelaFormArtistaState();
}

class TelaFormArtistaState extends State<TelaFormArtista> {
  final form = GlobalKey<FormState>();
  final dadosForm = Map<String, Object>();

  void saveForm(context, Artista artista) {
    var formValido = form.currentState.validate();
    form.currentState.save();

    final novoArtista = Artista(
      nomeArtista: artista == null
          ? Random().nextDouble().toString()
          : artista.nomeArtista,
      imagemPerfil: dadosForm['imagem'],
      email: dadosForm['email'],
      senha: dadosForm['senha'],
    );

    if (formValido) {
      if (artista == null) {
        Provider.of<ArtistasProvider>(context, listen: false)
            .postArtista(novoArtista);
        Navigator.of(context).pop();
      } else {
        Provider.of<ArtistasProvider>(context, listen: false)
            .patchArtista(novoArtista);
        Navigator.of(context).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final artista = ModalRoute.of(context).settings.arguments as Artista;
    return Scaffold(
      appBar: AppBar(
        title: Text("Artista"),
        actions: [
          IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                saveForm(context, artista);
              })
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Form(
          key: form,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Nome do Artista'),
                textInputAction: TextInputAction.next,
                initialValue: artista == null ? '' : artista.nomeArtista,
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
                decoration: InputDecoration(labelText: 'Logo URL'),
                textInputAction: TextInputAction.done,
                initialValue: artista == null ? '' : artista.imagemPerfil,
                onSaved: (value) {
                  dadosForm['imagem'] = value;
                },
                onFieldSubmitted: (_) {
                  saveForm(context, artista);
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Email do Artista'),
                textInputAction: TextInputAction.next,
                initialValue: artista == null ? '' : artista.email,
                onSaved: (value) {
                  dadosForm['email'] = value;
                },
                validator: (value) {
                  if (value.trim().isEmpty) {
                    return "Email válido";
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Senha do Artista'),
                textInputAction: TextInputAction.next,
                initialValue: artista == null ? '' : artista.senha,
                onSaved: (value) {
                  dadosForm['senha'] = value;
                },
                validator: (value) {
                  if (value.trim().isEmpty) {
                    return "Senha válida";
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
