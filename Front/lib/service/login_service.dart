import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


import '../dao/login_dao.dart';
import '../model/login.dart';
import '../telas/android/dashboard.dart';


class LoginService {
  final apiUrl = 'http://192.168.100.28:8080';
  //http://10.0.2.2:8080

  Future<void> login(Login login, context) async {
    final url = Uri.parse('$apiUrl/login');
    final headers = {'Content-type': 'application/json'};
    final body = jsonEncode(login.toMap());
    final response = await http.post(url, headers: headers, body: body);
    final jsonData = json.decode(response.body);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      LoginDao().login(Login.fromJsonToken(jsonData));
      //Toasts().showSuccess('Logado!', context);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) {
          return Dashboard();
        }),
      );
      return;
    } else {
      //Toasts().showError(jsonData['message'], context);


      // ScaffoldMessenger.of(context).showMaterialBanner(MaterialBanner(
      //   content: Text(jsonData['message']),
      //   backgroundColor: AppColors.errorDark,
      //   actions: [
      //     ElevatedButton(
      //       child: Text('Text'),
      //       onPressed: () {
      //         ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
      //       },
      //     )
      //   ],
      // ));
    }
  }

  Future<http.Response> login2(Login login) async {
    final url = Uri.parse('$apiUrl/login');
    final headers = {'Content-type': 'application/json'};
    final body = jsonEncode(login.toMap());
    final response = await http.post(url, headers: headers, body: body);

    return response;
  }
}
