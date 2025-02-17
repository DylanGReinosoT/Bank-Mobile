class Pagos {
  final double monto;
  final DateTime fechaPago;
  final String descripcion;
  final String estado;

  Pagos(
      {required this.monto,
      required this.fechaPago,
      required this.descripcion,
      required this.estado});
}
