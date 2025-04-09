class Equipo {
  final String id;
  final String nombre;
  final String logo;
  final int posicion;
  final int partidosJugados;
  final int partidosGanados;
  final int partidosEmpatados;
  final int partidosPerdidos;
  final int golesFavor;
  final int golesContra;
  final int puntos;

  Equipo({
    required this.id,
    required this.nombre,
    required this.logo,
    required this.posicion,
    required this.partidosJugados,
    required this.partidosGanados,
    required this.partidosEmpatados,
    required this.partidosPerdidos,
    required this.golesFavor,
    required this.golesContra,
    required this.puntos,
  });

  // Convertir de Firestore a objeto Equipo
  factory Equipo.fromFirestore(Map<String, dynamic> data, String documentId) {
    return Equipo(
      id: documentId,
      nombre: data['nombre'] ?? '',
      logo: data['logo'] ?? '',
      posicion: data['posicion'] ?? 0,
      partidosJugados: data['partidosJugados'] ?? 0,
      partidosGanados: data['partidosGanados'] ?? 0,
      partidosEmpatados: data['partidosEmpatados'] ?? 0,
      partidosPerdidos: data['partidosPerdidos'] ?? 0,
      golesFavor: data['golesFavor'] ?? 0,
      golesContra: data['golesContra'] ?? 0,
      puntos: data['puntos'] ?? 0,
    );
  }

  // Convertir a mapa para Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'nombre': nombre,
      'logo': logo,
      'posicion': posicion,
      'partidosJugados': partidosJugados,
      'partidosGanados': partidosGanados,
      'partidosEmpatados': partidosEmpatados,
      'partidosPerdidos': partidosPerdidos,
      'golesFavor': golesFavor,
      'golesContra': golesContra,
      'puntos': puntos,
    };
  }
}
