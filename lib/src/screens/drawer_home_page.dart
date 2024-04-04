import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:xclusivedesigns/src/screens/drawer_list/Profile_customer.dart';
import 'package:xclusivedesigns/src/screens/drawer_list/list_orders.dart';
import 'package:xclusivedesigns/src/screens/drawer_list/list_products.dart';
import 'package:xclusivedesigns/src/screens/drawer_list/list_quotes.dart';
import 'package:xclusivedesigns/src/screens/drawer_navigator/navigator_quotes.dart';
import 'package:xclusivedesigns/src/screens/principal.dart'; // Importa la página de ListQuotesPage
import 'package:xclusivedesigns/src/screens/drawer_notification/notification.dart';
import 'package:xclusivedesigns/src/screens/drawer_navigator/navigator_quotes.dart';


void main() {
  runApp(const BottomNavBarApp());
}

class BottomNavBarApp extends StatelessWidget {
  const BottomNavBarApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromARGB(178, 255, 255, 255),
      ),
      home: BottomNavigationBarExample(),
    );
  }
}

class BottomNavigationBarExample extends StatefulWidget {
  const BottomNavigationBarExample({Key? key}) : super(key: key);

  @override
  State<BottomNavigationBarExample> createState() =>
      _BottomNavigationBarExampleState();
}

class _BottomNavigationBarExampleState
    extends State<BottomNavigationBarExample> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    PrincipalPage(), // Placeholder para la página de inicio
    ListProductsApp(), // Página de ListProductsPage
    ListQuotesApp(), // Página de ListQuotesPage
    ListOrdersApp(), // Página de ListQuotesPage
    ProfileCusyomerApp(), // Página de ProfileCustomerPage
    QuoteNavigatorApp(cotizaciones: {}), // Página de QuoteNavigatorPage
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Color customColor = const Color(0xFFFFD951);
    Color unselectedIconColor = Color.fromARGB(255, 63, 62, 62);
    return Scaffold(
      
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(255, 217, 81, 1),
        title: const Text('Xclusive Designs'),
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 23,
          fontWeight: FontWeight.bold,
        ),

        actions: <Widget>[
          Row(
            children: <Widget>[
              badges.Badge(
                badgeContent: const Text('3', style: TextStyle(color: Colors.white)),
                padding: const EdgeInsets.all(7),
                child: IconButton(
                  icon: const Icon(Icons.notifications),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const NotificationPage()),
                    );
                  },
                ),
              ),
              const SizedBox(width: 20),
            ],
          ),
        ],
      ),
      
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.inventory),
            label: 'Inventario',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.request_quote),
            label: 'Cotizaciones',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Pedidos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.track_changes),
            label: 'Tarjeta',
          )
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: customColor,
        unselectedItemColor: unselectedIconColor,
        onTap: _onItemTapped,
      ),
    );
  }
}