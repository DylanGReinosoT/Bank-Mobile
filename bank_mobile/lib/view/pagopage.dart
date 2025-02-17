import 'package:bank_mobile/model/payment.dart';
import 'package:bank_mobile/view/addpagos.dart';
import 'package:flutter/material.dart';

class PagosPage extends StatefulWidget {
  const PagosPage({super.key});

  @override
  State<PagosPage> createState() => _PagosPageState();
}

class _PagosPageState extends State<PagosPage> {
  final List<Pagos> _pagos = [
    Pagos(
        monto: 120.50,
        fechaPago: DateTime(2025, 2, 5),
        descripcion: 'Pago de Internet',
        estado: 'Completado'),
    Pagos(
        monto: 75.00,
        fechaPago: DateTime(2025, 2, 3),
        descripcion: 'Pago de Agua',
        estado: 'Pendiente'),
    Pagos(
        monto: 250.00,
        fechaPago: DateTime(2025, 1, 28),
        descripcion: 'Pago de Luz',
        estado: 'Completado'),
  ];

  void _agregarPago(Pagos nuevoPago) {
    setState(() {
      _pagos.add(nuevoPago);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF041A3A),
      appBar: AppBar(
        title: const Text('Pagos'),
        backgroundColor: Colors.amber,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Historial de Pagos',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.amber),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: _pagos.isEmpty
                  ? const Center(
                      child: Text('No hay pagos registrados',
                          style: TextStyle(color: Colors.white)))
                  : ListView.builder(
                      itemCount: _pagos.length,
                      itemBuilder: (context, index) {
                        final pago = _pagos[index];
                        return Card(
                          color: Colors.white.withOpacity(0.1),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: ListTile(
                            title: Text(
                              pago.descripcion,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              '${pago.fechaPago.day}/${pago.fechaPago.month}/${pago.fechaPago.year} - ${pago.estado}',
                              style: TextStyle(
                                  color: pago.estado == 'Completado'
                                      ? Colors.green
                                      : Colors.red),
                            ),
                            trailing: Text(
                              '\$${pago.monto.toStringAsFixed(2)}',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        child: const Icon(Icons.add, color: Colors.black),
        onPressed: () async {
          final nuevoPago = await Navigator.push<Pagos>(
            context,
            MaterialPageRoute(builder: (context) => const AddPagoPage()),
          );

          if (nuevoPago != null) {
            _agregarPago(nuevoPago);
          }
        },
      ),
    );
  }
}
