import 'package:flutter/material.dart';

void main() {
  runApp(const MarcadorApp());
}

class MarcadorApp extends StatelessWidget {
  const MarcadorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Marcador Deportivo',
      // Tema
      theme: ThemeData(
        brightness: Brightness.dark, 
        scaffoldBackgroundColor: const Color(0xFF171717),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          titleTextStyle: TextStyle(
            color: Colors.amber,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: const MarcadorScreen(),
    );
  }
}

class MarcadorScreen extends StatefulWidget {
  const MarcadorScreen({super.key});

  @override
  State<MarcadorScreen> createState() => _MarcadorScreenState();
}

class _MarcadorScreenState extends State<MarcadorScreen> {
  int puntosEquipoA = 0;
  int puntosEquipoB = 0;
  String nombreA = "Equipo A";
  String nombreB = "Equipo B";

  void incrementar(String equipo) {
    setState(() {
      if (equipo == 'A') puntosEquipoA++;
      if (equipo == 'B') puntosEquipoB++;
    });
  }

  void decrementar(String equipo) {
    setState(() {
      if (equipo == 'A' && puntosEquipoA > 0) puntosEquipoA--;
      if (equipo == 'B' && puntosEquipoB > 0) puntosEquipoB--;
    });
  }

  void reiniciar() {
    setState(() {
      puntosEquipoA = 0;
      puntosEquipoB = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    String mensaje = "Empate";
    
    // Tema 
    Color colorEquipoA = Colors.grey.shade800;
    Color colorEquipoB = Colors.grey.shade800;

    // Verde equipo Ganador
    if (puntosEquipoA > puntosEquipoB) {
      mensaje = "Va ganando $nombreA";
      colorEquipoA = Colors.green.shade700; 
    } else if (puntosEquipoB > puntosEquipoA) {
      mensaje = "Va ganando $nombreB";
      colorEquipoB = Colors.green.shade700;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Marcador'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            mensaje,
            style: const TextStyle(
              fontSize: 28, 
              fontWeight: FontWeight.bold,
              color: Colors.white, // Blanco para contraste
            ),
          ),
          const SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _construirTarjetaEquipo('Equipo A', puntosEquipoA, colorEquipoA, 'A'),
              _construirTarjetaEquipo('Equipo B', puntosEquipoB, colorEquipoB, 'B'),
            ],
          ),
          const SizedBox(height: 60),
          ElevatedButton.icon(
            onPressed: reiniciar,
            icon: const Icon(Icons.refresh, color: Colors.black),
            label: const Text(
              'Reiniciar', 
              style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold)
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.amber, // Botón en acento dorado
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            ),
          ),
        ],
      ),
    );
  }

  Widget _construirTarjetaEquipo(String nombre, int puntos, Color colorFondo, String idEquipo) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colorFondo,
        borderRadius: BorderRadius.circular(15),
        // Agregamos un sutil borde dorado para mantener la temática
        border: Border.all(color: Colors.amber.withOpacity(0.5), width: 2), 
      ),
      child: Column(
        children: [
          Text(
            nombre, 
            style: const TextStyle(
              fontSize: 24, 
              fontWeight: FontWeight.bold, 
              color: Colors.amber // Nombres en dorado
            )
          ),
          const SizedBox(height: 10),
          Text(
            '$puntos', 
            style: const TextStyle(
              fontSize: 60, 
              fontWeight: FontWeight.bold, 
              color: Colors.white // Puntos en blanco puro
            )
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              IconButton(
                onPressed: () => decrementar(idEquipo),
                icon: const Icon(Icons.remove_circle_outline, size: 45, color: Colors.white70),
              ),
              const SizedBox(width: 10),
              IconButton(
                onPressed: () => incrementar(idEquipo),
                icon: const Icon(Icons.add_circle, size: 45, color: Colors.amber),
              ),
            ],
          )
        ],
      ),
    );
  }
}