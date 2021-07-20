import 'package:flutter/material.dart';

//importando meu modelo
import '../models/animais.dart';

//importando a tela de veículos

class ItemAnimal extends StatelessWidget {
  final Animal animal;

  const ItemAnimal(this.animal);

  void _selecionarAnimal(BuildContext context) {
    Navigator.of(context).pushNamed(
      '/detalhes_animais',
      arguments: animal,
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _selecionarAnimal(context);
      },
      splashColor: Colors.grey,
      child: Card(
          child: Column(
        children: [
          Stack(
            //Widget é opcional
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15)),
                child: Image.network(
                  animal.foto,
                  height: 250,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: 20,
                right: 10,
                child: Container(
                  width: 300,
                  color: Colors.black54,
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                  child: Text(
                    animal.id,
                    style: TextStyle(fontSize: 26, color: Colors.white),
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    Icon(Icons.attach_money_sharp),
                    SizedBox(width: 5),
                    Text(
                      animal.especie,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                Row(),
                Row()
              ],
            ),
          )
        ],
      )),
    );
  }
}
