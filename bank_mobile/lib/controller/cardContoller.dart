import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:bank_mobile/model/card.dart';

class CardsController {
  final String baseUrl = "http://192.168.1.31:8080/api/cards";

  /// 🔹 **Obtener todas las tarjetas**
  Future<List<CardsModel>> getAllCards() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => CardsModel.fromJson(json)).toList();
      } else {
        throw Exception("Error al obtener tarjetas: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error de conexión: $e");
    }
  }

  /// 🔹 **Obtener una tarjeta por ID**
  Future<CardsModel?> getCardById(int id) async {
    try {
      final response = await http.get(Uri.parse("$baseUrl/$id"));

      if (response.statusCode == 200) {
        return CardsModel.fromJson(jsonDecode(response.body));
      } else if (response.statusCode == 404) {
        return null; // No encontrada
      } else {
        throw Exception("Error al obtener tarjeta: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error de conexión: $e");
    }
  }

  /// 🔹 **Crear una nueva tarjeta**
Future<Map<String, dynamic>> createCard(CardsModel card) async {
  try {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(card.toJson()),
    );

    if (response.statusCode == 201) {
      final responseData = jsonDecode(response.body);
      return {
        "success": true,
        "id": responseData['id']
      }; // Devuelve un mapa con éxito e ID
    } else {
      throw Exception("Error al crear tarjeta: ${response.statusCode}");
    }
  } catch (e) {
    throw Exception("Error de conexión: $e");
  }
}
  Future<List<CardsModel>> fetchCards(String userId) async {
    final response = await http.get(Uri.parse('http://192.168.1.31:8080/api/users/$userId/cards'));
    
    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((card) => CardsModel.fromJson(card)).toList();
    } else {
      throw Exception('Error al obtener las tarjetas');
    }
  }

   Future<bool> asignar(String userId,String idCard) async {
    final response = await http.post(
      Uri.parse('http://192.168.1.31:8080/api/users/$userId/cards/$idCard'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({})
      );

    if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
    } else {
      throw Exception('Error al obtener las tarjetas');
    }
  }

}
