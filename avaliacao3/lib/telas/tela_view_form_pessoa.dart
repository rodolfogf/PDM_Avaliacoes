import 'dart:io';
import 'dart:math';

import 'package:avaliacao_final/utils/rotas.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:avaliacao_final/components/card_login.dart';
import 'package:avaliacao_final/models/pessoa.dart';
import 'package:avaliacao_final/providers/login.dart';
import 'package:avaliacao_final/providers/pessoa.dart';

class ViewFormPessoa extends StatefulWidget {
  @override
  ViewFormPessoaState createState() => ViewFormPessoaState();
}

class ViewFormPessoaState extends State<ViewFormPessoa> {
  final form = GlobalKey<FormState>();
  final dadosForm = Map<String, Object>();
  final controladorSenha = TextEditingController();
  ModoAutenticacao modoAutenticacao = ModoAutenticacao.Login;
  bool loading = false;
  late File imagem;

  final Map<String, String> dadosAutenticacao = {
    'email': '',
    'senha': '',
  };

  void showError() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title:
            Text("Dados incorretos!", style: TextStyle(color: Colors.black87)),
        backgroundColor: Colors.lightGreen,
      ),
    );
  }

  void saveForm(context, pessoa) async {
    if (!form.currentState!.validate()) {
      return;
    }

    setState(() {
      loading = true;
    });

    form.currentState!.save();

    Login login = Provider.of(context, listen: false);

    await login.registrar(
      dadosAutenticacao['email']!,
      dadosAutenticacao['senha']!,
    );
    setState(() {
      loading = false;
    });

    var formValido = form.currentState!.validate();
    form.currentState!.save();
    final novaPessoa = Pessoa(
      pessoaId:
          pessoa == null ? Random().nextDouble().toString() : pessoa.pessoaId,
      pessoaNome: dadosForm['nome'].toString(),
      pessoaCPF: dadosForm['cpf'].toString(),
      pessoaEscolaridade: dadosForm['Escolaridade'].toString(),
      pessoaFoto: dadosForm['foto'].toString(),
      pessoaEmail: dadosForm['email'].toString(),
      pessoaSenha: dadosForm['senha'].toString(),
    );
    if (formValido) {
      Provider.of<PessoaProvider>(context, listen: false)
          .postPessoas(novaPessoa);
      Navigator.of(context).pushReplacementNamed(Rotas.AUTH);
    }
  }

  @override
  Widget build(BuildContext context) {
    var pessoa;
    if (ModalRoute.of(context)!.settings.arguments == null) {
      pessoa = null;
    } else {
      pessoa = ModalRoute.of(context)!.settings.arguments as Pessoa;
    }

    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: EdgeInsets.all(5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () =>
                    Navigator.of(context).pushReplacementNamed(Rotas.AUTH),
                child: Icon(Icons.arrow_back),
              ),
              Text("Cadastre no curso desejado"),
              Image.network(
                "https://static.mundoeducacao.uol.com.br/vestibular/vestibular/regularidade-cursos-instituicoes-pode-ser-conferida-pela-internet-53c01a80260cb.jpg",
                height: 30,
                fit: BoxFit.scaleDown,
              )
            ],
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Form(
          key: form,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(
                    labelText: 'Nome',
                    fillColor: Colors.black,
                    focusColor: Colors.black),
                textInputAction: TextInputAction.next,
                onSaved: (value) {
                  dadosForm['nome'] = value!;
                },
                validator: (value) {
                  if (value!.trim().isEmpty) {
                    return "Há caracteres inválidos no nome";
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                    labelText: 'CPF',
                    fillColor: Colors.black,
                    focusColor: Colors.black),
                textInputAction: TextInputAction.next,
                onSaved: (value) {
                  dadosForm['cpf'] = value!;
                },
                validator: (value) {
                  if (value!.trim().isEmpty) {
                    return "CPF inválido";
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                    labelText: 'Grau de Escolaridade',
                    fillColor: Colors.black,
                    focusColor: Colors.black),
                textInputAction: TextInputAction.next,
                onSaved: (value) {
                  dadosForm['Escolaridade'] = value!;
                },
                validator: (value) {
                  if (value!.trim().isEmpty) {
                    return "Há caracteres inválidos no grau de escolaridade informado";
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                    labelText: 'E-mail',
                    fillColor: Colors.black,
                    focusColor: Colors.black),
                textInputAction: TextInputAction.next,
                onSaved: (value) {
                  dadosForm['email'] = value!;
                },
                validator: (value) {
                  if ((value!.trim().isEmpty)) {
                    return "Email inválido";
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                    labelText: 'Senha',
                    fillColor: Colors.black,
                    focusColor: Colors.black),
                textInputAction: TextInputAction.done,
                obscureText: true,
                controller: controladorSenha,
                onSaved: (value) {
                  dadosForm['senha'] = value!;
                },
                validator: (value) {
                  if (value!.trim().isEmpty) {
                    return "A senha não está de acordo com os padrões de senha";
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                    labelText: 'Confirme a Senha',
                    fillColor: Colors.black,
                    focusColor: Colors.black),
                textInputAction: TextInputAction.done,
                obscureText: true,
                validator: modoAutenticacao == ModoAutenticacao.Cadastro
                    ? (value) {
                        if (value != controladorSenha.text) {
                          return "As senhas informadas são diferentes";
                        }
                        return null;
                      }
                    : null,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                child: ElevatedButton.icon(
                  onPressed: () => {},
                  icon: Icon(Icons.camera_alt, color: Colors.yellowAccent[700]),
                  label: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text('Foto do perfil',
                        style: TextStyle(color: Colors.yellowAccent[700])),
                  ),
                  style: ElevatedButton.styleFrom(
                      primary: Color(0xff565656),
                      elevation: 0.0,
                      textStyle: TextStyle(fontSize: 18)),
                ),
              ),
              Container(
                width: 180,
                height: 100,
                decoration: BoxDecoration(
                    border: Border.all(
                  width: 1,
                  color: Colors.green,
                )),
                alignment: Alignment.center,
                child: pessoa != null
                    ? Image.file(
                        imagem != null ? imagem : File(pessoa.foto),
                        width: double.infinity,
                        fit: BoxFit.cover,
                      )
                    : Text("Sem imagem"),
              ),
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.all(10),
                        child: Container(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shadowColor: Color(0xff000000),
                              primary: Colors.green[600],
                            ),
                            onPressed: () {
                              saveForm(context, pessoa);
                            },
                            child: const Text('Gravar',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 24)),
                          ),
                        ))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
