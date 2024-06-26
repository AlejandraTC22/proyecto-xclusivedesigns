import 'package:flutter/material.dart';
import '../drawer_navigator/tarjeta_cotizacion_producto.dart';

class QuoteNavigatorApp extends StatefulWidget {
  final Map<String, dynamic> cotizaciones;

  const QuoteNavigatorApp({Key? key, required this.cotizaciones})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  QuoteNavigatorPageState createState() => QuoteNavigatorPageState();
}

class QuoteNavigatorPageState extends State<QuoteNavigatorApp> {
  @override
  Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(),
    body: ListView(
      children: [
        Column(
          children: <Widget>[
            const Text('Descripcción',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),

            Text(
              'Fecha de entrega                       ${DateTime.parse(widget.cotizaciones['detalleCotizacion'][0]['fechaVencimiento']).day}/'
              '${DateTime.parse(widget.cotizaciones['detalleCotizacion'][0]['fechaVencimiento']).month}/'                '${DateTime.parse(widget.cotizaciones['detalleCotizacion'][0]['fechaVencimiento']).year}',
              style: const TextStyle(fontSize: 20),
          
            ),
            Container(
              padding: const EdgeInsets.all(20.0),
              child:  Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: <Widget>[
                      Text(
                        'Cotización #00${widget.cotizaciones['idCotizacion']}',
                        style: const TextStyle(fontSize: 20),
                      ),

                      Text(
                        '${widget.cotizaciones['estado']}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(245, 31, 31, 0.952),
                        ),
                        
                      ),
                    ],
                  ),

                  Flexible(
                    child: ExpansionCardApp(cotizacion: widget.cotizaciones['cotizacionProductos']),
                  )
                ]
              )
            ),
          ],
        ),
      ],
    ),
  );
  }
}
