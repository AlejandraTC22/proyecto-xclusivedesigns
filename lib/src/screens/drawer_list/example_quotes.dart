



import 'dart:async';
import 'package:flutter/material.dart';
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
    error = '';
    super.initState();
    _cargarCotizaciones();
  }

  Future<void> _cargarCotizaciones() async {
    const apiUrl = 'http://www.xclusivedesigns.somee.com/api/Cotizacion';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if(response.statusCode == 200 && mounted) {
        final dynamic responseData = jsonDecode(response.body);
        if (responseData is List) {
          setState(() {
            cotizaciones = responseData;
            cotizacionesFiltradas = responseData;
            loading = false;
          });
        }else{
          setState(() {
            error = 'Error al cargar las cotizaciones';
            loading = false;
          });
        }
      } else {
        if (mounted) {
          setState(() {
            error = 'Error al obtener datos. Código de estado: ${response.statusCode}';
            loading = false;
          });
        }
      }
    }
    catch (e) {
      if (mounted) {
        setState(() {
          error = 'Error al obtener datos. $e';
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
      body: loading
        ? const Center(child: CircularProgressIndicator())
        : error.isNotEmpty
          ? Center(child: Text(error))
          : Expanded( // Envolver el ListView.builder con un Container
            child: ListView.builder(
              itemCount: cotizacionesFiltradas.length,
              itemBuilder: (context, index) {
                final cotizacion = cotizacionesFiltradas[index];
                return Padding(
                  padding: const EdgeInsets.all(10.0),

                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => QuoteNavigatorApp(cotizaciones: cotizacion)),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const Spacer(),
                              const SizedBox(height: 30),
                              Text(
                                '#00${cotizacion['idCotizacion']}',
                                style: const TextStyle(
                                  fontFamily: 'Arial',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Color.fromRGBO(245, 31, 31, 0.952),
                                ),
                              ),             
                            ],
                          ),

                          Row(
                            children:  [
                              const SizedBox(width: 15, height: 30),
                              const CircleAvatar(
                                radius: 30,
                                backgroundImage: AssetImage('assets/cliente_image.jpg'),
                              ),

                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                  children: [
                                    Text(
                                      '${cotizacion['idClienteNavigation']['nombre']} ${cotizacion['idClienteNavigation']['apellido']}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17,
                                      ),
                                    ),
                                    Text(
                                      cotizacion['detalleCotizacion'].isNotEmpty?
                                      '${DateTime.parse(cotizacion['detalleCotizacion'][0]['fechaCotizacion']).day}/'
                                      '${DateTime.parse(cotizacion['detalleCotizacion'][0]['fechaCotizacion']).month}/'
                                      '${DateTime.parse(cotizacion['detalleCotizacion'][0]['fechaCotizacion']).year}'
                                      : 'No hay fecha de cotización',
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          const Row(
                            children: [
                              Spacer(),
                              SizedBox(height: 30),
                              Padding(
                                padding: EdgeInsets.only(right: 10),
                                child: Text('3 Productos')
                              )
                            ],
                          )
                        ]
                      )
                    )
                  )
                );
              }
            )
          )
    );
  }
}





//**************************************************************** */

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:xclusivedesigns/infrastructure/models/cotizacion.dart';
import 'package:xclusivedesigns/src/screens/drawer_navigator/navigator_quotes.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:dio/dio.dart';


class ListQuotesApp extends StatelessWidget {
  const ListQuotesApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromARGB(178, 255, 255, 255),
      ),
      home: const MyList(),
    );
  }
}

class MyList extends StatefulWidget {
  const MyList({Key? key}) : super(key: key);

  @override
  State<MyList> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyList> {

  Cotizaciones? = cotizaciones;

  // List<dynamic> cotizaciones = [];
  // List<dynamic> cotizacionesFiltradas = [];
  // bool loading = true;
  // late String error;
  // final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('es_ES', null);
    cargarCotizaciones();
  }

