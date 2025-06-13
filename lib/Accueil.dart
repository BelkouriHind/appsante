import 'package:flutter/material.dart';
import 'login.dart';
import 'Espace .dart';

class AccueilPage extends StatelessWidget {
  const AccueilPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
  final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          // Image de fond
         Container(
  height: screenHeight , // ou 600 si tu veux tester fixe
   width: screenWidth,
  child: Image.asset(
    'assets/Accueil.png',
    fit: BoxFit.cover,
    
  ),
),

          // Filtre doux (gris clair neutre)
          

          // Contenu principal
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 100),
                   Image.asset(
          'assets/logosante.png',
          height: 80, // tu peux ajuster la taille
          fit: BoxFit.contain,
        ),
         const SizedBox(height: 30),

                  const Text(
                    'Bienvenue sur une application\n  conçue pour simplifier votre suivi santé',
                    style: TextStyle(
                      color: Color.fromARGB(255, 17, 163, 83),
                      fontSize: 18,
                      fontFamily: 'circularstd',
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const Spacer(),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      PrimaryButton(
                        label: 'Se connecter',
                        icon: Icons.login,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const LoginPage()),
                          );
                        },
                      ),
                      const SizedBox(height: 15),
                      OutlinedButtonStyled(
                        label: 'S\'inscrire',
                        icon: Icons.person_add,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const ChoixEspacePage()),
                          );
                        },
                      ),
                    ],
                  ),

                  const SizedBox(height: 200),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Bouton principal avec icône
class PrimaryButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onPressed;

  const PrimaryButton({
    super.key,
    required this.label,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 22, color: Colors.white),
      label: Text(
        label,
        style: const TextStyle(fontSize: 16),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Color.fromARGB(255, 17, 163, 83),
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 2,
      ),
    );
  }
}

// Bouton secondaire avec icône
class OutlinedButtonStyled extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onPressed;

  const OutlinedButtonStyled({
    super.key,
    required this.label,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 22, color: Colors.white),
      label: Text(
        label,
        style: const TextStyle(fontSize: 16),
      ),
      style: OutlinedButton.styleFrom(
        backgroundColor:  Color.fromARGB(255, 17, 163, 83),
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
