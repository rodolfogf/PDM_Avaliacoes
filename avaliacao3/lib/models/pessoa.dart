import 'package:flutter/material.dart';

class Pessoa {
  final String pessoaId;
  final String pessoaNome;
  final String pessoaCPF;
  final String pessoaEscolaridade;
  final String pessoaFoto;
  final String pessoaEmail;
  final String pessoaSenha;

  const Pessoa({
    @required this.pessoaId,
    @required this.pessoaNome,
    @required this.pessoaCPF,
    @required this.pessoaEscolaridade,
    @required this.pessoaFoto,
    @required this.pessoaEmail,
    @required this.pessoaSenha,
  });
}
