import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPage createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {

  // @override
  // void initState() {
  //   super.initState();
  //   login();
    
  // }

  // Future<bool> login(String username, String password) async {
  //   final response = await http.post(Uri.parse('http://www.xclusivedesigns.somee.com/api/Usuario');

  //   body: {
  //     'username': username,
  //     'password': password,
  //   });

  //   if (response.statusCode == 200) {
  //     final dynamic responseData = jsonDecode(response.body);
  //     if (responseData is Map) {
  //       final Map<String, dynamic> data = responseData;
  //       final String token = data['token'];
  //       // Guardar el token en el almacenamiento local
  //       return true;
  //     } else {
  //       throw Exception('Error: La respuesta no es un mapa');
  //       return false;
  //     }
  // }


  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Color customColor = const Color(0xFFFFD951);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/home'),
        ),
      ),
      body: Stack(
        children: [
          Positioned(
            bottom: 0,
            child: ClipPath(
              clipper: WaveClipperTwo(flip: false, reverse: true),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 180,
                color: customColor,
                alignment: Alignment.bottomCenter,
              ),
            ),
          ),
          ListView(
            children: [
              const SizedBox(height: 50),
              const Text(
                'Iniciar Sesión',
                style: TextStyle(fontSize: 28),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 9),
              Center(
                child: Image.asset(
                  'assets/logo-negro.png',
                  width: 100,
                  height: 100,
                ),
              ),
              const SizedBox(height: 9),
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                padding:
                    const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        controller: _usernameController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.email_outlined),
                          labelText: "Email o usuario",
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, ingrese su email';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.lock_outline),
                          labelText: "Contraseña",
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, ingrese su contraseña';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: customColor,
                        ),
                        onPressed: () {
                          if (_usernameController.text == 'admin' &&
                              _passwordController.text == '123') {
                            context.go('/home_btm_nav_bar');
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content:
                                    Text('Usuario o contraseña incorrectos.'),
                              ),
                            );
                          }
                        },
                        child: const Text(
                          'Ingresar',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  bool _validateForm() {
    return true; // Implementar lógica de validación adicional si es necesario
  }
}
