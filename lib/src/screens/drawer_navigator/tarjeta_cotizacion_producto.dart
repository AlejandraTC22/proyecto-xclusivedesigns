import 'dart:ffi';
import 'package:flutter/material.dart';

class ExpansionCardApp extends StatefulWidget {
  final dynamic cotizacion;

  const ExpansionCardApp({Key? key, required this.cotizacion})
    : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  ExpansionCardPageState createState() => ExpansionCardPageState();
}

class ExpansionCardPageState extends State<ExpansionCardApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.cotizacion == null) {
      return const Scaffold(
        body: Center(
          child: Text('No hay datos'),
        ),
      );
    }
    return Scaffold(
      body: ListView(
        children:[
          Column(
            children: widget.cotizacion['cotizacionProducto'] 
            .map<Widget>((producto) {
              return Column(
                children: <Widget>[
                  ExpansionTile(
                    title: Text('${producto['idProductoNavigation']['nombreProd']}'),
                  )
                ]
              );
            }).toList()
          )
        ]
      )
    );
  }
}


    // return Scaffold(
    //     body: ListView(
    //       children: [
    //         Column(
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           children: <Widget>[
    //             Text(
    //               'ID de la Cotización: ${widget.cotizacion['idCotizacion']}',
    //               style: const TextStyle(fontSize: 20),
    //             ),
                
    //             Column(
    //               children: widget.cotizacion['cotizacionProductos']
    //                   .map<Widget>((producto) {

    //                 return Column(
    //                   children: <Widget>[
                        
    //                     Text(
    //                       'Nombre del Producto: ${producto['idProductoNavigation']['nombreProd']}',
    //                       style: const TextStyle(fontSize: 20),
    //                     ),
    //                     Text(
    //                       'Descripción del Producto: ${producto['idProductoNavigation']['descripcion']}',
    //                       style: const TextStyle(fontSize: 20),
    //                     ),
    //                     Text(
    //                       'Precio Unitario: ${producto['idProductoNavigation']['precioUnitario']}',
    //                       style: const TextStyle(fontSize: 20),
    //                     ),
    //                     // Agrega más Text widgets aquí para mostrar más datos del producto...
    //                   ],
    //                 );
    //               }).toList(),
    //             ),
    //           ],
    //         ),
    //       ],
    //     ));