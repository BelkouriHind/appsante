import 'package:flutter/material.dart';
import 'login.dart';
import 'Espace .dart';

class AccueilPage extends StatelessWidget {
  const AccueilPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Image de fond
          SizedBox.expand(
            child: Image.asset(
              'assets/accueil.png',
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
                  const SizedBox(height: 300),

                  const Text(
                    'Accédez à Votre Espace Santé personnalisé \n en Toute Sécurité.',
                    style: TextStyle(
                      color: Color.fromARGB(255, 23, 71, 90),
                      fontSize: 20,
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

                  const SizedBox(height: 150),
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
        backgroundColor: const Color.fromARGB(255, 23, 71, 90),
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
        backgroundColor: const Color.fromARGB(255, 23, 71, 90),
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
