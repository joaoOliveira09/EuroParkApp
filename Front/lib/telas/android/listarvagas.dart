import 'package:euro_park_app/model/Vaga.dart';
import 'package:euro_park_app/service/vagasService.dart';
import 'package:flutter/material.dart';

class ListarVagas extends StatefulWidget {
  const ListarVagas({Key? key});

  @override
  _ListarVagasState createState() => _ListarVagasState();
}

class _ListarVagasState extends State<ListarVagas> {
  final VagasService _vagasService = VagasService();
  List<Vaga> _vagas = [];

  @override
  void initState() {
    super.initState();
    _fetchVagas();
  }

  Future<void> _fetchVagas() async {
    try {
      final vagas = await _vagasService.fetchVagas();
      setState(() {
        _vagas = List<Vaga>.from(vagas);
      });
    } catch (e) {
      // Tratar erro de busca das vagas
      print('Erro ao buscar as vagas: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Vagas Disponíveis'),
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back),
          ),
        ),
        body: ListView.builder(
          padding: const EdgeInsets.all(10.0),
          itemCount: _vagas.length,
          itemBuilder: (context, index) {
            final Vaga vaga = _vagas[index];
            return _buildRow(context, vaga, index);
          },
        ),
      ),
    );
  }

  Widget _buildRow(BuildContext context, Vaga vaga, int index) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.car_crash_outlined),
            title: Text('Vaga: ${vaga.vaga}'),
            subtitle: Text('Valor: ${vaga.valor}'),
          ),
          ButtonBar(
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  // Implemente a lógica para reservar a vaga
                },
                child: Text('Reservar'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                ),
                onPressed: () {
                  _excluirVaga(context, index);
                },
                child: Text('Excluir'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _excluirVaga(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Excluir Vaga'),
          content: Text('Deseja excluir esta vaga?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Confirmar'),
              onPressed: () async {
                try {
                  final vaga = _vagas[index];
                  await _vagasService.deleteVaga(vaga.id!);
                  setState(() {
                    _vagas.removeAt(index);
                  });
                  Navigator.of(context).pop();
                } catch (e) {
                  // Tratar erro ao excluir a vaga
                  print('Erro ao excluir a vaga: $e');
                }
              },
            ),
          ],
        );
      },
    );
  }
}
