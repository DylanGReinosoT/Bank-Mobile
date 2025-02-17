class User {
  final String nombre;
  final String apellido;
  final String email;
  final String password;
  final String telefono;
  final String direccion;
  final String estado;

  User(
      {required this.nombre,
      required this.apellido,
      required this.email,
      required this.password,
      required this.telefono,
      required this.direccion,
      required this.estado});
}
