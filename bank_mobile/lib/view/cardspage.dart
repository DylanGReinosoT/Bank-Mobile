import 'package:bank_mobile/model/card.dart';
import 'package:bank_mobile/view/addcards.dart';
import 'package:flutter/material.dart';

class Cardspage extends StatefulWidget {
  const Cardspage({super.key});

  @override
  State<Cardspage> createState() => _CardspageState();
}

class _CardspageState extends State<Cardspage> {
  List<CardsModel> cards = [
    CardsModel(
      numeroTarjeta: '**** **** **** 1234',
      dateVencimiento: DateTime(2027, 5, 1),
      codigo: '123',
      tipoTarjeta: 'Visa',
      saldo: 2500.75,
      titular: 'Juan Pérez',
      dateCreacion: DateTime(2023, 8, 15),
    ),
  ];

  void _addNewCard(CardsModel newCard) {
    setState(() {
      cards.add(newCard);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis Tarjetas'),
        backgroundColor: Colors.amber,
      ),
      backgroundColor: const Color(0xFF041A3A),
      body: cards.isEmpty
          ? const Center(
              child: Text(
                'No tienes tarjetas agregadas',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: cards.length,
              itemBuilder: (context, index) {
                final card = cards[index];
                return Card(
                  color: Colors.amber,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  margin: const EdgeInsets.only(bottom: 16),
                  child: ListTile(
                    leading: Icon(
                      card.tipoTarjeta == 'Visa'
                          ? Icons.credit_card
                          : Icons.payment,
                      color: Colors.blue.shade900,
                    ),
                    title: Text(
                      card.numeroTarjeta,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      'Vence: ${card.formattedVencimiento}\nSaldo: \$${card.saldo.toStringAsFixed(2)}',
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        onPressed: () async {
          final newCard = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddCardPage()),
          );
          if (newCard != null) {
            _addNewCard(newCard);
          }
        },
        child: const Icon(Icons.add, color: Colors.black),
      ),
    );
  }
}
