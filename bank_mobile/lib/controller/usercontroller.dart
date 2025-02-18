import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:bank_mobile/model/users.dart';

class UserApiService {
  final String baseUrl = "http://192.168.1.31:8080/api/users";

  Future<AppUser?> createUser(AppUser user) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {"Content-Type": "application/json"},
        body: json.encode(user.toJson()), // Convertimos AppUser a JSON
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return AppUser.fromJson(json.decode(response.body)); // Retornamos el usuario creado
      } else {
        print("Error al crear usuario: ${response.body}");
        return null;
      }
    } catch (e) {
      print("Error en createUser: $e");
      return null;
    }
  }

  Future<AppUser?> getUserByUi(String ui) async {
  try {
    final response = await http.get(Uri.parse("$baseUrl/byUi/$ui"));

    if (response.statusCode == 200) {
      return AppUser.fromJson(json.decode(response.body));
    } else {
      print("Error al obtener usuario por UI: ${response.body}");
      return null;
    }
  } catch (e) {
    print("Error en getUserByUi: $e");
    return null;
  }
}

}
