import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const FootballApp());
}

class FootballApp extends StatelessWidget {
  const FootballApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Torneo InterEmpresas de Futbol Ocaña 2025',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    const LiveScoresPage(),
    const TeamsPage(),
    const PlayersPage(),
    const StatsPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Torneo Local de Fútbol')),
      body: Center(child: _widgetOptions.elementAt(_selectedIndex)),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.sports_soccer),
            label: 'En vivo',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.group), label: 'Equipos'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Jugadores'),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Estadísticas',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green[800],
        onTap: _onItemTapped,
      ),
    );
  }
}

// Página de marcadores en vivo
class LiveScoresPage extends StatelessWidget {
  const LiveScoresPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5, // Ejemplo con 5 partidos
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.all(8.0),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Hoy - 18:00',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        const CircleAvatar(
                          backgroundColor: Colors.grey,
                          child: Text('E1'),
                        ),
                        const SizedBox(height: 5),
                        Text('Equipo ${index * 2 + 1}'),
                      ],
                    ),
                    Column(
                      children: [
                        const Text(
                          '2 - 1',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text(
                            'EN VIVO',
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        const CircleAvatar(
                          backgroundColor: Colors.grey,
                          child: Text('E2'),
                        ),
                        const SizedBox(height: 5),
                        Text('Equipo ${index * 2 + 2}'),
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
  }
}

// Página de equipos
class TeamsPage extends StatelessWidget {
  const TeamsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.5,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: 10, // Ejemplo con 10 equipos
      itemBuilder: (context, index) {
        return Card(
          child: InkWell(
            onTap: () {
              // Navegar a detalles del equipo
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TeamDetailPage(teamId: index),
                ),
              );
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.grey[300],
                  child: Text(
                    'E${index + 1}',
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Equipo ${index + 1}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// Página de detalle de equipo
class TeamDetailPage extends StatelessWidget {
  final int teamId;

  const TeamDetailPage({Key? key, required this.teamId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Equipo ${teamId + 1}')),
      body: Column(
        children: [
          Container(
            color: Colors.green[100],
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.grey[300],
                  child: Text(
                    'E${teamId + 1}',
                    style: const TextStyle(fontSize: 24),
                  ),
                ),
                const SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Equipo ${teamId + 1}',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text('Posición: ${(teamId % 10) + 1}º'),
                    Text('PJ: 12 | PG: 7 | PE: 3 | PP: 2'),
                  ],
                ),
              ],
            ),
          ),
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
          Expanded(
            child: ListView.builder(
              itemCount: 15, // Ejemplo con 15 jugadores
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(child: Text('${index + 1}')),
                  title: Text('Jugador ${index + 1}'),
                  subtitle: Text(
                    index < 3
                        ? 'Portero'
                        : index < 8
                            ? 'Defensa'
                            : index < 13
                                ? 'Mediocampista'
                                : 'Delantero',
                  ),
                  trailing: Text('Goles: ${index % 5}'),
                  onTap: () {
                    // Navegar a detalles del jugador
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

// Página de jugadores (simplificada para el ejemplo)
class PlayersPage extends StatelessWidget {
  const PlayersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 30, // Ejemplo con 30 jugadores
      itemBuilder: (context, index) {
        return ListTile(
          leading: CircleAvatar(child: Text('${index + 1}')),
          title: Text('Jugador ${index + 1}'),
          subtitle: Text('Equipo ${(index % 10) + 1}'),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () {
            // Navegar a detalles del jugador
          },
        );
      },
    );
  }
}

// Página de estadísticas
class StatsPage extends StatelessWidget {
  const StatsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          const TabBar(
            labelColor: Colors.green,
            tabs: [
              Tab(text: 'Goles'),
              Tab(text: 'Tarjetas'),
              Tab(text: 'Equipos'),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                // Goleadores
                ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: CircleAvatar(child: Text('${index + 1}')),
                      title: Text('Jugador ${20 - index}'),
                      subtitle: Text('Equipo ${(index % 10) + 1}'),
                      trailing: Text('${10 - index} goles'),
                    );
                  },
                ),
                // Tarjetas
                ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: CircleAvatar(child: Text('${index + 1}')),
                      title: Text('Jugador ${15 - index}'),
                      subtitle: Text('Equipo ${(index % 10) + 1}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 15,
                            height: 20,
                            color: Colors.yellow,
                            margin: const EdgeInsets.only(right: 5),
                          ),
                          Text('${5 - (index % 5)}'),
                          const SizedBox(width: 10),
                          Container(
                            width: 15,
                            height: 20,
                            color: Colors.red,
                            margin: const EdgeInsets.only(right: 5),
                          ),
                          Text('${index % 2}'),
                        ],
                      ),
                    );
                  },
                ),
                // Estadísticas por equipos
                ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Card(
                      margin: const EdgeInsets.all(8.0),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.grey[300],
                                  child: Text('${index + 1}'),
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  'Equipo ${index + 1}',
                                  style: const TextStyle(
                                    fontSize: 18,
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
                                    const Text('PJ'),
                                    const SizedBox(height: 5),
                                    Text('${10 + index}'),
                                  ],
                                ),
                                Column(
                                  children: [
                                    const Text('GF'),
                                    const SizedBox(height: 5),
                                    Text('${20 - index}'),
                                  ],
                                ),
                                Column(
                                  children: [
                                    const Text('GC'),
                                    const SizedBox(height: 5),
                                    Text('${10 + (index % 5)}'),
                                  ],
                                ),
                                Column(
                                  children: [
                                    const Text('TA'),
                                    const SizedBox(height: 5),
                                    Text('${15 - (index % 8)}'),
                                  ],
                                ),
                                Column(
                                  children: [
                                    const Text('TR'),
                                    const SizedBox(height: 5),
                                    Text('${index % 3}'),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
