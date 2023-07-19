import 'package:euro_park_app/model/Vaga.dart';
import 'package:euro_park_app/service/VagasService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';

import 'dashboard.dart';

class Vagas extends StatefulWidget {
  @override
  _VagasState createState() => _VagasState();
}

class _VagasState extends State<Vagas> {
  final TextEditingController vagaController = TextEditingController();
  final TextEditingController valorController = TextEditingController();
  Position? currentLocation;
  final VagasService _vagasService = VagasService();

  @override
  void initState() {
    super.initState();
    _getLocation();
    print("foi");
    print(currentLocation);
  }

  Future<void> _getLocation() async {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission != LocationPermission.denied) {
      Position position = await Geolocator.getCurrentPosition();
      setState(() {
        currentLocation = position;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Vagas",
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Vagas"),
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back),
          ),
        ),
        body: Column(
          children: <Widget>[
            if (currentLocation != null)
              Container(
                height: 300,
                child: FlutterMap(
                  options: MapOptions(
                    center: LatLng(
                      currentLocation!.latitude,
                      currentLocation!.longitude,
                    ),
                    zoom: 13.0,
                  ),
                  layers: [
                    TileLayerOptions(
                      urlTemplate:
                      "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                      subdomains: ['a', 'b', 'c'],
                    ),
                    MarkerLayerOptions(
                      markers: [
                        Marker(
                          width: 80.0,
                          height: 80.0,
                          point: LatLng(
                            currentLocation!.latitude,
                            currentLocation!.longitude,
                          ),
                          builder: (ctx) => Container(
                            child: Icon(
                              Icons.location_on,
                              color: Colors.red,
                              size: 50.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            Expanded(
              child: SingleChildScrollView(
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 20.0),
                      Container(
                        padding: const EdgeInsets.all(20),
                        child: Text(
                          'Informe os dados da vaga:',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(20),
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
                        padding: const EdgeInsets.all(20),
                        child: TextField(
                          controller: valorController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(80.0),
                            ),
                            labelText: 'Valor',
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
                          child: const Text("Cadastrar"),
                          onPressed: () async {
                            int vaga = int.parse(vagaController.text);
                            double valor = double.parse(valorController.text);

                            Vaga v = Vaga(
                              vaga: vaga,
                              valor: valor,
                            );

                            try {
                              await _vagasService.createVaga(v);

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return Dashboard();
                                  },
                                ),
                              );
                            } catch (e) {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Erro ao cadastrar vaga'),
                                    content: const Text('Ocorreu um erro ao cadastrar a vaga.'),
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
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
