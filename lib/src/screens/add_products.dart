import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddProductsPage extends StatefulWidget {
  const AddProductsPage({super.key});

  @override
  AddProductPageState createState() => AddProductPageState();
}

class AddProductPageState extends State<AddProductsPage> {
  bool loading = true;
  late String error;
  
  final _formKey = GlobalKey<FormState>();
  String nombreProducto = '';
  String descripcion = '';
  String material = '';
  String precioUnitario = '';
  String cantidadDisponible = '';

  @override
  void initState() {
    super.initState();
    error = '';
    agregarProducto();
  }

  Future<void> agregarProducto() async {
    Map<String, String> datosProducto = {
      'nombreProd': nombreProducto,
      'descripcion': descripcion,
      // 'tamano': tamano,
      // 'talla': talla,
      // 'color': color,
      'material': material,
      'precioUnitario': precioUnitario,
      'stock': cantidadDisponible,
    };

    final response = await http.post(Uri.parse('http://www.xclusivedesigns.somee.com/api/Producto')),
    body; datosProducto;

    if (response.statusCode == 200 && mounted) {
      setState(() {
        // productos = jsonDecode(response.body);
        loading = false;
      });
    } else {
      if (mounted) {
        setState(() {
          error = 'Error al cargar los productos';
          loading = false;
        });
      } else {
        if (mounted) {
          setState(() {
            error = 'Error al cargar los productos';
            loading = false;
          });
        }
      }

    }
  }
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
              onSaved: (value) {
                nombreProducto = value ?? '';
              },
            ),
            const SizedBox(height: 10),

            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Descripción',
                border: OutlineInputBorder(),
              ),
              onSaved: (value) {
                descripcion = value ?? '';
              },
            ),
            const SizedBox(height: 10),

            TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Material',
              ),
              onSaved: (value) {
                material = value ?? '';
              },
            ),
            const SizedBox(height: 10),

            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Precio unitario',
                border: OutlineInputBorder(),
              ),
              onSaved: (value) {
                precioUnitario = value ?? '';
              },
            ),
            const SizedBox(height: 10),

            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Cantidad disponible',
                border: OutlineInputBorder(),
              ),
              onSaved: (value) {
                cantidadDisponible = value ?? '';
              },
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
                                    if(_formKey.currentState != null && _formKey.currentState!.validate()) {
                                      _formKey.currentState!.save();
                                      agregarProducto();
                                    }
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




