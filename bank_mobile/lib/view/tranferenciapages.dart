import 'package:bank_mobile/model/transaccion.dart';
import 'package:bank_mobile/view/addTranfer.dart';
import 'package:flutter/material.dart';

class TransferenciasPage extends StatefulWidget {
  const TransferenciasPage({super.key});

  @override
  _TransferenciasPageState createState() => _TransferenciasPageState();
}

class _TransferenciasPageState extends State<TransferenciasPage> {
  final List<TransactionItemModel> transferencias = [
    TransactionItemModel(
      id: '1',
      title: "Transferencia a Juan",
      description: "Pago de alquiler",
      amount: "-\$500.00",
      date: "12 Feb 2025",
      estado: "Completado",
    ),
    TransactionItemModel(
      id: '2',
      title: "Depósito recibido",
      description: "Pago de cliente",
      amount: "+\$1,200.00",
      date: "10 Feb 2025",
      estado: "Completado",
    ),
  ];

  void _agregarTransfer(TransactionItemModel nuevoTransfer) {
    setState(() {
      transferencias.add(nuevoTransfer);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Transferencias"),
        backgroundColor: Colors.amber,
      ),
      backgroundColor: const Color(0xFF041A3A),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView.builder(
          itemCount: transferencias.length,
          itemBuilder: (context, index) {
            final trans = transferencias[index];
            return Card(
              color: Colors.amber,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              margin: const EdgeInsets.only(bottom: 12),
              child: ListTile(
                title: Text(
                  trans.title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(trans.description),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      trans.amount,
                      style: TextStyle(
                        color: trans.amount.startsWith('-')
                            ? Colors.red
                            : Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      trans.estado,
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        child: const Icon(Icons.add, color: Colors.black),
        onPressed: () async {
          final nuevoPago = await Navigator.push<TransactionItemModel>(
            context,
            MaterialPageRoute(builder: (context) => const AddTransferPage()),
          );

          if (nuevoPago != null) {
            _agregarTransfer(nuevoPago);
          }
        },
      ),
    );
  }
}
