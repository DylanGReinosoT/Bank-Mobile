import 'package:bank_mobile/view/wapper.dart';
import 'package:bank_mobile/controller/usercontroller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bank_mobile/model/users.dart';


class RegistroPage extends StatefulWidget {
  @override
  _RegistroPageState createState() => _RegistroPageState();
}

class _RegistroPageState extends State<RegistroPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _apellidoController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _telefonoController = TextEditingController();
  final TextEditingController _direccionController = TextEditingController();
  final TextEditingController _estadoController = TextEditingController();
  final UserApiService _userApiService = UserApiService();

  bool _isLoading = false;


Future<void> _registrarUsuario() async {
  if (!_formKey.currentState!.validate()) return;

  setState(() {
    _isLoading = true;
  });

  try {
    // Crear usuario en Firebase Auth
    UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
    );

    User? firebaseUser = userCredential.user;
    if (firebaseUser == null) {
      throw FirebaseAuthException(code: "USER_NULL", message: "No se pudo obtener el usuario.");
    }

    // Crear usuario usando el modelo AppUser
    AppUser newUser = AppUser(
      id:"",
      firstName: _nombreController.text.trim(),
      lastName: _apellidoController.text.trim(),
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
      phoneNumber: _telefonoController.text.trim(),
      address: _direccionController.text.trim(),
      accountStatus: "ACTIVE",
      ui: firebaseUser.uid,
    );

    // Enviar usuario a la API
    AppUser? apiUser = await _userApiService.createUser(newUser);

    if (apiUser != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registro exitoso')),
      );
      Get.offAll(() => const Wapper());
    } else {
      throw Exception("No se pudo registrar en la API");
    }
  } on FirebaseAuthException catch (e) {
    String errorMessage = _getFirebaseAuthErrorMessage(e.code);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(errorMessage)),
    );
  } catch (e) {
    print("❌ Error en _registrarUsuario: $e");
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Error inesperado, intenta nuevamente.')),
    );
  } finally {
    setState(() {
      _isLoading = false;
    });
  }
}


/// 🔍 Método para traducir errores de Firebase a mensajes más claros
String _getFirebaseAuthErrorMessage(String code) {
  switch (code) {
    case 'email-already-in-use':
      return "El correo ya está en uso.";
    case 'invalid-email':
      return "Correo electrónico inválido.";
    case 'weak-password':
      return "La contraseña es demasiado débil.";
    default:
      return "Error desconocido. Inténtalo nuevamente.";
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade900,
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            color: Colors.white,
            elevation: 8,
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Registro',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue.shade900,
                        ),
                      ),
                      SizedBox(height: 20),

                      // Nombre
                      TextFormField(
                        controller: _nombreController,
                        decoration: InputDecoration(
                          labelText: 'Nombre',
                          prefixIcon:
                              Icon(Icons.person, color: Colors.blue.shade900),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Ingrese su nombre';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 15),

                      // Apellido
                      TextFormField(
                        controller: _apellidoController,
                        decoration: InputDecoration(
                          labelText: 'Apellido',
                          prefixIcon: Icon(Icons.person_outline,
                              color: Colors.blue.shade900),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Ingrese su apellido';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 15),

                      // Correo Electrónico
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: 'Correo Electrónico',
                          prefixIcon:
                              Icon(Icons.email, color: Colors.blue.shade900),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Ingrese su correo electrónico';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 15),

                      // Teléfono
                      TextFormField(
                        controller: _telefonoController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          labelText: 'Teléfono',
                          prefixIcon:
                              Icon(Icons.phone, color: Colors.blue.shade900),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                      SizedBox(height: 15),

                      // Dirección
                      TextFormField(
                        controller: _direccionController,
                        decoration: InputDecoration(
                          labelText: 'Dirección',
                          prefixIcon:
                              Icon(Icons.home, color: Colors.blue.shade900),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                      SizedBox(height: 15),

                      // Estado
                      TextFormField(
                        controller: _estadoController,
                        decoration: InputDecoration(
                          labelText: 'Estado',
                          prefixIcon: Icon(Icons.location_city,
                              color: Colors.blue.shade900),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                      SizedBox(height: 15),

                      // Contraseña
                      TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Contraseña',
                          prefixIcon:
                              Icon(Icons.lock, color: Colors.blue.shade900),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        validator: (value) {
                          if (value == null || value.length < 6) {
                            return 'La contraseña debe tener al menos 6 caracteres';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 15),

                      // Confirmar Contraseña
                      TextFormField(
                        controller: _confirmPasswordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Confirmar Contraseña',
                          prefixIcon: Icon(Icons.lock_outline,
                              color: Colors.blue.shade900),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        validator: (value) {
                          if (value != _passwordController.text) {
                            return 'Las contraseñas no coinciden';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),

                      ElevatedButton(
                        onPressed: _isLoading ? null : _registrarUsuario,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.amber,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          padding: EdgeInsets.symmetric(
                              vertical: 12, horizontal: 50),
                        ),
                        child: _isLoading
                            ? CircularProgressIndicator(color: Colors.white)
                            : Text('Registrarse',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.blue.shade900)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
