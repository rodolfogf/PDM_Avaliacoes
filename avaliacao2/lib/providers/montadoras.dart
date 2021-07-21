import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:navegacao_roteiro/mockdata/montadoras.dart';
import 'package:navegacao_roteiro/models/montadora.dart';
import 'package:http/http.dart' as http;
import 'package:navegacao_roteiro/utils/variaveis.dart';

//SEGUE O PADRÃO OBSERVER - A IDEIA É INFORMAR A TODOS INTERESSADOS QUE ACONTECEU ALGUMA MUDANÇA
class MontadorasProvider with ChangeNotifier {
  List<Montadora> _montadoras = [];

//Não quero passar o controle da lista para o get
  //portanto uso o operador ... para "separar os itens" em um novo vetor
  List<Montadora> get getMontadoras => [..._montadoras];

  void adicionarMontadora(Montadora montadora) {
    _montadoras.add(montadora);
    //nesse momento temos efetivamente uma mudança em nossos dados
    //estamos adicionando um valor a montadora portanto vamo informar ao padrão
    //que estamos realizando tal mudança
    notifyListeners();
  }

  //PARA FAZER REQUISIÇÕSE SINCRONAS DEVEMOS RETORNAR O FUTURE
  Future<void> buscaMontadoras() async {
    var url = Uri.https(Variaveis.BACKURL, '/montadoras.json');
    var resposta = await http.get(url);
    Map<String, dynamic> data = json.decode(resposta.body);
    _montadoras.clear();
    data.forEach((idMontadora, dadosMontadora) {
      adicionarMontadora(Montadora(
        id: idMontadora,
        nome: dadosMontadora['nome'],
        color: dadosMontadora['cor'],
      ));
    });
    notifyListeners();
  }
}
