import 'package:flutter/material.dart';
import 'package:recetariopersonal/databases/database.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _correoController = TextEditingController();
  final TextEditingController _contrasenaController = TextEditingController();
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  String _error = '';

  void _registrar() async {
    String correo = _correoController.text.trim();
    String contrasena = _contrasenaController.text;

    // Validar que los campos no estén vacíos
    if (correo.isEmpty || contrasena.isEmpty) {
      setState(() {
        _error = 'Debe completar todos los campos';
      });
      return;
    }

    // Verificando si el usuario ya existe
    var usuarioExistente = await _databaseHelper.obtenerUsuario(correo, contrasena);
    if (usuarioExistente != null) {
      setState(() {
        _error = 'Ya existe el usuario que intentas registrar';
      });
      return;
    }

    await _databaseHelper.registrarUsuario(correo, contrasena);

    // Navegar a la pantalla de inicio de sesión
    Navigator.pushReplacementNamed(context, '/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registro'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _correoController,
              decoration: InputDecoration(
                labelText: 'Nombre de Usuario',
                errorText: _error.isNotEmpty ? _error : null,
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _contrasenaController,
              decoration: InputDecoration(
                labelText: 'Contraseña',
              ),
              obscureText: true,
            ),
            SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: _registrar,
              child: Text('Registrar'),
            ),
          ],
        ),
      ),
    );
  }
}
