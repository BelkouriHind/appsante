import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // N'oubliez pas d'importer intl
import 'package:shared_preferences/shared_preferences.dart'; // N'oubliez pas d'importer shared_preferences

class ProfilemedecinPage extends StatefulWidget {
  const ProfilemedecinPage({super.key});

  @override
  State<ProfilemedecinPage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilemedecinPage> {
  String _name = '';
  String _surname = '';
  String _speciality = '';
  String _sex = '';
  DateTime? _dateOfBirth;
  String _phone = '';
  String _email = '';
  String _officeAddress = '';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    // Assurez-vous que la locale 'fr' est disponible pour DateFormat
    // et que vous avez ajouté le package intl à votre pubspec.yaml
    // (par exemple: intl: ^0.18.1)
    Intl.defaultLocale = 'fr'; // Définit la locale par défaut pour l'application
    _loadMedecinData();
  }

  Future<void> _loadMedecinData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _name = prefs.getString('medecin_name') ?? '';
      _surname = prefs.getString('medecin_surname') ?? '';
      _speciality = prefs.getString('medecin_speciality') ?? '';
      _sex = prefs.getString('medecin_sex') ?? '';
      _phone = prefs.getString('medecin_phone') ?? '';
      _email = prefs.getString('medecin_email') ?? '';
      _officeAddress = prefs.getString('medecin_office_address') ?? '';
      final dobString = prefs.getString('medecin_date_of_birth');
      if (dobString != null && dobString.isNotEmpty) {
        _dateOfBirth = DateTime.tryParse(dobString);
      }
      _isLoading = false;
    });
  }

  String _displayValue(String key, String? value) {
    const List<String> showNonRenseigne = [
      'Nom',
      'Prénom',
      'Spécialité',
      'Adresse',
      'Téléphone',
      'Email',
    ];

    if (value == null || value.trim().isEmpty) {
      if (showNonRenseigne.contains(key)) {
        return ''; // Retourne vide pour les champs où 'Non renseigné' ne devrait pas apparaître
      } else {
        return '-'; // Retourne '-' pour les autres champs vides
      }
    }
    return value;
  }

  @override
  Widget build(BuildContext context) {
    final fullName = (_name + ' ' + _surname).trim();
    // Utilisation de la locale 'fr' pour le formatage de la date.
    final formattedDob = _dateOfBirth != null
        ? DateFormat('dd MMM yyyy').format(_dateOfBirth!) // Format plus explicite
        : '';

    final Map<String, Map<String, dynamic>> infos = {
      'Nom': {
        'value': _displayValue('Nom', _name),
        'icon': Icons.person,
      },
      'Prénom': {
        'value': _displayValue('Prénom', _surname),
        'icon': Icons.person_outline,
      },
      'Spécialité': {
        'value': _displayValue('Spécialité', _speciality),
        'icon': Icons.medical_services,
      },
      'Sexe': {
        'value': _sex.isNotEmpty ? _sex : '',
        'icon': Icons.wc,
      },
      'Date naissance': {
        'value': formattedDob,
        'icon': Icons.calendar_today,
      },
      'Téléphone': {
        'value': _displayValue('Téléphone', _phone),
        'icon': Icons.phone,
      },
      'Email': {
        'value': _displayValue('Email', _email),
        'icon': Icons.email,
      },
      'Adresse': {
        'value': _displayValue('Adresse', _officeAddress),
        'icon': Icons.location_on,
      },
    };

    return Scaffold(
      appBar: AppBar(
        title: const Text(' Profil Médecin'),
        backgroundColor: const Color(0xFF22C0B3),
        foregroundColor: Colors.white,
        elevation: 3,
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Color(0xFF22C0B3),
              ),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40, // Taille de l'avatar réduite
                    backgroundColor: Colors.blue.shade50,
                    child: const Icon(
                      Icons.medical_services,
                      size: 50, // Taille de l'icône dans l'avatar réduite
                      color: Color(0xFF22C0B3),
                    ),
                  ),
                  const SizedBox(height: 10), // Espacement réduit
                  if (fullName.isNotEmpty)
                    Text(
                      fullName,
                      style: const TextStyle(
                          fontSize: 20, // Taille de police légèrement réduite
                          fontWeight: FontWeight.bold,
                          color: Colors.black87),
                    ),
                  const SizedBox(height: 20), // Espacement réduit
                  Expanded(
                    child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(), // Pas de défilement pour la grille
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 15, // Espacement réduit entre les cartes
                        mainAxisSpacing: 15, // Espacement réduit entre les cartes
                        // *** CORRECTION FINALE POUR LE DÉBORDEMENT ***
                        // Cette valeur donne plus de hauteur aux cartes pour éviter le débordement.
                        childAspectRatio: 2.0,
                      ),
                      itemCount: infos.length,
                      itemBuilder: (context, index) {
                        final entry = infos.entries.elementAt(index);
                        final label = entry.key;
                        final value = entry.value['value'] as String;
                        final icon = entry.value['icon'] as IconData;

                        return _infoCard(icon, label, value);
                      },
                    ),
                  ),
                  const SizedBox(height: 15), // Espacement réduit
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // TODO : naviguer vers la modification de profil
                        // Exemple de navigation (décommenter et adapter) :
                        // Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfileMedecinPage()));
                      },
                      icon: const Icon(Icons.edit, color: Colors.white, size: 20), // Taille de l'icône réduite
                      label: const Text(
                        "Modifier le profil",
                        style: TextStyle(
                            fontSize: 15, // Taille de police légèrement réduite
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF22C0B3),
                        padding: const EdgeInsets.symmetric(vertical: 12), // Padding vertical réduit
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _infoCard(IconData icon, String label, String value) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10), // Padding réduit dans la carte
        child: Row(
          children: [
            Icon(icon, size: 18, color: const Color(0xFF22C0B3)), // Taille d'icône encore réduite
            const SizedBox(width: 8), // Espacement réduit
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(label,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 11, // Taille de police du libellé réduite
                        color: Colors.black87,
                      )),
                  const SizedBox(height: 1), // Espacement réduit
                  Text(
                    value.isEmpty ? '' : value,
                    style: const TextStyle(fontSize: 10, color: Colors.black54), // Taille de police de la valeur réduite
                    overflow: TextOverflow.ellipsis, // Gère le dépassement de texte avec des points de suspension
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}