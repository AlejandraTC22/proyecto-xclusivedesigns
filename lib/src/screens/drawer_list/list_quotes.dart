import 'dart:async';
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
          : ListView.builder(
            itemCount: cotizacionesFiltradas.length,
            itemBuilder: (context, index) {
              final cotizacion = cotizacionesFiltradas[index];
              return Padding(
                padding: const EdgeInsets.all(12.0),

                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => QuoteNavigatorApp(cotizacion: cotizacion,)),
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
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
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
                          children:  [
                            const SizedBox(width: 15, height: 30),
                            const CircleAvatar(
                              radius: 30,
                              backgroundImage: AssetImage(
                                  'assets/cliente_image.jpg'),
                            ),

                            // const SizedBox(width: 5),

                            //Expanded(
                              // child: Padding(
                              //   padding: const EdgeInsets.symmetric(horizontal: 3),
                                Column(
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
                              //),
                            //)
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
    );
  }
}