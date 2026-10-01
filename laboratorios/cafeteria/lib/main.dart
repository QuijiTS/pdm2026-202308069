import 'package:flutter/material.dart';

void main() {
  runApp(const MiPedidoApp());
}

// Paleta de colores personalizada (Estética Coffee Shop Oscura)
const kFondo = Color(0xFF1E1814);
const kTarjeta = Color(0xFF2C241D);
const kAcento = Color(0xFFE5A97C);
const kTextoBlanco = Color(0xFFF7F4F2);
const kTextoSecundario = Color(0xFFA69689);

class MiPedidoApp extends StatelessWidget {
  const MiPedidoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mi Pedido',
      theme: ThemeData(
        scaffoldBackgroundColor: kFondo,
        appBarTheme: const AppBarTheme(
          backgroundColor: kFondo,
          elevation: 0,
          centerTitle: true,
          iconTheme: IconThemeData(color: kAcento),
          titleTextStyle: TextStyle(
            color: kAcento,
            fontSize: 22,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
      ),
      home: const PedidoScreen(),
    );
  }
}

class PedidoScreen extends StatefulWidget {
  const PedidoScreen({super.key});

  @override
  State<PedidoScreen> createState() => _PedidoScreenState();
}

class _PedidoScreenState extends State<PedidoScreen> {
  // Cantidades inicializadas en cero
  int _cantCafe = 0;
  int _cantSandwich = 0;
  int _cantJugo = 0;

  // Precios unitarios
  final double _precioCafe = 10.00;
  final double _precioSandwich = 25.00;
  final double _precioJugo = 12.00;

  // Cálculo de la suma de precio * cantidad
  double get _totalPedido {
    return (_cantCafe * _precioCafe) +
           (_cantSandwich * _precioSandwich) +
           (_cantJugo * _precioJugo);
  }

  // Restablece cantidades y total a cero
  void _vaciarPedido() {
    setState(() {
      _cantCafe = 0;
      _cantSandwich = 0;
      _cantJugo = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi pedido'), // Título obligatorio[cite: 1]
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              children: [
                // Filas de productos que reciben datos y acciones[cite: 1]
                ProductoPedido(
                  nombre: 'Café',
                  precioUnitario: _precioCafe,
                  cantidad: _cantCafe,
                  onAdd: () => setState(() => _cantCafe++),
                  onRemove: () => setState(() {
                    if (_cantCafe > 0) _cantCafe--; // Impide valores negativos[cite: 1]
                  }),
                ),
                const SizedBox(height: 16),
                ProductoPedido(
                  nombre: 'Sándwich',
                  precioUnitario: _precioSandwich,
                  cantidad: _cantSandwich,
                  onAdd: () => setState(() => _cantSandwich++),
                  onRemove: () => setState(() {
                    if (_cantSandwich > 0) _cantSandwich--;
                  }),
                ),
                const SizedBox(height: 16),
                ProductoPedido(
                  nombre: 'Jugo',
                  precioUnitario: _precioJugo,
                  cantidad: _cantJugo,
                  onAdd: () => setState(() => _cantJugo++),
                  onRemove: () => setState(() {
                    if (_cantJugo > 0) _cantJugo--;
                  }),
                ),
              ],
            ),
          ),
          // Sección inferior con total y botón[cite: 1, 2]
          Container(
            padding: const EdgeInsets.all(24),
            decoration: const BoxDecoration(
              color: kTarjeta,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total',
                        style: TextStyle(color: kTextoSecundario, fontSize: 18),
                      ),
                      Text(
                        'Q${_totalPedido.toStringAsFixed(2)}', // Formato con dos decimales[cite: 1]
                        style: const TextStyle(
                          color: kTextoBlanco,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: _vaciarPedido,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kAcento,
                        foregroundColor: kFondo,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        'Vaciar pedido', // Botón para reiniciar[cite: 1]
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Widget reutilizable para las filas de los tres productos[cite: 1]
class ProductoPedido extends StatelessWidget {
  final String nombre;
  final double precioUnitario;
  final int cantidad;
  final VoidCallback onAdd;
  final VoidCallback onRemove;

  const ProductoPedido({
    super.key,
    required this.nombre,
    required this.precioUnitario,
    required this.cantidad,
    required this.onAdd,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: kTarjeta,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Nombre y precio[cite: 1]
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                nombre,
                style: const TextStyle(
                  color: kTextoBlanco,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Q${precioUnitario.toStringAsFixed(2)}',
                style: const TextStyle(
                  color: kTextoSecundario,
                  fontSize: 15,
                ),
              ),
            ],
          ),
          // Controles de cantidad alineados[cite: 1, 2]
          Container(
            decoration: BoxDecoration(
              color: kFondo,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                IconButton(
                  onPressed: onRemove,
                  icon: const Icon(Icons.remove, color: kTextoBlanco, size: 20),
                  splashRadius: 20,
                ),
                SizedBox(
                  width: 30,
                  child: Text(
                    cantidad.toString(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: kTextoBlanco,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: onAdd,
                  icon: const Icon(Icons.add, color: kTextoBlanco, size: 20),
                  splashRadius: 20,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}