import 'package:intl/intl.dart';

class CardsModel {
  final String numeroTarjeta;
  final DateTime dateVencimiento;
  final String codigo;
  final String tipoTarjeta;
  final double saldo;
  final String titular;
  final DateTime dateCreacion;

  CardsModel({
    required this.numeroTarjeta,
    required this.dateVencimiento,
    required this.codigo,
    required this.tipoTarjeta,
    required this.saldo,
    required this.titular,
    required this.dateCreacion,
  });

  /// 🔹 **Método para formatear fecha de vencimiento**
  String get formattedVencimiento =>
      DateFormat('MM/yy').format(dateVencimiento);

  /// 🔹 **Método para formatear fecha de creación**
  String get formattedCreacion =>
      DateFormat('dd MMM yyyy').format(dateCreacion);

  /// 🔹 **Convertir a JSON (útil para Firebase o APIs)**
  Map<String, dynamic> toJson() {
    return {
      'numeroTarjeta': numeroTarjeta,
      'dateVencimiento': dateVencimiento.toIso8601String(),
      'codigo': codigo,
      'tipoTarjeta': tipoTarjeta,
      'saldo': saldo,
      'titular': titular,
      'dateCreacion': dateCreacion.toIso8601String(),
    };
  }

  /// 🔹 **Crear un objeto desde JSON**
  factory CardsModel.fromJson(Map<String, dynamic> json) {
    return CardsModel(
      numeroTarjeta: json['numeroTarjeta'],
      dateVencimiento: DateTime.parse(json['dateVencimiento']),
      codigo: json['codigo'],
      tipoTarjeta: json['tipoTarjeta'],
      saldo: json['saldo'].toDouble(),
      titular: json['titular'],
      dateCreacion: DateTime.parse(json['dateCreacion']),
    );
  }
}
