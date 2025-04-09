// lib/services/firebase_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/equipo.dart';
import '../models/jugador.dart';
import '../models/partido.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // EQUIPOS
  // Obtener todos los equipos
  Stream<List<Equipo>> getEquipos() {
    return _firestore
        .collection('equipos')
        .orderBy('posicion')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => Equipo.fromFirestore(doc.data(), doc.id))
          .toList();
    });
  }

  // Obtener un equipo por ID
  Future<Equipo?> getEquipoById(String equipoId) async {
    DocumentSnapshot doc =
        await _firestore.collection('equipos').doc(equipoId).get();

    if (doc.exists) {
      return Equipo.fromFirestore(doc.data() as Map<String, dynamic>, doc.id);
    }

    return null;
  }

  // JUGADORES
  // Obtener jugadores por equipo
  Stream<List<Jugador>> getJugadoresPorEquipo(String equipoId) {
    return _firestore
        .collection('jugadores')
        .where('equipoId', isEqualTo: equipoId)
        .orderBy('dorsal')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => Jugador.fromFirestore(doc.data(), doc.id))
          .toList();
    });
  }

  // Obtener todos los jugadores
  Stream<List<Jugador>> getAllJugadores() {
    return _firestore.collection('jugadores').snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => Jugador.fromFirestore(doc.data(), doc.id))
          .toList();
    });
  }

  // Obtener goleadores ordenados
  Stream<List<Jugador>> getGoleadores() {
    return _firestore
        .collection('jugadores')
        .orderBy('goles', descending: true)
        .limit(20)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => Jugador.fromFirestore(doc.data(), doc.id))
          .toList();
    });
  }

  // PARTIDOS
  // Obtener partidos en vivo
  Stream<List<Partido>> getPartidosEnVivo() {
    return _firestore
        .collection('partidos')
        .where('estado', isEqualTo: 'en_curso')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => Partido.fromFirestore(doc.data(), doc.id))
          .toList();
    });
  }

  // Obtener partidos del día
  Stream<List<Partido>> getPartidosDelDia() {
    DateTime hoy = DateTime.now();
    DateTime inicio = DateTime(hoy.year, hoy.month, hoy.day);
    DateTime fin = inicio.add(Duration(days: 1));

    return _firestore
        .collection('partidos')
        .where('fecha', isGreaterThanOrEqualTo: Timestamp.fromDate(inicio))
        .where('fecha', isLessThan: Timestamp.fromDate(fin))
        .orderBy('fecha')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => Partido.fromFirestore(doc.data(), doc.id))
          .toList();
    });
  }

  // Obtener próximos partidos
  Stream<List<Partido>> getProximosPartidos() {
    DateTime ahora = DateTime.now();

    return _firestore
        .collection('partidos')
        .where('fecha', isGreaterThan: Timestamp.fromDate(ahora))
        .orderBy('fecha')
        .limit(10)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => Partido.fromFirestore(doc.data(), doc.id))
          .toList();
    });
  }

  // ADMIN: Métodos para el panel de administración
  // Agregar un nuevo equipo
  Future<void> addEquipo(Equipo equipo) {
    return _firestore.collection('equipos').add(equipo.toFirestore());
  }

  // Actualizar un equipo existente
  Future<void> updateEquipo(Equipo equipo) {
    return _firestore
        .collection('equipos')
        .doc(equipo.id)
        .update(equipo.toFirestore());
  }

  // Agregar un nuevo jugador
  Future<void> addJugador(Jugador jugador) {
    return _firestore.collection('jugadores').add(jugador.toFirestore());
  }

  // Actualizar un jugador existente
  Future<void> updateJugador(Jugador jugador) {
    return _firestore
        .collection('jugadores')
        .doc(jugador.id)
        .update(jugador.toFirestore());
  }

  // Agregar un nuevo partido
  Future<void> addPartido(Partido partido) {
    return _firestore.collection('partidos').add(partido.toFirestore());
  }

  // Actualizar un partido existente (por ejemplo, para actualizar marcador)
  Future<void> updatePartido(Partido partido) {
    return _firestore
        .collection('partidos')
        .doc(partido.id)
        .update(partido.toFirestore());
  }
}
