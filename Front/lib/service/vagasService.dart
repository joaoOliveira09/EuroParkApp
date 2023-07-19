
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../model/Vaga.dart';

class VagasService {
  final apiUrl = 'http://192.168.100.28:8080';

  Future<List> fetchVagas() async {
    final url = Uri.parse('$apiUrl/vagas');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body) as List<dynamic>;
      return jsonData.map((data) => Vaga.fromJson(data)).toList();
    } else {
      throw Exception('Erro ao buscar as vagas');
    }
  }

  Future<void> createVaga(Vaga vaga) async {
    final url = Uri.parse('$apiUrl/vagas');
    final headers = {'Content-type': 'application/json'};
    final body = jsonEncode(vaga.toJson());
    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 201) {
      // Vaga criada com sucesso
    } else {
      throw Exception('Erro ao criar a vaga');
    }
  }

  Future<void> updateVaga(int id, Vaga updatedVaga) async {
    final url = Uri.parse('$apiUrl/vagas/$id');
    final headers = {'Content-type': 'application/json'};
    final body = jsonEncode(updatedVaga.toJson());
    final response = await http.put(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      // Vaga atualizada com sucesso
    } else {
      throw Exception('Erro ao atualizar a vaga');
    }
  }

  Future<void> deleteVaga(int id) async {
    final url = Uri.parse('$apiUrl/vagas/$id');
    final response = await http.delete(url);

    if (response.statusCode == 200) {
      // Vaga excluída com sucesso
    } else {
      throw Exception('Erro ao excluir a vaga');
    }
  }
}
