import 'package:euro_park_app/dao/vagaDAO.dart';
import 'package:euro_park_app/model/Vaga.dart';
import 'package:euro_park_app/telas/android/Vagas.dart';
import 'package:euro_park_app/telas/android/login.dart';
import 'package:euro_park_app/telas/android/usuarios.dart';
import 'package:flutter/material.dart';
import '../../dao/usuarioDAO.dart';
import '../../model/usuario.dart';

import 'listarvagas.dart';
import 'minhasReservas.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String fotoPerfil = ''; // Adicione essa variável para armazenar o caminho da foto

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Home'),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Column(
                  children: [
                    Text(
                      'Euro Park',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                title: Text('Nova Vaga'),
                leading: Icon(Icons.add_box),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return Vagas();
                  }));
                },
              ),
              ListTile(
                title: Text('Resevas'),
                leading: Icon(Icons.local_parking_outlined),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return MinhasReservas();
                  }));
                },
              ),
              ListTile(
                title: Text('Vagas'),
                leading: Icon(Icons.car_crash),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return ListarVagas();
                  }));
                },
              ),
              // ID do usuário fixo para teste
              ListTile(
                title: Text('Perfil'),
                leading: Icon(Icons.person_rounded),
                onTap: () async {
                  // Obtenha o usuário existente do banco de dados usando o ID fixo
                  UsuarioDAO usuarioDAO = UsuarioDAO();
                  Usuario usuarioExistente = await usuarioDAO.getUsuarioById(1);

                  // Navegue para a tela Usuarios passando o usuário existente como argumento
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return Usuarios(usuario: usuarioExistente);
                      },
                    ),
                  );
                },
              ),

              ListTile(
                title: Text('Sair'),
                leading: Icon(Icons.exit_to_app_outlined),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return Login();
                  }));
                },
              ),
            ],
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.car_repair,
                size: 48,
              ),
              SizedBox(height: 16),
              Text(
                'Bem vindo ao Euro Park',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
