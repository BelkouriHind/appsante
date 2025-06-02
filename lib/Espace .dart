import 'package:flutter/material.dart';
import 'EspaceMedecin.dart';
import 'EspacePatient.dart';

class ChoixEspacePage extends StatelessWidget {
  const ChoixEspacePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEAF6F6),
      body: SafeArea(
        child: Stack(
          children: [
            // Dégradé en fond
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFEAF6F6), Color(0xFFD1F1F1)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
            Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 80),

                    
                    const SizedBox(height: 40),

                    // Bouton Médecin
                    CustomButton(
                      label: 'Inscription Médecin',
                      icon: Image.asset(
                        'assets/formlogo.png',
                        width: 24,
                        height: 24,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => DoctorForm()),
                        );
                      },
                    ),
                    const SizedBox(height: 20),

                    // Bouton Patient
                    CustomButton(
                      label: 'Inscription Patient',
                      icon: Image.asset(
                        'assets/formlogoPatient.png',
                        width: 24,
                        height: 24,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => PatientInscriptionPage()),
                        );
                      },
                    ),
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

// ✅ Correction ici : icon devient un Widget au lieu de IconData
class CustomButton extends StatelessWidget {
  final String label;
  final Widget icon;
  final VoidCallback onPressed;

  const CustomButton({
    super.key,
    required this.label,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.teal.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
        borderRadius: BorderRadius.circular(10),
      ),
      child: ElevatedButton.icon(
        icon: icon,
        label: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14),
          child: Text(
            label,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
        ),
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF176B87),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
