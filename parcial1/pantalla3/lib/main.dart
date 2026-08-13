import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// Colores
const kFondo = Color(0xFFF2F4F7);
const kTarjeta = Colors.white;
const kTextoPrincipal = Color(0xFF1D1D1D);
const kTextoSecundario = Color(0xFF757575);
const kIconoColor = Color(0xFF424242);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Profile App',
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: kFondo,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.black,
          brightness: Brightness.light,
        ),
      ),
      home: const ProfileScreen(),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 20),
          children: [
            const Center(
              child: Text(
                'Profile',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: kTextoPrincipal,
                ),
              ),
            ),
            const SizedBox(height: 30),

            Center(
              child: Stack(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 4),
                    ),
                    child: const Icon(
                      Icons.person,
                      size: 60,
                      color: Colors.grey,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.edit_outlined,
                        size: 20,
                        color: kTextoPrincipal,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            customCard(
              title: 'Personal info',
              showEdit: true,
              children: [
                infoRow(Icons.person_outline, 'Name', 'Terry Melton'),
                infoRow(Icons.mail_outline, 'E-mail', 'melton89@gmail.com'),
                infoRow(Icons.phone_outlined, 'Phone number', '+1 201 555-0123'),
                infoRow(Icons.home_outlined, 'Home address', '70 Rainey Street, Apartment 146, Austin TX 78701',),
              ],
            ),

            customCard(
              title: 'Account info',
              showEdit: false,
              children: [
                const SizedBox(height: 40),
              ],
            ),
          ],
        ),
      ),
      
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: 4, // "Profile" seleccionado
          selectedItemColor: kTextoPrincipal,
          unselectedItemColor: Colors.grey,
          backgroundColor: Colors.white,
          showUnselectedLabels: true,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          unselectedLabelStyle: const TextStyle(fontSize: 12),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.map_outlined), label: 'Map'),
            BottomNavigationBarItem(icon: Icon(Icons.swap_horiz_outlined), label: 'Transfer'),
            BottomNavigationBarItem(icon: Icon(Icons.settings_outlined), label: 'Settings'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
        ),
      ),
    );
  }
}
  
// Plantilla Contenedores
Widget customCard({
  required String title,
  required bool showEdit,
  required List<Widget> children,
}) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    padding: const EdgeInsets.all(24),
    decoration: BoxDecoration(
      color: kTarjeta,
      borderRadius: BorderRadius.circular(24),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: kTextoPrincipal,
              ),
            ),
            if (showEdit)
              const Text(
                'Edit',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: kTextoPrincipal,
                ),
              ),
          ],
        ),
        const SizedBox(height: 16),
        ...children,
      ],
    ),
  );
}

/// Plantilla ícono, título y subtítulo
Widget infoRow(IconData icon, String label, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 12.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: kIconoColor, size: 24),
        const SizedBox(width: 16),
        Expanded( 
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  color: kTextoSecundario,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  color: kTextoPrincipal,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}