import 'package:flutter/material.dart';

class Classe {
  final String id;
  final String nome;
  final Color color;

  const Classe({
    required this.id,
    required this.nome,
    this.color = Colors.orange,
  });
}
