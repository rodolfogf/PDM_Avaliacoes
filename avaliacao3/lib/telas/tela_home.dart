import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:avaliacao_final/providers/login.dart';
import 'package:avaliacao_final/utils/rotas.dart';

class TelaTabulacao extends StatefulWidget {
  @override
  _TelaTabulacaoState createState() => _TelaTabulacaoState();
}

class _TelaTabulacaoState extends State<TelaTabulacao> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: EdgeInsets.all(5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Cadastro do usuário:",
                  style: TextStyle(color: Colors.black87)),
              Image.network(
                "https://w7.pngwing.com/pngs/340/956/png-transparent-profile-user-icon-computer-icons-user-profile-head-ico-miscellaneous-black-desktop-wallpaper.png",
                height: 52,
                fit: BoxFit.scaleDown,
              )
            ],
          ),
        ),
      ),
      body: GridView(
        padding: EdgeInsets.all(15),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 500,
          childAspectRatio: 2.7,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        children: [],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Provider.of<Login>(context, listen: false).logout();
          Navigator.of(context).pushReplacementNamed(Rotas.AUTH);
        },
        child: const Icon(Icons.exit_to_app),
        backgroundColor: Colors.lightGreen,
      ),
    );
  }
}
