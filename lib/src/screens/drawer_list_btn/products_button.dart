import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ProductDetailsApp extends StatelessWidget {
  const ProductDetailsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyList(),
    );
  }
}

class MyList extends StatefulWidget {
  const MyList({super.key});

  @override
  State<MyList> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyList> {
  List<dynamic> productos = [];
  bool loading = true;
  late String error;

  @override
  void initState() {
    super.initState();
    // Inicializamos 'error' en initState o en cualquier otro lugar necesario.
    error = '';
    _cargarProductos();
  }

  Future<void> _cargarProductos() async {
    const apiUrl = 'https://www.xclusivedesigns.somee.com/api/Producto';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200 && mounted) {
        // Verificamos si el widget está montado antes de llamar a setState
        setState(() {
          productos = jsonDecode(response.body);
          loading = false;
        });
      } else {
        // Si el widget ya no está montado, no llamamos a setState
        if (mounted) {
          setState(() {
            error =
                'Error al obtener datos. Código de estado: ${response.statusCode}';
            loading = false;
          });
        }
      }
    } catch (e) {
      // Manejar errores de red u otros
      if (mounted) {
        setState(() {
          error = 'Error: $e';
          loading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Xclusive Designs'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.go('/home_drawer');
          },
        ),
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : error.isNotEmpty
              ? Center(child: Text(error))
              : ListView.builder(
                  itemCount: productos.length,
                  itemBuilder: (context, index) {
                    final producto = productos[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Material(
                        elevation: 8,
                        shadowColor: Colors.grey.withOpacity(0.5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Image.asset(
                                    'assets/playera-blanca.jpg',
                                    width: 60,
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          producto['nombreProd'],
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          '${producto['descripcion']}',
                                        ),
                                        const SizedBox(height: 8),
                                        ElevatedButton(
                                          onPressed: () {
                                            context.go(
                                                '/product_details/${producto['id']}'); // Enviamos el id del producto en la ruta
                                          },
                                          child: const Text('Ver más'),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}

