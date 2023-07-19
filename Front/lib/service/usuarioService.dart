import 'package:euro_park_app/model/usuario.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UsuarioService {
  final apiUrl = 'http://192.168.100.28:8080';

  Future<List<Usuario>> fetchUsuarios() async {
    final url = Uri.parse('$apiUrl/usuarios');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body) as List<dynamic>;
      return jsonData.map((data) => Usuario.fromMap(data)).toList();
    } else {
      throw Exception('Erro ao buscar os usuários');
    }
  }

  Future<void> createUsuario(Usuario usuario) async {
    final url = Uri.parse('$apiUrl/usuarios');
    final headers = {'Content-type': 'application/json'};
    final body = usuario.toJson();
    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 201) {
      // Usuário criado com sucesso
    } else {
      throw Exception('Erro ao criar o usuário');
    }
  }

  Future<void> updateUsuario(int id, Usuario updatedUsuario) async {
    final url = Uri.parse('$apiUrl/usuarios/$id');
    final headers = {'Content-type': 'application/json'};
    final body = updatedUsuario.toJson();
    final response = await http.put(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      // Usuário atualizado com sucesso
    } else {
      throw Exception('Erro ao atualizar o usuário');
    }
  }

  Future<void> deleteUsuario(int id) async {
    final url = Uri.parse('$apiUrl/usuarios/$id');
    final response = await http.delete(url);

    if (response.statusCode == 200) {
      // Usuário excluído com sucesso
    } else {
      throw Exception('Erro ao excluir o usuário');
    }
  }
}
