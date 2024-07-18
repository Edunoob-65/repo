class Receta {
  int? id;
  int usuarioId;
  String titulo;
  String ingredientes;
  String pasos;
  String rutaImagen;
  String categoria;

  Receta({
    this.id,
    required this.usuarioId,
    required this.titulo,
    required this.ingredientes,
    required this.pasos,
    required this.rutaImagen,
    required this.categoria,
  });

  // Convertir de Map a Receta
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

  // Convertir de Receta a Map
  Map<String, dynamic> toMap() {
    return {
      'usuarioId': usuarioId,
      'titulo': titulo,
      'ingredientes': ingredientes,
      'pasos': pasos,
      'rutaImagen': rutaImagen,
      'categoria': categoria,
    };
  }
}
