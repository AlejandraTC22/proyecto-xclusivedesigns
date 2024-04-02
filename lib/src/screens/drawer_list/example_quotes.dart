import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:xclusivedesigns/src/screens/drawer_navigator/navigator_quotes.dart';

class ListQuotesApp extends StatelessWidget {
  const ListQuotesApp({Key? key}) : super(key: key);

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
  List<dynamic> cotizacionesFiltradas = [];
  bool loading = true;
  late String error;
  final TextEditingController _searchController = TextEditingController();

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
        'http://www.xclusivedesigns.somee.com/api/Cotizacion'; // Cambia el número 1 por el ID del producto que deseas obtener

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200 && mounted) {
        final dynamic responseData = jsonDecode(response.body);
        if (responseData is List) {
          setState(() {
            cotizaciones = responseData;
            cotizacionesFiltradas = responseData;
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

  void _filtrarCotizaciones(String searchTerm) {
    setState(() {
      cotizacionesFiltradas = cotizaciones.where((cotizacion) {
        final nombreCompleto =
            '${cotizacion['idClienteNavigation']['nombre']} ${cotizacion['idClienteNavigation']['apellido']}';
        return nombreCompleto.toLowerCase().contains(searchTerm.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
      Padding(
          padding: const EdgeInsets.all(10.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.93,
            child: TextField(
              controller: _searchController,
              onChanged: _filtrarCotizaciones,
              decoration: InputDecoration(
                hintText: 'Buscar cliente',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear_sharp),
                  onPressed: () {
                    _searchController.clear();
                    _filtrarCotizaciones('');
                  },
                ),
                enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 52, 69, 216),
                    width: 2,
                  ),
                  
                

                ),
                contentPadding: const EdgeInsets.all(12),
              ),
            ),
          )),

      const SizedBox(height: 10),
      
      Expanded(
        child: loading
            ? const Center(child: CircularProgressIndicator())
            : error.isNotEmpty
                ? Center(child: Text(error))
                : ListView.builder(
                    itemCount: cotizacionesFiltradas.length,
                    itemBuilder: (context, index) {
                      final cotizacion = cotizacionesFiltradas[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Material(
                          
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => QuoteNavigatorApp(cotizacion: cotizacion,)),
                              );
                            },
                            child: Container(
                              margin: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    const CircleAvatar(
                                      radius: 35,
                                      backgroundImage: AssetImage(
                                          'assets/cliente_image.jpg'),
                                    ),

                                    const SizedBox(width: 8),

                                    Row(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(
                                              8.0), // Ajusta el padding según tus preferencias
                                          decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.black),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                '${cotizacion['idClienteNavigation']['nombre']} ${cotizacion['idClienteNavigation']['apellido']}',
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 17,
                                                ),
                                              ),
                                              const SizedBox(
                                                  height:
                                                      8), // Espacio entre los textos
                                              Text(
                                                cotizacion['detalleCotizacion'].isNotEmpty?
                                                '${DateTime.parse(cotizacion['detalleCotizacion'][0]['fechaCotizacion']).day}/'
                                                '${DateTime.parse(cotizacion['detalleCotizacion'][0]['fechaCotizacion']).month}/'
                                                '${DateTime.parse(cotizacion['detalleCotizacion'][0]['fechaCotizacion']).year}'
                                                : 'No hay fecha de cotización',
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.all(15), // Ajusta el padding según tus preferencias
                                          child: Column( 
                                            children: [
                                              const SizedBox(height: 8),
                                              Text(
                                                '#00${cotizacion['idCotizacion']}',
                                                style: const TextStyle(
                                                  fontFamily: 'abyssinica_sil',
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18,
                                                  color: Color.fromRGBO(236, 0, 0, 100),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        // Container(
                                        //   padding: const EdgeInsets.all(15), // Ajusta el padding según tus preferencias
                                        //   child: Column( 
                                        //     children: [
                                        //       const SizedBox(height: 8),
                                        //       Text(
                                        //         '#00${cotizacion['idCotizacion']}',
                                        //         style: const TextStyle(
                                        //           fontFamily: 'abyssinica_sil',
                                        //           fontWeight: FontWeight.bold,
                                        //           fontSize: 18,
                                        //           color: Color.fromRGBO(236, 0, 0, 100),
                                        //         ),
                                        //       ),
                                        //     ],
                                        //   ),
                                        // ),
                                        // const SizedBox(height: 8),
                                      ],
                                    ),
                                    // Text(
                                    //   '${cotizacion['detalleCotizacion'][0]['fechaCotizacion']}',
                                    // ),
                                  ],
                                ),
                                // Text(
                                //   '#00${cotizacion['idCotizacion']}',
                                //   style: const TextStyle(
                                //     fontWeight: FontWeight.bold,
                                //     fontSize: 16,
                                //   ),
                                //   textAlign: TextAlign.right,
                                // ),
                                // ],
                              ),
                            ),
                          ),
                        ), 
                      );
                    },
                  ),
      )
    ]));
  }
}
