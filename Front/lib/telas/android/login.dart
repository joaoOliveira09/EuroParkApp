import 'package:euro_park_app/model/login.dart' as loginModel;
import 'package:euro_park_app/service/login_service.dart';
import 'package:flutter/material.dart';

import 'dashboard.dart';
import 'usuarios.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  String _loginErrorMessage = '';
  String _senhaErrorMessage = '';

  @override
  void dispose() {
    _loginController.dispose();
    _senhaController.dispose();
    super.dispose();
  }

  void _validateFields() {
    setState(() {
      _loginErrorMessage = '';
      _senhaErrorMessage = '';

      final login = _loginController.text.trim();
      final senha = _senhaController.text.trim();

      if (login.isEmpty) {
        _loginErrorMessage = 'Campo obrigatório';
      }

      if (senha.isEmpty) {
        _senhaErrorMessage = 'Campo obrigatório';
      }

      if (login.isNotEmpty && senha.isNotEmpty) {
        // Campos válidos, prosseguir com o login
        print('Login: $login');
        print('Senha: $senha');
        LoginService loginService = new LoginService();
        loginService.login(loginModel.Login(username: login,senha: senha), context);

      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "APP Mobile",
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Login"),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 70),
                  child: FlutterLogo(size: 80),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: TextField(
                    controller: _loginController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(80.0),
                      ),
                      labelText: 'Login',
                      errorText: _loginErrorMessage.isNotEmpty ? _loginErrorMessage : null,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: TextField(
                    controller: _senhaController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(80.0),
                      ),
                      labelText: 'Senha',
                      errorText: _senhaErrorMessage.isNotEmpty ? _senhaErrorMessage : null,
                    ),
                    obscureText: true,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size.fromHeight(50),
                    ),
                    child: const Text("Login"),
                    onPressed: _validateFields,
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(20),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size.fromHeight(30),
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      backgroundColor: Colors.green,
                    ),
                    child: const Text("Cadastre-se"),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return Usuarios();
                        }),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


