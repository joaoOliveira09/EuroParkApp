import 'package:flutter/material.dart';
import 'package:euro_park_app/model/Reservas.dart';
import 'package:euro_park_app/service/ReservasService.dart';

class MinhasReservas extends StatefulWidget {
  const MinhasReservas({Key? key}) : super(key: key);

  @override
  _MinhasReservasState createState() => _MinhasReservasState();
}

class _MinhasReservasState extends State<MinhasReservas> {
  final ReservasService _reservasService = ReservasService();
  List<Reservas> _reservas = [];

  @override
  void initState() {
    super.initState();
    _fetchReservas();
  }

  Future<void> _fetchReservas() async {
    try {
      final reservas = await _reservasService.fetchReservas();
      setState(() {
        _reservas = reservas;
      });
    } catch (e) {
      // Tratar erro de busca das reservas
      print('Erro ao buscar as reservas: $e');
    }
  }

  void _excluirReserva(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Excluir Reserva'),
          content: Text('Deseja excluir esta reserva?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Confirmar'),
              onPressed: () {
                setState(() {
                  _reservas.removeAt(index);
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Reservas",
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Reservas"),
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back),
          ),
        ),
        body: ListView.builder(
          itemCount: _reservas.length,
          itemBuilder: (context, index) {
            final Reservas reserva = _reservas[index];
            return Container(
              padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
              child: Card(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ListTile(
                      leading: Icon(Icons.car_crash_outlined),
                      title: Text('Vaga: ${reserva.vaga}'),
                      subtitle: Text(reserva.periodo),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        TextButton(
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.red,
                          ),
                          child: const Text('Excluir'),
                          onPressed: () {
                            _excluirReserva(index);
                          },
                        ),
                        const SizedBox(width: 8),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
