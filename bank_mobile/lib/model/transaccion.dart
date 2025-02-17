class TransactionItemModel {
  final String id;
  final String title;
  final String description;
  final String amount;
  final String date;
  final String estado;

  TransactionItemModel({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
    required this.description,
    required this.estado,
  });
}
