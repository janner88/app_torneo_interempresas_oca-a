import 'package:flutter/material.dart';
import '../models/equipo.dart';
import '../services/firebase_service.dart';
import 'team_detail_page.dart';

class TeamsPage extends StatelessWidget {
  const TeamsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FirebaseService _firebaseService = FirebaseService();

    return StreamBuilder<List<Equipo>>(
      stream: _firebaseService.getEquipos(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        List<Equipo> equipos = snapshot.data ?? [];

        if (equipos.isEmpty) {
          return Center(child: Text('No hay equipos disponibles'));
        }

        return GridView.builder(
          padding: const EdgeInsets.all(10),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.5,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: equipos.length,
          itemBuilder: (context, index) {
            final equipo = equipos[index];

            return Card(
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TeamDetailPage(equipoId: equipo.id),
                    ),
                  );
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    equipo.logo.isNotEmpty
                        ? CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage(equipo.logo),
                          )
                        : CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.grey[300],
                            child: Text(
                              equipo.nombre.substring(0, 1),
                              style: const TextStyle(fontSize: 20),
                            ),
                          ),
                    const SizedBox(height: 8),
                    Text(
                      equipo.nombre,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
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
