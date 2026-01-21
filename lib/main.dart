import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const WOMIGO());
}

class WOMIGO extends StatelessWidget {
  const WOMIGO({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'WOMIGO',
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorSchemeSeed: Colors.pinkAccent,
        // Using Google Fonts with a white default for readability
        textTheme: GoogleFonts.poppinsTextTheme(
          ThemeData.dark().textTheme.apply(bodyColor: Colors.white, displayColor: Colors.white),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}

/// =======================================================
///                     SPLASH SCREEN
/// =======================================================

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2))
          ..forward();

    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const HomeScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xfff857a6), Color(0xff8a2387), Color(0xff2c003e)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: FadeTransition(
            opacity: controller,
            child: const Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.shield_rounded, size: 90, color: Colors.white),
                SizedBox(height: 20),
                Text("WOMIGO",
                    style: TextStyle(
                        fontSize: 42,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 2)),
                SizedBox(height: 10),
                Text("Safety Before Speed",
                    style: TextStyle(color: Colors.white70, fontSize: 18)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// =======================================================
///                        HOME
/// =======================================================

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Widget navCard(BuildContext ctx, String title, IconData icon, Widget page) {
    return GestureDetector(
      onTap: () => Navigator.push(ctx, MaterialPageRoute(builder: (_) => page)),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(26),
          gradient: const LinearGradient(
            colors: [Color(0xfffd5da8), Color(0xff7f00ff)],
          ),
          boxShadow: const [
            BoxShadow(color: Colors.black45, blurRadius: 10, offset: Offset(0, 4))
          ],
        ),
        child: Row(
          children: [
            Icon(icon, size: 36, color: Colors.white),
            const SizedBox(width: 20),
            Text(title,
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.white)),
            const Spacer(),
            const Icon(Icons.arrow_forward_ios, size: 18, color: Colors.white70),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      appBar: AppBar(
        title: const Text("WOMIGO Dashboard",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            const SizedBox(height: 10),
            navCard(context, "Safe Navigation", Icons.map_rounded,
                const SafeInputScreen()),
            navCard(context, "AI Risk Prediction", Icons.psychology_rounded,
                const AIRiskScreen()),
            navCard(context, "Local Companion", Icons.group_add_rounded,
                const CompanionScreen()),
            navCard(context, "Nearby Help", Icons.location_on_rounded,
                const NearbyHelpScreen()),
            const SizedBox(height: 10),
            // Special SOS Button
            GestureDetector(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SOSScreen())),
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.redAccent.shade700,
                  borderRadius: BorderRadius.circular(26),
                  boxShadow: const [BoxShadow(color: Colors.redAccent, blurRadius: 8)],
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.warning_amber_rounded, color: Colors.white, size: 30),
                    SizedBox(width: 15),
                    Text("EMERGENCY SOS", 
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// =======================================================
///           SAFE NAVIGATION — INPUT SCREEN
/// =======================================================

class SafeInputScreen extends StatelessWidget {
  const SafeInputScreen({super.key});

  InputDecoration inputStyle(String label, IconData icon) {
    return InputDecoration(
      prefixIcon: Icon(icon, color: Colors.pinkAccent),
      labelText: label,
      labelStyle: const TextStyle(color: Colors.white), // Bright White Label
      filled: true,
      fillColor: Colors.white.withOpacity(0.05),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Colors.white24),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Colors.pinkAccent, width: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      appBar: AppBar(title: const Text("Plan Safe Route")),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            TextField(
              style: const TextStyle(color: Colors.white),
              decoration: inputStyle("Starting Location", Icons.my_location),
            ),
            const SizedBox(height: 20),
            TextField(
              style: const TextStyle(color: Colors.white),
              decoration: inputStyle("Destination", Icons.location_on),
            ),
            const SizedBox(height: 40),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pinkAccent,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              ),
              icon: const Icon(Icons.map_rounded),
              label: const Text("Find Safe Route", style: TextStyle(fontSize: 18)),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const SafeMapScreen()));
              },
            )
          ],
        ),
      ),
    );
  }
}

/// =======================================================
///                SAFE NAVIGATION — MAP
/// =======================================================

