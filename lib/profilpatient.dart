import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // N'oublie pas d'importer intl
import 'package:shared_preferences/shared_preferences.dart'; // Importe SharedPreferences

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key}); // Le constructeur n'a plus besoin des données directement

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // Déclare les variables d'état pour stocker les informations du patient
  // Initialisées à des valeurs par défaut pour éviter les erreurs de null safety
  String _name = '';
  String _surname = '';
  String _selectedSex = 'Non spécifié';
  DateTime? _selectedDateOfBirth;
  String _weight = '';
  String _height = '';
  String _address = '';
  String _email = '';
  String _phone = '';

  bool _isLoading = true; // Pour afficher un indicateur de chargement

  @override
  void initState() {
    super.initState();
    _loadPatientData(); // Appelle la fonction de chargement au démarrage de la page
  }

  // --- Fonction Clé : Charger les données du patient depuis SharedPreferences ---
  Future<void> _loadPatientData() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      // Récupère chaque information en utilisant la même clé que lors de la sauvegarde
      // Utilise ?? '' ou ?? 'N/A' pour fournir une valeur par défaut si la clé n'existe pas
      setState(() {
        _name = prefs.getString('patient_name') ?? 'N/A';
        _surname = prefs.getString('patient_surname') ?? 'N/A';
        _selectedSex = prefs.getString('patient_sex') ?? 'Non spécifié';
        _address = prefs.getString('patient_address') ?? 'N/A';
        _email = prefs.getString('patient_email') ?? 'N/A';
        _phone = prefs.getString('patient_phone') ?? 'N/A';
        _weight = prefs.getString('patient_weight') ?? 'N/A';
        _height = prefs.getString('patient_height') ?? 'N/A';

        // Pour la date de naissance, récupère la chaîne et convertit-la en DateTime
        final dobString = prefs.getString('patient_dob');
        if (dobString != null && dobString.isNotEmpty) {
          _selectedDateOfBirth = DateTime.tryParse(dobString);
        } else {
          _selectedDateOfBirth = null; // S'assurer qu'elle est null si vide/non définie
        }
        _isLoading = false; // Le chargement est terminé
      });
    } catch (e) {
      // Gérer les erreurs de chargement (ex: SharedPreferences non initialisé)
      print('Erreur lors du chargement des données du patient: $e');
      setState(() {
        _isLoading = false; // Arrêter le chargement même en cas d'erreur
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mon Profil'),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      body: _isLoading // Afficher un indicateur de chargement si les données ne sont pas prêtes
          ? const Center(child: CircularProgressIndicator(color: Colors.blueAccent))
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.blue.shade100,
                      child: const Icon(Icons.person, size: 80, color: Colors.blueAccent),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // --- Affichage des informations ---
                  _buildProfileInfoRow(Icons.person, 'Nom Complet', '$_name $_surname'),
                  _buildProfileInfoRow(Icons.wc, 'Sexe', _selectedSex),
                  _buildProfileInfoRow(
                    Icons.calendar_today,
                    'Date de Naissance',
                    _selectedDateOfBirth != null
                        ? DateFormat('dd/MM/yyyy').format(_selectedDateOfBirth!)
                        : 'Non spécifiée',
                  ),
                  _buildProfileInfoRow(Icons.line_weight, 'Poids', '$_weight kg'),
                  _buildProfileInfoRow(Icons.height, 'Taille', '$_height cm'),
                  _buildProfileInfoRow(Icons.home, 'Adresse', _address),
                  _buildProfileInfoRow(Icons.email, 'Email', _email),
                  _buildProfileInfoRow(Icons.phone, 'Téléphone', _phone),

                  const SizedBox(height: 30),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        print('Modifier le profil');
                        // Ici, tu pourrais naviguer vers une page d'édition de profil
                        // et lui passer les données actuelles pour pré-remplir les champs.
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: const Text('Modifier le Profil'),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  // Widget helper pour construire une ligne d'information de profil (inchangé)
  Widget _buildProfileInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 24, color: Colors.blueAccent),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}