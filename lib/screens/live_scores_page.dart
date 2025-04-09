// lib/screens/live_scores_page.dart
import 'package:flutter/material.dart';
import '../models/partido.dart';
import '../services/firebase_service.dart';

class LiveScoresPage extends StatelessWidget {
  const LiveScoresPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FirebaseService _firebaseService = FirebaseService();

    return StreamBuilder<List<Partido>>(
      stream: _firebaseService.getPartidosEnVivo(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        List<Partido> partidosEnVivo = snapshot.data ?? [];

        if (partidosEnVivo.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.sports_soccer, size: 50, color: Colors.grey),
                SizedBox(height: 16),
                Text(
                  'No hay partidos en vivo en este momento',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          itemCount: partidosEnVivo.length,
          itemBuilder: (context, index) {
            final partido = partidosEnVivo[index];

            return Card(
              margin: const EdgeInsets.all(8.0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Minuto ${partido.minutoActual}\'',
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.grey,
                              child: Text(
                                  partido.equipoLocalNombre.substring(0, 1)),
                            ),
                            const SizedBox(height: 5),
                            Text(partido.equipoLocalNombre),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              partido.resultado,
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Text(
                                'EN VIVO',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.grey,
                              child: Text(partido.equipoVisitanteNombre
                                  .substring(0, 1)),
                            ),
                            const SizedBox(height: 5),
                            Text(partido.equipoVisitanteNombre),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
