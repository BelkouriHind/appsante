import 'package:flutter/material.dart';

class languePage extends StatefulWidget {
  @override
  _SymbolPageState createState() => _SymbolPageState();
}

class _SymbolPageState extends State<languePage> {
  int _selectedIndex = 0;

  // ✅ Aucune langue sélectionnée par défaut
  String? _selectedLanguage;

  final Map<String, String> languages = {
    'Arabe': '🇲🇦',
    'Française': '🇫🇷',
    'Anglaise': '🇺🇸',
    'Allemande': '🇩🇪',
  };

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // ✅ Fond blanc

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text('Langage', style: TextStyle(color: Colors.black)),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: PopupMenuButton<String>(
              icon: const Icon(Icons.more_horiz, color: Colors.black, size: 35),
              onSelected: (value) {
                // Gère la sélection ici si besoin
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                const PopupMenuItem<String>(value: 'profile', child: Text('Profile')),
                const PopupMenuItem<String>(value: 'products', child: Text('My Products')),
                const PopupMenuItem<String>(value: 'items', child: Text('Items')),
                const PopupMenuItem<String>(value: 'signout', child: Text('Sign out')),
              ],
            ),
          ),
        ],
      ),

      body: SingleChildScrollView(
        child: Center(
          child: Container(
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.grey[100], // ✅ Fond gris clair
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color.fromARGB(255, 238, 236, 236)), // ✅ Bordure grise
            ),
            child: Column(
              children: [
                ...languages.entries.map((entry) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Row(
                      children: [
                        Text(entry.value, style: const TextStyle(fontSize: 24)),
                        const SizedBox(width: 10),
                        Text(entry.key, style: const TextStyle(fontSize: 18)),
                        const Spacer(),
                        Radio<String>(
                          value: entry.key,
                          groupValue: _selectedLanguage,
                          activeColor: Colors.grey, // ✅ Couleur sélection grise
                          onChanged: (String? value) {
                            setState(() {
                              _selectedLanguage = value;
                            });
                          },
                        ),
                      ],
                    ),
                  );
                }).toList(),

                const SizedBox(height: 30),

                ElevatedButton(
                  onPressed: () {
                    if (_selectedLanguage != null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Langue sélectionnée : $_selectedLanguage')),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Veuillez sélectionner une langue.')),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF18B4BC), // ✅ Couleur #18B4BC
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: const Text(
                    'UPDATE',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

      
    );
  }
}
