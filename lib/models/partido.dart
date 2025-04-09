import 'package:cloud_firestore/cloud_firestore.dart';

class Partido {
  final String id;
  final String equipoLocalId;
  final String equipoVisitanteId;
  final String equipoLocalNombre;
  final String equipoVisitanteNombre;
  final int golesLocal;
  final int golesVisitante;
  final DateTime fecha;
  final String estado; // "programado", "en_curso", "finalizado"
  final int minutoActual;

  Partido({
    required this.id,
    required this.equipoLocalId,
    required this.equipoVisitanteId,
    required this.equipoLocalNombre,
    required this.equipoVisitanteNombre,
    required this.golesLocal,
    required this.golesVisitante,
    required this.fecha,
    required this.estado,
    required this.minutoActual,
  });

  // Convertir de Firestore a objeto Partido
  factory Partido.fromFirestore(Map<String, dynamic> data, String documentId) {
    return Partido(
      id: documentId,
      equipoLocalId: data['equipoLocalId'] ?? '',
      equipoVisitanteId: data['equipoVisitanteId'] ?? '',
      equipoLocalNombre: data['equipoLocalNombre'] ?? '',
      equipoVisitanteNombre: data['equipoVisitanteNombre'] ?? '',
      golesLocal: data['golesLocal'] ?? 0,
      golesVisitante: data['golesVisitante'] ?? 0,
      fecha: (data['fecha'] as Timestamp).toDate(),
      estado: data['estado'] ?? 'programado',
      minutoActual: data['minutoActual'] ?? 0,
    );
  }

  // Convertir a mapa para Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'equipoLocalId': equipoLocalId,
      'equipoVisitanteId': equipoVisitanteId,
      'equipoLocalNombre': equipoLocalNombre,
      'equipoVisitanteNombre': equipoVisitanteNombre,
      'golesLocal': golesLocal,
      'golesVisitante': golesVisitante,
      'fecha': Timestamp.fromDate(fecha),
      'estado': estado,
      'minutoActual': minutoActual,
    };
  }

  // Método para saber si el partido es en vivo
  bool get esEnVivo => estado == 'en_curso';

  // Método para obtener resultado formateado
  String get resultado => '$golesLocal - $golesVisitante';
}
