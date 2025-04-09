import 'package:flutter/material.dart';
import '../models/equipo.dart';
import '../models/jugador.dart';
import '../services/firebase_service.dart';

class TeamDetailPage extends StatelessWidget {
  final String equipoId;

  const TeamDetailPage({Key? key, required this.equipoId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FirebaseService _firebaseService = FirebaseService();

    return Scaffold(
      appBar: AppBar(
        title: StreamBuilder<Equipo?>(
          stream: Stream.fromFuture(_firebaseService.getEquipoById(equipoId)),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text(snapshot.data!.nombre);
            }
            return Text('Detalles del equipo');
          },
        ),
      ),
      body: Column(
        children: [
          // Información del equipo
          FutureBuilder<Equipo?>(
            future: _firebaseService.getEquipoById(equipoId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container(
                  height: 100,
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              if (snapshot.hasError || !snapshot.hasData) {
                return Container(
                  height: 100,
                  color: Colors.green[100],
                  padding: const EdgeInsets.all(20),
                  child: Center(child: Text('Error al cargar el equipo')),
                );
              }

              final equipo = snapshot.data!;

              return Container(
                color: Colors.green[100],
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    equipo.logo.isNotEmpty
                        ? CircleAvatar(
                            radius: 40,
                            backgroundImage: NetworkImage(equipo.logo),
                          )
                        : CircleAvatar(
                            radius: 40,
                            backgroundColor: Colors.grey[300],
                            child: Text(
                              equipo.nombre.substring(0, 1),
                              style: const TextStyle(fontSize: 24),
                            ),
                          ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            equipo.nombre,
                            style: const TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          Text('Posición: ${equipo.posicion}º'),
                          Text(
                              'PJ: ${equipo.partidosJugados} | PG: ${equipo.partidosGanados} | PE: ${equipo.partidosEmpatados} | PP: ${equipo.partidosPerdidos}'),
                          Text(
                              'Goles: ${equipo.golesFavor}-${equipo.golesContra} | Puntos: ${equipo.puntos}'),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),

          // Titulo de plantilla
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Plantilla',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),

          // Lista de jugadores
          Expanded(
            child: StreamBuilder<List<Jugador>>(
              stream: _firebaseService.getJugadoresPorEquipo(equipoId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                List<Jugador> jugadores = snapshot.data ?? [];

                if (jugadores.isEmpty) {
                  return Center(child: Text('No hay jugadores registrados'));
                }

                return ListView.builder(
                  itemCount: jugadores.length,
                  itemBuilder: (context, index) {
                    final jugador = jugadores[index];

                    return ListTile(
                      leading: CircleAvatar(
                        child: Text('${jugador.dorsal}'),
                      ),
                      title: Text(jugador.nombre),
                      subtitle: Text(jugador.posicion),
                      trailing: Text('Goles: ${jugador.goles}'),
                      onTap: () {
                        // Navegar a detalles del jugador si lo deseas
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
