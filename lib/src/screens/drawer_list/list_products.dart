import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:xclusivedesigns/src/screens/add_products.dart';

class ListProductsApp extends StatefulWidget {
  const ListProductsApp({super.key});

  @override
  State<ListProductsApp> createState() => _ListProductsAppState();
}

class _ListProductsAppState extends State<ListProductsApp> {
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
    const apiUrl = 'http://www.xclusivedesigns.somee.com/api/Producto';

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
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : error.isNotEmpty
              ? Center(child: Text(error))
              : ListView.builder(
                  itemCount: productos.length,
                  itemBuilder: (context, index) {
                    final producto = productos[index];
                    return Padding(
                      padding: const EdgeInsets.all(12.0),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Column(
                            children: [
                              Row(
                                children:[
                                  const SizedBox(width: 15, height: 30),
                                  Text(
                                    '#00${producto['idProducto']}',
                                    style: const TextStyle(
                                      fontFamily: 'Arial',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Color.fromRGBO(245, 31, 31, 0.952),
                                    ),
                                  ),
                                ]
                              ),
                              
                              Row(
                                children: [
                                  Expanded(
                                    child: producto['images'].isNotEmpty 
                                      ? Image.network(
                                          '${producto['images'][0]['urlImagenProducto']}',
                                          width: 90,
                                          height: 150,
                                        )
                                      : Container(),  // Widget vacío
                                  ),

                                  Expanded(
                                    flex: 2,
                                    child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                    child: Column(
                                      children: [
                                        Column(
                                          children: [
                                            Text(
                                              '${producto['nombreProd']}',
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                            

                                            Text(
                                              '${producto['precioUnitario']}0 MXN',
                                              style: const TextStyle(
                                                fontFamily: 'Arial',
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Color.fromRGBO(236, 0, 0, 100),
                                              ),
                                            ),
                                            const SizedBox(height: 8.0),

                                            Container(
                                              width: 100,
                                              decoration: const BoxDecoration(
                                                color: Color.fromARGB(255, 143, 141, 141),
                                                shape: BoxShape.circle,
                                              ),
                                              child: Column(
                                                children: [
                                                  Text(
                                                    '${producto['stock']}',
                                                    style: const TextStyle(
                                                      fontFamily: 'Arial',
                                                      color: Color.fromARGB(255, 0, 0, 0),
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 25,
                                                    ),
                                                  )
                                                ],
                                              )
                                            ),
                                          ],
                                        ),
                                      ]
                                    ),
                                    )
                                  ),
                                ],
                              ),
                            ],
                          ),
                      ),
                    );
                  },
                ),

                // floatingActionButton: FloatingActionButton(
                //   onPressed: () {
                //     showModalBottomSheet(
                //       context: context,
                //       builder: (BuildContext context) {
                //         return const AddProductsApp();
                //       },
                //     );
                //   },
                //   child: Icon(Icons.add),
                //    backgroundColor: Color.fromRGBO(255, 217, 81, 1),
                // ),

                floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    Navigator.push(
                      context, 
                      MaterialPageRoute(builder: (context) => AddProductsPage())
                    );
                  },
                  child: Icon(Icons.add),
                   backgroundColor: Color.fromRGBO(255, 217, 81, 1),
                ),
    );
  }
}



