class Jugador {
  final String id;
  final String nombre;
  final String equipoId;
  final String posicion;
  final int dorsal;
  final int goles;
  final int tarjetasAmarillas;
  final int tarjetasRojas;

  Jugador({
    required this.id,
    required this.nombre,
    required this.equipoId,
    required this.posicion,
    required this.dorsal,
    required this.goles,
    required this.tarjetasAmarillas,
    required this.tarjetasRojas,
  });

  // Convertir de Firestore a objeto Jugador
  factory Jugador.fromFirestore(Map<String, dynamic> data, String documentId) {
    return Jugador(
      id: documentId,
      nombre: data['nombre'] ?? '',
      equipoId: data['equipoId'] ?? '',
      posicion: data['posicion'] ?? '',
      dorsal: data['dorsal'] ?? 0,
      goles: data['goles'] ?? 0,
      tarjetasAmarillas: data['tarjetasAmarillas'] ?? 0,
      tarjetasRojas: data['tarjetasRojas'] ?? 0,
    );
  }

  // Convertir a mapa para Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'nombre': nombre,
      'equipoId': equipoId,
      'posicion': posicion,
      'dorsal': dorsal,
      'goles': goles,
      'tarjetasAmarillas': tarjetasAmarillas,
      'tarjetasRojas': tarjetasRojas,
    };
  }
}
