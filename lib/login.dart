import 'package:flutter/material.dart';
import 'DashbordPatient.dart';
import 'DashbordMedecin.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String _selectedRole = 'patient';
  bool _obscureText = true;
  String? _passwordError;

  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  void _login() {
    final login = _loginController.text.trim();
    final password = _passwordController.text.trim();

    setState(() {
      _passwordError = password.length < 8 ? 'Mot de passe trop court (min 8 caractères)' : null;
    });

    if (login.isEmpty || password.isEmpty || _passwordError != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Veuillez remplir tous les champs correctement.'),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    if (_selectedRole == 'patient') {
      Navigator.pushNamed(context, '/dashboard_patient');
    } else if (_selectedRole == 'medecin') {
      Navigator.pushNamed(context, '/dashboard_medecin');
    }
  }

  @override
  void dispose() {
    _loginController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final inputDecoration = InputDecoration(
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.teal, width: 2),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.teal[50],
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: Colors.teal,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.local_hospital, size: 64, color: Colors.white),
              ),
              const SizedBox(height: 20),
              
              const SizedBox(height: 50),

              // Champ Login
              TextField(
                controller: _loginController,
                keyboardType: TextInputType.emailAddress,
                decoration: inputDecoration.copyWith(
                  labelText: 'Login',
                  prefixIcon: const Icon(Icons.person, color: Colors.teal),
                ),
              ),
              const SizedBox(height: 20),

              // Champ Mot de passe avec affichage/masquage
              TextField(
                controller: _passwordController,
                obscureText: _obscureText,
                onChanged: (value) {
                  setState(() {
                    _passwordError = value.length < 8 ? 'Mot de passe trop court (min 8 caractères)' : null;
                  });
                },
                decoration: inputDecoration.copyWith(
                  labelText: 'Mot de passe',
                  prefixIcon: const Icon(Icons.lock, color: Colors.teal),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off,
                      color: Colors.teal,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  ),
                  errorText: _passwordError,
                ),
              ),
              const SizedBox(height: 20),

              // Dropdown rôle
              DropdownButtonFormField<String>(
                value: _selectedRole,
                decoration: inputDecoration.copyWith(
                  labelText: 'Rôle',
                  prefixIcon: const Icon(Icons.account_circle, color: Colors.teal),
                ),
                items: const [
                  DropdownMenuItem(value: 'patient', child: Text('Patient')),
                  DropdownMenuItem(value: 'medecin', child: Text('Médecin')),
                ],
                onChanged: (value) {
                  setState(() {
                    _selectedRole = value!;
                  });
                },
              ),
              const SizedBox(height: 30),

              // Bouton Se connecter
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                 icon: const Icon(
      Icons.login,
      color: Colors.white, // corrigé ici
    ),
                  label: const Text(
                    'Se connecter',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white,),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 4,
                  ),
                  onPressed: _login,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
