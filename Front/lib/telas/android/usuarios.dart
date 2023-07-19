import 'package:euro_park_app/dao/usuarioDAO.dart';
import 'package:euro_park_app/model/usuario.dart';
import 'package:euro_park_app/telas/android/dashboard.dart';
import 'package:euro_park_app/telas/android/login.dart';
import 'package:flutter/material.dart';

class Usuarios extends StatefulWidget {
  final Usuario? usuario; // Alteração: permitir que o usuário seja nulo

  Usuarios({this.usuario});

  @override
  _UsuariosState createState() => _UsuariosState();
}

class _UsuariosState extends State<Usuarios> {
  final TextEditingController loginController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();
  final TextEditingController saldoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Inicialize os controladores de texto com os valores do usuário existente
    if (widget.usuario != null) {
      loginController.text = widget.usuario!.login;
      senhaController.text = widget.usuario!.senha;
      saldoController.text = widget.usuario!.saldo.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Usuários",
      home: Scaffold(
        appBar: AppBar(
          title: Text(widget.usuario != null ? "Editar Usuário" : "Cadastrar Usuário"), // Alteração: título dinâmico
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back),
          ),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 200, 20, 0),
                  child: TextField(
                    controller: loginController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(80.0),
                      ),
                      labelText: 'Login',
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: TextField(
                    controller: senhaController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(80.0),
                      ),
                      labelText: 'Senha',
                    ),
                    obscureText: true,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: TextField(
                    controller: saldoController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(80.0),
                      ),
                      labelText: 'Saldo',
                    ),
                    obscureText: false,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size.fromHeight(50),
                    ),
                    child: Text(widget.usuario != null ? "Atualizar" : "Cadastrar"), // Alteração: rótulo do botão dinâmico
                    onPressed: () async {
                      String login = loginController.text;
                      String senha = senhaController.text;
                      double saldo = double.parse(saldoController.text);

                      // Criar ou atualizar objeto usuário com os dados fornecidos
                      Usuario u = Usuario(
                        id: 1, // ID fixo do usuário
                        login: login,
                        senha: senha,
                        saldo: saldo,
                      );

                      // Verificar se é uma operação de cadastro ou edição
                      if (widget.usuario != null) {
                        // Atualizar usuário no banco de dados
                        await UsuarioDAO().atualizar(u);
                      } else {
                        // Inserir usuário no banco de dados
                        await UsuarioDAO().adicionar(u);
                        Navigator.push(context, MaterialPageRoute(builder: (context){
                          return Login();
                        }));
                      }

                      // Recuperar o usuário atualizado pelo ID fixo
                      Usuario usuarioAtualizado = await UsuarioDAO().getUsuarioById(1);

                      // Exibir as informações do usuário atualizado
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Usuário Atualizado"),
                            content: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text("ID: ${usuarioAtualizado.id}"),
                                Text("Login: ${usuarioAtualizado.login}"),
                                Text("Senha: ${usuarioAtualizado.senha}"),
                                Text("Saldo: ${usuarioAtualizado.saldo}"),
                              ],
                            ),
                            actions: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context){
                                    return Dashboard();
                                  }));
                                },
                                child: Text("OK"),
                              ),
                            ],
                          );
                        },
                      );
                    },
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