  Future<void> cargarCotizaciones() async {
    final response = await Dio().get('http://www.xclusivedesigns.somee.com/api/Cotizacion');
    Cotizaciones = Cotizaciones.fromJson(response.data);

    setState(() {
      
});
    // const apiUrl =
    //     'http://www.xclusivedesigns.somee.com/api/Cotizacion'; // Cambia el número 1 por el ID del producto que deseas obtener

    // try {
    //   final response = await http.get(Uri.parse(apiUrl));

    //   if (response.statusCode == 200 && mounted) {
    //     final dynamic responseData = jsonDecode(response.body);
    //     if (responseData is List) {
    //       setState(() {
    //         cotizaciones = responseData;
    //         cotizacionesFiltradas = responseData;
    //         loading = false;
    //       });
    //     } else {
    //       setState(() {
    //         error = 'Error: La respuesta no es una lista de cotizaciones';
    //         loading = false;
    //       });
    //     }
    //   } else {
    //     // Si el widget ya no está montado, no llamamos a setState
    //     if (mounted) {
    //       setState(() {
    //         error =
    //             'Error al obtener datos. Código de estado: ${response.statusCode}';
    //         loading = false;
    //       });
    //     }
    //   }
    // } catch (e) {
    //   // Manejar errores de red u otros
    //   if (mounted) {
    //     setState(() {
    //       error = 'Error: $e';
    //       loading = false;
    //     });
    //   }
    // }
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
                          borderRadius: BorderRadius.circular(10.0),
                          
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => QuoteNavigatorApp(cotizaciones: cotizacion,)),
                              );
                            },
                            // child: Container(
                            //   decoration: BoxDecoration(
                            //     border: Border.all(color: Colors.black),
                            //     borderRadius: BorderRadius.circular(15.0),
                            //   ),

                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      const Spacer(),
                                      const SizedBox(height: 20),
                                      Padding(
                                        padding: const EdgeInsets.only(right: 10.0),
                                        child: Text(
                                          '#00${cotizacion['idCotizacion']}',
                                          style: const TextStyle(
                                            fontFamily: 'Arial',
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            color: Color.fromRGBO(245, 31, 31, 0.952),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),

                                  Row(
                                    children: [
                                       const SizedBox(width: 15, height: 30),
                                      const Padding(
                                        padding:EdgeInsets.only(bottom: 30.0),

                                        child: CircleAvatar(
                                          radius: 18,
                                          backgroundImage: AssetImage('assets/cliente_image.jpg'),
                                        ),
                                      ),
                                      const SizedBox(width: 10),

                                      Padding(
                                        padding: const EdgeInsets.only(top: 15),
                                        child: Column(
                                          children: [

                                            Text(
                                              '${cotizacion['idClienteNavigation']['nombre']} ${cotizacion['idClienteNavigation']['apellido']}',
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                              ),
                                            ),

                                            const SizedBox(height: 3),

                                            Text(
                                              cotizacion['detalleCotizacion'].isNotEmpty?
                                              '${DateTime.parse(cotizacion['detalleCotizacion'][0]['fechaCotizacion']).day} de'
                                              ' ${DateFormat('MMMM', 'es_Es').format(DateTime.parse(cotizacion['detalleCotizacion'][0]['fechaCotizacion']))} de'
                                              ' ${DateTime.parse(cotizacion['detalleCotizacion'][0]['fechaCotizacion']).year}'
                                              : 'No hay fecha de cotización',
                                              style: const TextStyle(
                                                // fontWeight: FontWeight.bold,
                                                fontSize: 15,
                                              ),
                                            ),

                                            const SizedBox(height: 3),
                                            Text(
                                              cotizacion['cotizacionesProductos'] != null?
                                              '${cotizacion['cotizacionesProductos'].length} productos'
                                              : 'No hay productos',
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            //),
                          ),
                        ), 
                      );
                    },
                  ),
      )
    ]));
  }
}


