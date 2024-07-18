import 'package:flutter/material.dart';
import 'package:recetariopersonal/pantallas/agregar%20receta.dart';
import 'package:recetariopersonal/pantallas/login.dart';
import 'package:recetariopersonal/pantallas/registro.dart';
import 'package:recetariopersonal/pantallas/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  get usuarioId => null;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Recetario Personal',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
        '/registro': (context) => RegisterScreen(),
        '/agregarReceta': (context) => AddRecipeScreen(usuarioId: usuarioId),
      },
    );
  }
}
