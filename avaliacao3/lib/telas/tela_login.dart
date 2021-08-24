import 'package:avaliacao_final/components/card_login.dart';
import 'package:flutter/material.dart';

class TelaLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
            decoration: BoxDecoration(
          color: Colors.green[700],
        )),
        Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: 4,
                  horizontal: 70,
                ),
                child: Text(
                  "Curso Online",
                  style: TextStyle(color: Colors.white, fontSize: 30),
                ),
              ),
              CardLogin()
            ],
          ),
        )
      ],
    ));
  }
}
