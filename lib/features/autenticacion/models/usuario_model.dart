class Usuario {
  final int id;
  final String nombre;
  final String usuario;
  final String claveAcceso;

  Usuario({
    required this.id,
    required this.nombre,
    required this.usuario,
    required this.claveAcceso,
  });

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      id: json['id'] as int,
      nombre: json['nombre'] as String,
      usuario: json['usuario'] as String,
      claveAcceso: json['claveAcceso'] as String,
    );
  }
}
