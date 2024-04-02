import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ListOrdersApp extends StatelessWidget {
  const ListOrdersApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyList(),
    );
  }
}

class MyList extends StatefulWidget {
  const MyList({Key? key}) : super(key: key);

  @override
  State<MyList> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyList> {
  List<dynamic> cotizaciones = [];
  bool loading = true;
  late String error;

  @override
  void initState() {
    super.initState();
    // Inicializamos 'error' en initState o en cualquier otro lugar necesario.
    error = '';
    super.initState();
    _cargarProducto();
  }

  Future<void> _cargarProducto() async {
    const apiUrl =
        'http://www.xclusivedesigns.somee.com/api/Pedido'; // Cambia el número 1 por el ID del producto que deseas obtener

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200 && mounted) {
        final dynamic responseData = jsonDecode(response.body);
        if (responseData is List) {
          setState(() {
            cotizaciones = responseData;
            loading = false;
          });
        } else {
          setState(() {
            error = 'Error: La respuesta no es una lista de cotizaciones';
            loading = false;
          });
        }
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
        // leading: IconButton(
        //   icon: const Icon(Icons.arrow_back),
        //   onPressed: () {
        //     context.go('/home_drawer');
        //   },
        // ),
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : error.isNotEmpty
              ? Center(child: Text(error))
              : ListView.builder(
                  itemCount: cotizaciones.length,
                  itemBuilder: (context, index) {
                    final pedido = cotizaciones[index];
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
                            border: Border.all(color: Color.fromARGB(255, 0, 0, 0)),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    // Espacio entre los dos textos
                                    const Text(
                                      'Otro texto aquí', // Coloca el otro texto aquí
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      '#${pedido['idPedido']}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Image.asset(
                                        'assets/minnie-bday.jpeg',
                                        width: 60,
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  'ID: ${pedido['idCliente']}',
                                                ),
                                                const Text('Cliente: '),
                                                Text(
                                                  '${pedido['idClienteNavigation']['nombre']}'
                                                  ' '
                                                  '${pedido['idClienteNavigation']['apellido']}',
                                                ),
                                                const SizedBox(height: 8),
                                              ],
                                            ),
                                            // Text(
                                            //   '${pedido['detalleCotizacion'][0]['fechaCotizacion']}',
                                            // ),
                                            const SizedBox(height: 8),
                                            ElevatedButton(
                                              onPressed: () {
                                                // Acción cuando se presiona el botón "Ver más"
                                              },
                                              child: const Text('Ver más'),
                                            ),
                                          ],
                                        ),
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
                  },
                ),
    );
  }
}
