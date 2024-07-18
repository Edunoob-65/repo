import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recetariopersonal/databases/database.dart';
import 'package:recetariopersonal/modelos/receta.dart';

class AddRecipeScreen extends StatefulWidget {
  final int usuarioId; // Id del usuario actual
  AddRecipeScreen({required this.usuarioId});

  @override
  _AddRecipeScreenState createState() => _AddRecipeScreenState();
}

class _AddRecipeScreenState extends State<AddRecipeScreen> {
  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _ingredientesController = TextEditingController();
  final TextEditingController _pasosController = TextEditingController();
  final TextEditingController _categoriaController = TextEditingController();
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  File? _imagenReceta;

  Future<void> _seleccionarImagen() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imagenReceta = File(pickedFile.path);
      });
    }
  }

  void _agregarReceta() async {
    String titulo = _tituloController.text.trim();
    String ingredientes = _ingredientesController.text.trim();
    String pasos = _pasosController.text.trim();
    String categoria = _categoriaController.text.trim();

    // Validar que los campos no estén vacíos
    if (titulo.isEmpty || ingredientes.isEmpty || pasos.isEmpty || categoria.isEmpty) {
      _mostrarError('Por favor, complete todos los campos');
      return;
    }

    // Crear el objeto Receta
    Receta nuevaReceta = Receta(
      id: 0, // El ID se asignará automáticamente en la base de datos
      usuarioId: widget.usuarioId,
      titulo: titulo,
      ingredientes: ingredientes,
      pasos: pasos,
      categoria: categoria,
      rutaImagen: _imagenReceta?.path ?? '',
    );

    // Insertar la receta en la base de datos
    await _databaseHelper.insertarReceta(nuevaReceta);

    // Mostrar un mensaje o navegar a otra pantalla
    _mostrarMensaje('Receta agregada exitosamente');

    // Opcional: navegar de regreso a la pantalla anterior
    Navigator.pop(context);
  }

  void _mostrarError(String mensaje) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(mensaje), backgroundColor: Colors.red),
    );
  }

  void _mostrarMensaje(String mensaje) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(mensaje), backgroundColor: Colors.green),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar Receta'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _tituloController,
                decoration: InputDecoration(labelText: 'Título'),
              ),
              SizedBox(height: 12.0),
              TextField(
                controller: _ingredientesController,
                decoration: InputDecoration(labelText: 'Ingredientes'),
                maxLines: 4,
              ),
              SizedBox(height: 12.0),
              TextField(
                controller: _pasosController,
                decoration: InputDecoration(labelText: 'Pasos'),
                maxLines: 4,
              ),
              SizedBox(height: 12.0),
              TextField(
                controller: _categoriaController,
                decoration: InputDecoration(labelText: 'Categoría'),
              ),
              SizedBox(height: 24.0),
              ElevatedButton(
                onPressed: _seleccionarImagen,
                child: Text('Seleccionar Imagen'),
              ),
              SizedBox(height: 12.0),
              _imagenReceta != null
                  ? Image.file(
                      _imagenReceta!,
                      height: 400.0,
                      width: 400.0,
                      fit: BoxFit.cover,
                    )
                  : Container(),
              SizedBox(height: 12.0),
              ElevatedButton(
                onPressed: _agregarReceta,
                child: Text('Agregar Receta'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
