import 'package:intl/intl.dart';

class CardsModel {
  final String cardNumber;
  final String expirationDate; // Se mantiene como String porque la API lo envía en "MM/yy"
  final String securityCode;
  final String cardType;
  final double balance;
  final String cardHolderName;

  CardsModel({
    required this.cardNumber,
    required this.expirationDate,
    required this.securityCode,
    required this.cardType,
    required this.balance,
    required this.cardHolderName,
  });

  /// 🔹 **Obtener fecha de vencimiento como `DateTime`**
  DateTime get expirationDateAsDateTime {
    try {
      final parts = expirationDate.split('/');
      final int month = int.parse(parts[0]);
      final int year = int.parse(parts[1]) + 2000; // Convierte "25" en "2025"
      return DateTime(year, month, 1);
    } catch (e) {
      return DateTime.now(); // En caso de error, devuelve la fecha actual
    }
  }

  /// 🔹 **Obtener fecha de vencimiento en formato legible**
  String get formattedExpirationDate {
    DateTime date = expirationDateAsDateTime;
    return DateFormat('MM/yy').format(date);
  }

  /// 🔹 **Convertir a JSON (para enviar a la API)**
  Map<String, dynamic> toJson() {
    return {
      'cardNumber': cardNumber,
      'expirationDate': expirationDate, // Se mantiene como String
      'securityCode': securityCode,
      'cardType': cardType,
      'balance': balance,
      'cardHolderName': cardHolderName,
    };
  }

  /// 🔹 **Crear un objeto desde JSON**
  factory CardsModel.fromJson(Map<String, dynamic> json) {
    return CardsModel(
      cardNumber: json['cardNumber'],
      expirationDate: json['expirationDate'], // Ya viene en "MM/yy"
      securityCode: json['securityCode'],
      cardType: json['cardType'],
      balance: (json['balance'] as num).toDouble(), // Asegura que sea double
      cardHolderName: json['cardHolderName'],
    );
  }
}
