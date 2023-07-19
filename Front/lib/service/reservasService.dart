import 'package:euro_park_app/model/Reservas.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ReservasService {
  final apiUrl = 'http://192.168.100.28:8080';

  Future<List<Reservas>> fetchReservas() async {
    final url = Uri.parse('$apiUrl/reservas');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body) as List<dynamic>;
      return jsonData.map((data) => Reservas.fromMap(data)).toList();
    } else {
      throw Exception('Erro ao buscar as reservas');
    }
  }

  Future<void> createReserva(Reservas reserva) async {
    final url = Uri.parse('$apiUrl/reservas');
    final headers = {'Content-type': 'application/json'};
    final body = reserva.toJson();
    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 201) {
      // Reserva criada com sucesso
    } else {
      throw Exception('Erro ao criar a reserva');
    }
  }

  Future<void> updateReserva(int id, Reservas updatedReserva) async {
    final url = Uri.parse('$apiUrl/reservas/$id');
    final headers = {'Content-type': 'application/json'};
    final body = updatedReserva.toJson();
    final response = await http.put(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      // Reserva atualizada com sucesso
    } else {
      throw Exception('Erro ao atualizar a reserva');
    }
  }

  Future<void> deleteReserva(int id) async {
    final url = Uri.parse('$apiUrl/reservas/$id');
    final response = await http.delete(url);

    if (response.statusCode == 200) {
      // Reserva excluída com sucesso
    } else {
      throw Exception('Erro ao excluir a reserva');
    }
  }
}
