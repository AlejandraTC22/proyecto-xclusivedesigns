import 'package:flutter/material.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;

class PrincipalPage extends StatefulWidget {
  const PrincipalPage({Key? key}) : super(key: key);

  @override
  _PrincipalPageState createState() => _PrincipalPageState();
}

class _PrincipalPageState extends State<PrincipalPage> {

//   List<dynamic> pedidosVencerPronto = [];
//   bool loading = true;
//   late String error;

//   @override
//   void initState() {
//     super.initState();
//     // Inicializamos 'error' en initState o en cualquier otro lugar necesario.
//     error = '';
//     _obtenerPedidosVencenPronto();
//   }

//   Future<void> _obtenerPedidosVencenPronto() async {
//   final fechaActual = DateTime.now();
//   var fechaVencimientoInicio = fechaActual.add(const Duration(days: 1)); 
//   var fechaVencimientoFin = fechaActual.add(const Duration(days: 2)); 

//   const apiUrl = 'http://www.xclusivedesigns.somee.com/api/Pedido';

//   try {
//     final response = await http.get(Uri.parse(apiUrl));

//     if (response.statusCode == 200 && mounted) {
//       final dynamic responseData = jsonDecode(response.body);
//       if (responseData is List) {
//         final List<dynamic> pedidos = responseData;
//         final pedidosVencenPronto = pedidos.where((pedido) {
//           final fechaEntrega = DateTime.parse(pedido['fechaEntrega']);
//           return fechaEntrega.isAfter(fechaVencimientoInicio) && fechaEntrega.isBefore(fechaVencimientoFin);
//         }).toList();

//         setState(() {
//           pedidosVencerPronto = pedidosVencenPronto;
//           loading = false;
//         });
//       } else {
//         setState(() {
//           error = 'Error: La respuesta no es una lista de pedidos';
//           loading = false;
//         });
//       }
//     } else {
//       throw Exception('Error al cargar los pedidos');
//     }
//   } catch (e) {
//     setState(() {
//       error = e.toString();
//       loading = false;
//     });
//   }
// }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: loading
      // ? const Center(child: CircularProgressIndicator())
      // : error.isNotEmpty
      //   ? Center(child: Text(error))
      //   : ListView.builder(
      //     itemCount: pedidosVencerPronto.length,
      //     itemBuilder: (context, index) {
      //       final pedidoVencer = pedidosVencerPronto[index];
      //       return Padding(
      //         padding: const EdgeInsets.all(8.0),
      //         child: Material(
      //           elevation: 8,
      //           shadowColor: Colors.grey.withOpacity(0.5),
      //           shape: RoundedRectangleBorder(
      //             borderRadius: BorderRadius.circular(8.0),
      //           ),
      //           child: Container(
      //             decoration: BoxDecoration(
      //               border: Border.all(color: Colors.black),
      //               borderRadius: BorderRadius.circular(8.0),
      //             ),
      //             child: Padding(
      //               padding: const EdgeInsets.all(8.0),
      //               child: Column(
      //                 children: [
      //                   Row(
      //                     children: [
      //                       // Espacio entre los dos textos
      //                       const Text(
      //                         'Otro texto aquí', // Coloca el otro texto aquí
      //                         style: TextStyle(
      //                           fontWeight: FontWeight.bold,
      //                           fontSize: 16,
      //                         ),
      //                       ),
      //                       const SizedBox(width: 8),
      //                       Text(
      //                         '#${pedidoVencer['idPedido']}',
      //                         style: const TextStyle(
      //                           fontWeight: FontWeight.bold,
      //                           fontSize: 16,
      //                         ),
      //                       ),
      //                     ],
      //                   ),
      //                   const SizedBox(height: 8),
      //                   Row(
      //                     children: [
      //                       Expanded(
      //                         flex: 1,
      //                         child: Image.asset(
      //                           'assets/minnie-bday.jpeg',
      //                           width: 60,
      //                         ),
      //                       ),
      //                       Expanded(
      //                         flex: 2,
      //                         child: Padding(
      //                           padding: const EdgeInsets.symmetric(
      //                               horizontal: 8.0),
      //                           child: Column(
      //                             children: [
      //                               Row(
      //                                 children: [
      //                                   Text(
      //                                     'ID: ${pedidoVencer['idCliente']}',
      //                                   ),
      //                                   const Text('Cliente: '),
      //                                   Text(
      //                                     '${pedidoVencer['idClienteNavigation']['nombre']}'
      //                                     ' '
      //                                     '${pedidoVencer['idClienteNavigation']['apellido']}',
      //                                     // '${pedidoVencer['detallePedido']['fechaEntrega']}',
      //                                   ),
      //                                   const SizedBox(height: 8),
      //                                 ],
      //                               ),
      //                               // Text(
      //                               //   '${pedido['detalleCotizacion'][0]['fechaCotizacion']}',
      //                               // ),
      //                               const SizedBox(height: 8),
      //                               ElevatedButton(
      //                                 onPressed: () {
      //                                   // Acción cuando se presiona el botón "Ver más"
      //                                 },
      //                                 child: const Text('Ver más'),
      //                               ),
      //                             ],
      //                           ),
      //                         ),
      //                       ),
      //                     ],
      //                   ),
      //                 ],
      //               ),
      //             ),
      //           ),
      //         ),
      //       );
      //     },
      //   ),
    );
  }
}