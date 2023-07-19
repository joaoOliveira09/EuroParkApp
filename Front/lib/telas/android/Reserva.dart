import 'package:euro_park_app/model/Reservas.dart';
import 'package:euro_park_app/service/ReservasService.dart';
import 'package:flutter/material.dart';

import '../../dao/usuarioDAO.dart';
import 'dashboard.dart';

class Reserva extends StatelessWidget {
  final TextEditingController periodoController = TextEditingController();
  final TextEditingController vagaController = TextEditingController();
  final ReservasService _reservasService = ReservasService();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Reserva",
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Reserva"),
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
                    controller: vagaController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(80.0),
                      ),
                      labelText: 'Vaga',
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: TextField(
                    controller: periodoController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(80.0),
                      ),
                      labelText: 'Período Da Reserva',
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size.fromHeight(50),
                    ),
                    child: const Text("Cadastrar"),
                    onPressed: () async {
                      int vaga = int.tryParse(vagaController.text) ?? 0;
                      String periodo = periodoController.text;

                      Reservas r = Reservas(
                        vaga: vaga,
                        periodo: periodo,
                      );

                      try {
                        await _reservasService.createReserva(r);

                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Reserva Cadastrada'),
                              content: const Text('Sua reserva foi cadastrada com sucesso!'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return Dashboard();
                                        },
                                      ),
                                    );
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      } catch (e) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Erro ao cadastrar reserva'),
                              content: const Text('Ocorreu um erro ao cadastrar a reserva.'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      }
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