class SafeMapScreen extends StatelessWidget {
  const SafeMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Live Safe Map")),
      body: Column(
        children: [
          Expanded(
            child: FlutterMap(
              options: const MapOptions(
                initialCenter: LatLng(9.9312, 76.2673),
                initialZoom: 13,
              ),
              children: [
                TileLayer(urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png"),
                PolylineLayer(
                  polylines: [
                    Polyline(
                      points: [const LatLng(9.9312, 76.2673), const LatLng(9.945, 76.285)],
                      strokeWidth: 8,
                      color: Colors.greenAccent,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: Color(0xFF252545),
              borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
            ),
            child: const Column(
              children: [
                Text("Safety Score: 82 / 100",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.greenAccent)),
                SizedBox(height: 8),
                Text("Well-lit • Police nearby • High visibility",
                    style: TextStyle(fontSize: 16, color: Colors.white)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// =======================================================
///                AI RISK PREDICTION
/// =======================================================

class AIRiskScreen extends StatelessWidget {
  const AIRiskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      appBar: AppBar(title: const Text("AI Risk Prediction")),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            TextField(
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: "Enter Area Name",
                labelStyle: const TextStyle(color: Colors.white),
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: const BorderSide(color: Colors.pinkAccent)),
              ),
            ),
            const SizedBox(height: 30),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.pinkAccent.withOpacity(0.5)),
              ),
              child: const Column(
                children: [
                  Text("Risk Analysis", style: TextStyle(fontSize: 18, color: Colors.white70)),
                  SizedBox(height: 10),
                  Text("42%", style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.orangeAccent)),
                  Text("Medium Risk", style: TextStyle(fontSize: 20, color: Colors.white)),
                  SizedBox(height: 10),
                  Text("Avoid isolated streets after 10 PM. AI detected low lighting in this sector.",
                      textAlign: TextAlign.center, style: TextStyle(color: Colors.white70)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// =======================================================
///                 LOCAL COMPANION
/// =======================================================

class CompanionScreen extends StatelessWidget {
  const CompanionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Verified Companions")),
      body: ListView(
        padding: const EdgeInsets.all(15),
        children: [
          _buildCompanionTile("Ananya", "Female", "0.6 km", "4.9", Colors.pinkAccent),
          _buildCompanionTile("Rahul", "Male", "0.8 km", "4.7", Colors.blueAccent),
        ],
      ),
    );
  }

  Widget _buildCompanionTile(String name, String gender, String dist, String rate, Color col) {
    return Card(
      color: Colors.white.withOpacity(0.05),
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(backgroundColor: col, child: Text(name[0], style: const TextStyle(color: Colors.white))),
        title: Text("$name • $gender", style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        subtitle: Text("$dist • ⭐ $rate", style: const TextStyle(color: Colors.white70)),
        trailing: const Icon(Icons.verified, color: Colors.greenAccent),
      ),
    );
  }
}

/// =======================================================
///                  NEARBY HELP
/// =======================================================

class NearbyHelpScreen extends StatelessWidget {
  const NearbyHelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Emergency Support")),
      body: ListView(
        padding: const EdgeInsets.all(15),
        children: [
          _buildHelpTile("Police Station", "1.2 km away", Icons.local_police),
          _buildHelpTile("City Hospital", "0.9 km away", Icons.local_hospital),
        ],
      ),
    );
  }

  Widget _buildHelpTile(String title, String dist, IconData icon) {
    return Card(
      color: Colors.white.withOpacity(0.05),
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Icon(icon, color: Colors.pinkAccent, size: 30),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        subtitle: Text(dist, style: const TextStyle(color: Colors.white70)),
        trailing: const CircleAvatar(backgroundColor: Colors.green, child: Icon(Icons.call, color: Colors.white)),
      ),
    );
  }
}

/// =======================================================
///                       SOS
/// =======================================================

class SOSScreen extends StatelessWidget {
  const SOSScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      appBar: AppBar(title: const Text("Emergency SOS")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: const EdgeInsets.all(70),
                shape: const CircleBorder(),
                elevation: 20,
                shadowColor: Colors.redAccent,
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    backgroundColor: const Color(0xFF2C003E),
                    title: const Text("SOS Activated", style: TextStyle(color: Colors.white)),
                    content: const Text("Emergency contacts notified.\nLive location shared with Police.",
                        style: TextStyle(color: Colors.white70)),
                    actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text("OK"))],
                  ),
                );
              },
              child: const Text("SOS", style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.white)),
            ),
            const SizedBox(height: 50),
            const Text("Press and hold for 3 seconds", style: TextStyle(color: Colors.white70)),
          ],
        ),
      ),
    );
  }
}