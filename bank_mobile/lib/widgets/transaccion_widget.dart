import 'package:bank_mobile/model/transaccion.dart';
import 'package:flutter/material.dart';

class TransactionItemWidget extends StatelessWidget {
  final TransactionItemModel transaction;

  const TransactionItemWidget({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        title: Text(
          transaction.title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(transaction.date),
        trailing: Text(
          transaction.amount,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color:
                transaction.amount.startsWith('-') ? Colors.red : Colors.green,
          ),
        ),
      ),
    );
  }
}
