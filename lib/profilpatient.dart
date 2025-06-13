import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String _name = '';
  String _surname = '';
  String _selectedSex = '';
  DateTime? _selectedDateOfBirth;
  String _weight = '';
  String _height = '';
  String _address = '';
  String _email = '';
  String _phone = '';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadPatientData();
  }

  Future<void> _loadPatientData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _name = prefs.getString('patient_name') ?? '';
      _surname = prefs.getString('patient_surname') ?? '';
      _selectedSex = prefs.getString('patient_sex') ?? '';
      _address = prefs.getString('patient_address') ?? '';
      _email = prefs.getString('patient_email') ?? '';
      _phone = prefs.getString('patient_phone') ?? '';
      _weight = prefs.getString('patient_weight') ?? '';
      _height = prefs.getString('patient_height') ?? '';
      final dobString = prefs.getString('patient_dob');
      if (dobString != null && dobString.isNotEmpty) {
        _selectedDateOfBirth = DateTime.tryParse(dobString);
      }
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final fullName = (_name + ' ' + _surname).trim().isEmpty
        ? ''
        : (_name + ' ' + _surname).trim();
    final birthDate = _selectedDateOfBirth != null
        ? DateFormat('dd/MM/yyyy').format(_selectedDateOfBirth!)
        : '';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mon Profil'),
        backgroundColor: const Color.fromARGB(255, 34, 192, 179),
        foregroundColor: Colors.white,
        elevation: 2,
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Color.fromARGB(255, 34, 192, 179),
              ),
            )
          : Center(
              child: Container(
                padding: const EdgeInsets.all(16),
                constraints: const BoxConstraints(maxWidth: 500),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 30), // Espace après AppBar
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.blue.shade100,
                      child: const Icon(
                        Icons.person,
                        size: 60,
                        color:const Color.fromARGB(255, 34, 192, 179),
                      ),
                    ),
                    const SizedBox(height: 24), // Espace après l’avatar
                    _buildInfo(Icons.person, 'Nom Complet', fullName),
                    _buildInfo(Icons.wc, 'Sexe', _selectedSex.isNotEmpty ? _selectedSex : ''),
                    _buildInfo(Icons.calendar_today, 'Date de Naissance', birthDate),
                    _buildInfo(Icons.line_weight, 'Poids', _weight.isNotEmpty ? '$_weight kg' : ''),
                    _buildInfo(Icons.height, 'Taille', _height.isNotEmpty ? '$_height cm' : ''),
                    _buildInfo(Icons.email, 'Email', _email.isNotEmpty ? _email : ''),
                    const SizedBox(height: 24), // Espace avant le bouton
                    ElevatedButton(
                      onPressed: () {
                        // Naviguer vers la page de modification
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 34, 192, 179),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: const Text('Modifier le Profil'),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildInfo(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          Icon(icon, size: 20, color: const Color.fromARGB(255, 34, 192, 179)),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              '$label : $value',
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
