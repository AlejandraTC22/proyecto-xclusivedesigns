import 'package:flutter/material.dart';

class ProfileCusyomerApp extends StatefulWidget {
  const ProfileCusyomerApp({Key? key}) : super(key: key);

  @override
  MyProfile createState() => MyProfile();
}

class MyProfile extends State<ProfileCusyomerApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi perfil'),
        // leading: IconButton(
        //   icon: const Icon(Icons.arrow_back),
        //   onPressed: () => context.go('/home_drawer')),
      ),
      // body: ListView(
      //   // aqui va la pantalla de la lista de productos
      //   children: [],
      // ),
    );
  }
}