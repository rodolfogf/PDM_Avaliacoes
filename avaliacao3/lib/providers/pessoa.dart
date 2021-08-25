import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:avaliacao_final/models/pessoa.dart';
import 'package:flutter/material.dart';
import 'package:avaliacao_final/utils/variaves.dart';

class PessoaProvider with ChangeNotifier {
  List<Pessoa> _pessoas = [];

  List<Pessoa> get getArtistas => [..._pessoas];

  void adicionarPessoa(Pessoa pessoa) {
    _pessoas.add(pessoa);
    notifyListeners();
  }

  Future<void> postPessoas(Pessoa pessoa) async {
    var url = Uri.https(Variaveis.BACKURL, '/pessoas.json');
    http
        .post(url,
            body: jsonEncode(
              {
                "nome": pessoa.pessoaNome,
                "CPF": pessoa.pessoaCPF,
                "Escolaridade": pessoa.pessoaEscolaridade,
                "foto": pessoa.pessoaFoto,
                "email": pessoa.pessoaEmail,
                "senha": pessoa.pessoaSenha
              },
            ))
        .then((value) {
      adicionarPessoa(pessoa);
    });
  }

  Future<void> deleteArtistas(Pessoa pessoa) async {
    var url = Uri.https(Variaveis.BACKURL, '/pessoas/${pessoa.pessoaId}.json');
    http.delete((url)).then((value) {
      buscaPessoas();
      notifyListeners();
    });
  }

  Future<void> buscaPessoas() async {
    var url = Uri.https(Variaveis.BACKURL, '/artistas.json');
    var resposta = await http.get(url);
    Map<String, dynamic> data = json.decode(resposta.body);
    _pessoas.clear();
    data.forEach((idPessoa, dadosPessoa) {
      adicionarPessoa(Pessoa(
          pessoaId: idPessoa,
          pessoaNome: dadosPessoa['nome'],
          pessoaCPF: dadosPessoa['cpf'],
          pessoaEscolaridade: dadosPessoa['Escolaridade'],
          pessoaFoto: dadosPessoa['foto'],
          pessoaEmail: dadosPessoa['email'],
          pessoaSenha: dadosPessoa['senha']));
    });
    notifyListeners();
  }
}
