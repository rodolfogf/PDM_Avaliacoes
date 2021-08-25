import 'package:avaliacao_final/providers/login.dart';
import 'package:avaliacao_final/utils/rotas.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum ModoAutenticacao { Cadastro, Login }

class CardLogin extends StatefulWidget {
  @override
  _CardLoginState createState() => _CardLoginState();
}

class _CardLoginState extends State<CardLogin> {
  final controladorSenha = TextEditingController();
  ModoAutenticacao modoAutenticacao = ModoAutenticacao.Login;
  bool loading = false;
  final form = GlobalKey<FormState>();

  final Map<String, String> dadosAutenticacao = {
    'email': '',
    'senha': '',
  };

  void showError() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text("Dados incorretos!", style: TextStyle(color: Colors.greenAccent[70])),
        backgroundColor: Colors.orange,
      ),
    );
  }

  Future<void> submit() async {
    if (!form.currentState!.validate()) {
      return;
    }

    setState(() {
      loading = true;
    });

    form.currentState!.save();

    Login login = Provider.of(context, listen: false);

    try {
      await login.realizaLogin(
        dadosAutenticacao['email']!,
        dadosAutenticacao['senha']!,
      );
      Navigator.of(context).pushReplacementNamed(Rotas.HOME);
    } catch (e) {
      showError();
    }

    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final dimensoesDispositivo = MediaQuery.of(context).size;

    return Card(
      child: Container(
        color: Colors.yellowAccent[90],
        width: dimensoesDispositivo.width * 0.75,
        height: modoAutenticacao == ModoAutenticacao.Login ? 360 : 420,
        child: Form(
          key: form,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 2, 0, 15),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle: TextStyle(color: Colors.black)
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value!.isEmpty || !value.contains('@')) {
                        return "O email informado é inválido!";
                      }
                      return null;
                    },
                    onSaved: (value) => dadosAutenticacao['email'] = value!,
                  ),
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Senha',
                    labelStyle: TextStyle(color: Colors.black)
                  ),
                  controller: controladorSenha,
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty || value.length < 5) {
                      return "A senha informada é inválida!";
                    }
                    return null;
                  },
                  onSaved: (value) => {dadosAutenticacao['senha'] = value!}
                ),
                if (modoAutenticacao == ModoAutenticacao.Cadastro) 
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Confirmar senha',
                        labelStyle: TextStyle(color: Colors.black)
                      ),
                      obscureText: true,
                      validator: modoAutenticacao == ModoAutenticacao.Cadastro
                        ? (value) {
                            if (value != controladorSenha.text) {
                              return "As senhas são diferentes!";
                            }
                            return null;
                          }
                        : null,
                    ),
                  ),
                SizedBox(height: 20),
                if (loading)
                  CircularProgressIndicator()
                else
                  TextButton(
                    child: Container(
                      width: dimensoesDispositivo.width * 0.80,
                      height: 50,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: Colors.blueAccent,
                      ),
                      child: Text(
                        "Verificar dados",
                        style: TextStyle(color: Colors.white, fontSize: 26)  
                      ),
                    ),
                    onPressed: () {
                      submit();
                    },
                  ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: TextButton(
                    onPressed: () =>
                      Navigator.of(context).pushReplacementNamed(Rotas.CAD_PESSOAS),
                    child: Text(
                      "Faça o seu cadastro,
                      style: TextStyle(color: Colors.black)
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}