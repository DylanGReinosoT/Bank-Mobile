import 'package:bank_mobile/model/card.dart';
import 'package:bank_mobile/view/addcards.dart';
import 'package:bank_mobile/controller/cardContoller.dart';
import 'package:flutter/material.dart';

class Cardspage extends StatefulWidget {
  final String? id;
  const Cardspage({super.key, this.id});

  @override
  State<Cardspage> createState() => _CardspageState();
}

class _CardspageState extends State<Cardspage> {
  final CardsController _cardController = CardsController();
  late Future<List<CardsModel>> _cardsFuture;

  @override
  void initState() {
    super.initState();
    _cardsFuture = _cardController.fetchCards(widget.id ?? "");
  }

  void _addNewCard(CardsModel newCard) {
    setState(() {
      _cardsFuture = _cardController.fetchCards(widget.id ?? "");
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
      body: FutureBuilder<List<CardsModel>>(
        future: _cardsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error al cargar las tarjetas', style: TextStyle(color: Colors.white)));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                'No tienes tarjetas agregadas',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            );
          }

          List<CardsModel> cards = snapshot.data!;
          return ListView.builder(
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
                    card.cardType == 'Visa' ? Icons.credit_card : Icons.payment,
                    color: Colors.blue.shade900,
                  ),
                  title: Text(
                    card.cardNumber,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    'Vence: ${card.expirationDate}\nSaldo: \$${card.balance.toStringAsFixed(2)}',
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        onPressed: () async {
          final newCard = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddCardPage(idUser: widget.id ?? "")),
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
