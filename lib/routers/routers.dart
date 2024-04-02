import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:xclusivedesigns/src/screens/add_products.dart';
import 'package:xclusivedesigns/src/screens/drawer_list/list_orders.dart';
import 'package:xclusivedesigns/src/screens/drawer_navigator/navigator_quotes.dart';
import 'package:xclusivedesigns/src/screens/home.dart';
import 'package:xclusivedesigns/src/screens/login.dart';
// import 'package:xclusivedesigns/src/screens/sign_in.dart';
import 'package:xclusivedesigns/src/screens/drawer_home_page.dart';
import 'package:xclusivedesigns/src/screens/drawer_list/list_products.dart';
import 'package:xclusivedesigns/src/screens/drawer_list/list_quotes.dart';
import 'package:xclusivedesigns/src/screens/drawer_list_btn/products_button.dart';
import 'package:xclusivedesigns/src/screens/principal.dart';
import 'package:xclusivedesigns/src/screens/drawer_notification/notification.dart';
import 'package:xclusivedesigns/src/screens/drawer_navigator/tarjeta_cotizacion_producto.dart';
//import 'package:xclusivedesigns/src/screens/drawer_notification/chat.dart';


final routers = GoRouter(
  initialLocation: '/home',
  routes: [
    // GoRoute(
    //   path: '/',
    //   pageBuilder: (context, state) => const Home(),
    // ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const MyHomePage(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginPage(),
    ),
    // GoRoute(
    //   path: '/sign_in',
    //   builder: (context, state) => const SignInPage(),
    // ),
    GoRoute(
      path: '/home_btm_nav_bar',
      builder: (context, state) => const BottomNavBarApp(),
    ),
    GoRoute(
      path: '/list_products',
      builder: (context, state) => const ListProductsApp(),
    ),
    GoRoute(
      path: '/principal_page',
      builder: (context, state) => const PrincipalPage(),
    ),
    GoRoute(
      path: '/list_quotes',
      builder: (context, state) => const ListQuotesApp(),
    ),
    GoRoute(
        path: '/product_details',
        builder: (context, state) => const ProductDetailsApp()
    ),
    GoRoute(
        path: '/list_orders',
        builder: (context, state) => const ListOrdersApp()
    ),
    GoRoute(
      path: '/notification',
      builder: (context, state) => const NotificationPage(),
    ),
    GoRoute(
      path: '/product_add',
      builder: (context, state) => const AddProductsPage(),
    )
  ],
);
