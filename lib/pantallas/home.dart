import 'package:flutter/material.dart';
import 'package:recetariopersonal/databases/database.dart';
import 'package:recetariopersonal/modelos/receta.dart';
import 'package:recetariopersonal/pantallas/agregar%20receta.dart';
import 'package:recetariopersonal/pantallas/detallereceta.dart';

class HomeScreen extends StatefulWidget {
  final int usuarioId;

  HomeScreen({required this.usuarioId});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  List<Receta> _recetas = [];

  @override
  void initState() {
    super.initState();
    _cargarRecetas();
  }

  Future<void> _cargarRecetas() async {
    List<Receta> recetas = await _databaseHelper.obtenerRecetasPorUsuario(widget.usuarioId);
    setState(() {
      _recetas = recetas;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recetario'),
      ),
      body: Column(
        children: [
          Expanded(
            child: _recetas.isEmpty
                ? Center(child: Text('No hay recetas guardadas'))
                : ListView.builder(
                    itemCount: _recetas.length,
                    itemBuilder: (context, index) {
                      Receta receta = _recetas[index];
                      return ListTile(
                        title: Text(receta.titulo),
                        subtitle: Text(receta.categoria),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => RecipeDetailScreen(receta: receta)),
                          );
                        },
                      );
                    },
                  ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                // Navegar a la pantalla de agregar receta
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddRecipeScreen(usuarioId: widget.usuarioId)),
                ).then((_) {
                  // Actualizar la lista de recetas después de agregar una nueva
                  _cargarRecetas();
                });
              },
              child: Text('Agregar Recetas'),
            ),
          ),
        ],
      ),
    );
  }
}
