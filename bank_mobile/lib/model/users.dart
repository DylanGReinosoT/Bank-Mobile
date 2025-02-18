class AppUser {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String phoneNumber;
  final String address;
  final String accountStatus;
  final String ui;

  AppUser({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.phoneNumber,
    required this.address,
    required this.accountStatus,
    required this.ui,
  });
  

  // Convertir AppUser a JSON
  Map<String, dynamic> toJson() {
    return {
      "id":id,
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "password": password,
      "phoneNumber": phoneNumber,
      "address": address,
      "accountStatus": accountStatus,
      "ui": ui,
    };
  }

  // Crear un AppUser desde JSON
  factory AppUser.fromJson(Map<String, dynamic> json) {
    return AppUser(
      id:json["id"].toString(),
      firstName: json["firstName"],
      lastName: json["lastName"],
      email: json["email"],
      password: json["password"],
      phoneNumber: json["phoneNumber"],
      address: json["address"],
      accountStatus: json["accountStatus"],
      ui: json["ui"],
    );
  }
}
