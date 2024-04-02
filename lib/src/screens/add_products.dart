import 'package:flutter/material.dart';
import 'package:xclusivedesigns/src/screens/drawer_list/list_products.dart';

class AddProductsPage extends StatefulWidget {
  const AddProductsPage({super.key});

  @override
  AddProductPageState createState() => AddProductPageState();
}

class AddProductPageState extends State<AddProductsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar producto'),
      ),
      
      body: Form(
        child: ListView(
          padding: const EdgeInsets.all(15),

          children:<Widget>[

            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Nombre del producto',
                border: OutlineInputBorder(),

              ),
            ),
            const SizedBox(height: 10),

            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Descripción',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),

            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Tamaño',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),

            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Talla',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),

            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Color',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),

            TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Material',
              ),
            ),
            const SizedBox(height: 10),

            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Precio unitario',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),

            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Cantidad disponible',
                border: OutlineInputBorder(),
              ),
            ),

            ElevatedButton(
              onPressed: (){},
              child: const Icon(Icons.add_a_photo),
            ),

            const SizedBox(height: 16),

            ElevatedButton(
              onPressed: (){},
              child: const Icon(Icons.cloud_upload),
            ),

            const SizedBox(height: 15),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 9, 79, 255),
                alignment: Alignment.center,
              ),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  
                  builder: (BuildContext context) {
                    return SizedBox(
                      height: 250,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const Text('¿Deseas agregar el producto?',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Aceptar'),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    // Navigator.pop(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //     builder: (context) => const ListProductsApp(),
                                    //   ),
                                    // );
                                  },
                                  child: const Text('Cancelar'),
                                ),
                              ],
                            ),
                            // ElevatedButton(
                            //   onPressed: () {
                            //     Navigator.pop(context);
                            //   },
                            //   child: const Text('Cerrar'),
                            // )
                          ],
                        ),
                      ),
                    );
                  },
                );
                // Enviar los datos del formulario
              },
              child: const Text('Agregar Producto',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                ),
              ),
            ),
          ]
        ),
      ),
    );
  }
}




