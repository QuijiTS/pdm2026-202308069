import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// Constantes de colores (Tema Oscuro original)
const kFondo = Color.fromARGB(255, 17, 12, 18);
const kSuperficie = Color.fromARGB(255, 27, 20, 30);
const kBorde = Color.fromARGB(255, 48, 34, 50);
const kTexto = Color.fromARGB(255, 242, 234, 244);
const kMuted = Color.fromARGB(255, 148, 128, 156);
const kLima = Color.fromARGB(255, 170, 78, 245); // --color-accent (Morado/Púrpura)
const kIconoFondo = Color.fromARGB(255, 55, 28, 73); 

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CitusCheck',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: kFondo,
        colorScheme: ColorScheme.fromSeed(seedColor: kLima, brightness: Brightness.dark),
      ),
      home: const CitusCheckHome(),
    );
  }
}

class CitusCheckHome extends StatelessWidget {
  const CitusCheckHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 1. Barra Superior (Header)
      appBar: AppBar(
        backgroundColor: kSuperficie,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: kTexto),
          onPressed: () {},
        ),
        title: const Text(
          'CitusCheck',
          style: TextStyle(color: kTexto, fontWeight: FontWeight.w600),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Icon(Icons.cloud_done, color: Colors.greenAccent), // Indicador Online
          )
        ],
      ),
      
      // 2. Cuerpo Central
      body: Column(
        children: [
          // Área de Escáner (Cámara)
          Container(
            margin: const EdgeInsets.all(16),
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              color: kSuperficie,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: kBorde, width: 2),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Ícono que simula las esquinas de escaneo
                const Icon(Icons.qr_code_scanner, size: 80, color: kMuted),
                const SizedBox(height: 16),
                Text(
                  'Apunta aquí para escanear',
                  style: TextStyle(color: kTexto.withOpacity(0.8), fontSize: 16),
                ),
              ],
            ),
          ),
          
          // Área de Botones de Productos (Grilla)
          Expanded(
            child: GridView.count(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1.1, // Ajuste de la proporción de las tarjetas
              children: [
                productCard('Coca-Cola 3L', '(Q15.00)', Icons.local_drink),
                productCard('Caja de Leche', '(Q10.00)', Icons.inventory_2),
                productCard('Frijol 1lb', '(Q8.00)', Icons.shopping_bag),
                productCard('Papel de Baño', '(Q25.00)', Icons.layers),
                // Puedes agregar más productos aquí fácilmente
              ],
            ),
          ),
        ],
      ),
      
      // 3. Barra Inferior (Footer de Ventas y Pendientes)
      bottomNavigationBar: Container(
        height: 70,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        decoration: const BoxDecoration(
          color: kLima, // Se usa el color primario como fondo inferior tal cual tu boceto
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              'Ventas Hoy: 42',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            Icon(Icons.hourglass_bottom, color: Colors.white, size: 30),
          ],
        ),
      ),
    );
  }

  // Widget reutilizable para los botones de productos
  Widget productCard(String name, String price, IconData icon) {
    return Container(
      decoration: BoxDecoration(
        color: kIconoFondo, // Fondo sutil para que resalte
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: kBorde),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {}, // Acción simulada del botón
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                name,
                style: const TextStyle(color: kTexto, fontSize: 15, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                price,
                style: const TextStyle(color: kMuted, fontSize: 13),
              ),
              const SizedBox(height: 12),
              Icon(icon, color: kLima, size: 36), // Ícono representativo del producto
            ],
          ),
        ),
      ),
    );
  }
}