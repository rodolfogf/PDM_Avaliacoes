import 'package:flutter/material.dart';
import 'package:navegacao_roteiro/models/montadora.dart';

class ItemListaMontadora extends StatelessWidget {
  final Montadora montadora;

  ItemListaMontadora(this.montadora);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: Color(int.parse('0x${montadora.color}')),
      title: Container(
        child: Text(
          montadora.nome,
          style: TextStyle(color: Colors.black),
        ),
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                print("Editar");
              },
              color: Colors.grey,
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                print("Apagar");
              },
              color: Colors.purple,
            ),
          ],
        ),
      ),
    );
  }
}
