// modelo/user.dart
class User {
  int id;
  String correo;
  String contrasena;

  User({required this.id, required this.correo, required this.contrasena});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'correo': correo,
      'contrasena': contrasena,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      correo: map['correo'],
      contrasena: map['contrasena'],
    );
  }
}

// modelo/receta.dart
class Receta {
  int id;
  int usuarioId;
  String titulo;
  String ingredientes;
  String pasos;
  String? rutaImagen;
  String categoria;

  Receta({
    required this.id,
    required this.usuarioId,
    required this.titulo,
    required this.ingredientes,
    required this.pasos,
    this.rutaImagen,
    required this.categoria,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'usuarioId': usuarioId,
      'titulo': titulo,
      'ingredientes': ingredientes,
      'pasos': pasos,
      'rutaImagen': rutaImagen,
      'categoria': categoria,
    };
  }

  factory Receta.fromMap(Map<String, dynamic> map) {
    return Receta(
      id: map['id'],
      usuarioId: map['usuarioId'],
      titulo: map['titulo'],
      ingredientes: map['ingredientes'],
      pasos: map['pasos'],
      rutaImagen: map['rutaImagen'],
      categoria: map['categoria'],
    );
  }
}
