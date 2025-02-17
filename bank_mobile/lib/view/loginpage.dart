import 'package:bank_mobile/view/forgot.dart';
import 'package:bank_mobile/view/singup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  Future<void> signIn() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => isLoading = true);
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login exitoso')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Banex Digital'),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      ),
      body: Container(
        color: const Color.fromARGB(255, 4, 26, 58),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/logo.png'),
                const SizedBox(height: 24.0),
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: 'Correo Electrónico',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email, color: Colors.amber),
                    labelStyle: TextStyle(color: Colors.amber),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.amber),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.amber, width: 2.0),
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(color: Colors.amber),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ingrese su correo';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    labelText: 'Contraseña',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.lock, color: Colors.amber),
                    labelStyle: TextStyle(color: Colors.amber),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.amber),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.amber, width: 2.0),
                    ),
                  ),
                  obscureText: true,
                  style: TextStyle(color: Colors.amber),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ingrese su contraseña';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10.0),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => Get.to(() => const Forgot()),
                    child: const Text(
                      '¿Olvidaste tu contraseña?',
                      style: TextStyle(color: Colors.amber),
                    ),
                  ),
                ),
                const SizedBox(height: 10.0),
                ElevatedButton(
                  onPressed: isLoading ? null : signIn,
                  child: isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text('Iniciar Sesión'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                    foregroundColor: Colors.blue.shade900,
                    padding: const EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 24.0),
                  ),
                ),
                const SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      '¿No tienes cuenta?',
                      style: TextStyle(color: Colors.white),
                    ),
                    TextButton(
                      onPressed: () => Get.to(() => RegistroPage()),
                      child: const Text(
                        'Regístrate',
                        style: TextStyle(color: Colors.amber),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
