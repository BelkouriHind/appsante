import 'package:flutter/material.dart';

class MedicalFormPage extends StatefulWidget {
   const MedicalFormPage({Key? key}) : super(key: key);
  @override

  _MedicalFormPageState createState() => _MedicalFormPageState();
}

class _MedicalFormPageState extends State<MedicalFormPage> {
  // Données existantes
  final List<String> _commonAllergies = [
    'Pollen', 'Acariens', 'Arachides', 'Crustacés',
    'Lactose', 'Pénicilline', 'Latex'
  ];
  
  final List<String> _commonMedications = [
    'Paracétamol', 'Ibuprofène', 'Amoxicilline',
    'Insuline', 'Métoprolol', 'Atorvastatine'
  ];

  // Variables d'état
  String? _bloodGroup;
  String? _diet;
  String? _tobaccoUse;
  String? _alcoholUse;
  List<String> _selectedAllergies = [];
  List<String> _selectedMedications = [];
  String? _newAllergy;
  String? _newMedication;

  final List<String> _bloodGroups = ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'];
  final List<String> _diets = ['Omnivore', 'Végétarien', 'Végétalien', 'Sans gluten', 'Autre'];
  final List<String> _habits = ['Jamais', 'Occasionnel', 'Régulier', 'Ancien'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Dossier Médical', 
               style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.blue),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Informations médicales'),
            
            // Groupe sanguin
            _buildDropdownFormField(
              label: 'Groupe sanguin',
              value: _bloodGroup,
              items: _bloodGroups,
              onChanged: (value) => setState(() => _bloodGroup = value),
            ),
            
            // Régime alimentaire
            _buildDropdownFormField(
              label: 'Régime alimentaire',
              value: _diet,
              items: _diets,
              onChanged: (value) => setState(() => _diet = value),
            ),
            
            // Consommation de tabac
            _buildDropdownFormField(
              label: 'Consommation de tabac',
              value: _tobaccoUse,
              items: _habits,
              onChanged: (value) => setState(() => _tobaccoUse = value),
            ),
            
            // Consommation d'alcool
            _buildDropdownFormField(
              label: 'Consommation d\'alcool',
              value: _alcoholUse,
              items: _habits,
              onChanged: (value) => setState(() => _alcoholUse = value),
            ),
            
            SizedBox(height: 30),
            _buildSectionTitle('Allergies'),
            
            // Liste des allergies communes
            _buildItemSelectionList(
              label: 'Sélectionnez vos allergies',
              items: _commonAllergies,
              selectedItems: _selectedAllergies,
              onAdd: (item) => setState(() => _selectedAllergies.add(item)),
            ),
            // Champ pour ajouter une allergie personnalisée
            _buildCustomItemField(
              label: 'Ajouter une allergie personnalisée',
              hintText: 'Entrez une nouvelle allergie',
              value: _newAllergy,
              onChanged: (value) => _newAllergy = value,
              onAdd: () {
                if (_newAllergy != null && _newAllergy!.isNotEmpty) {
                  setState(() {
                    _selectedAllergies.add(_newAllergy!);
                    _newAllergy = null;
                  });
                }
              },
            ),
            
            // Liste des allergies sélectionnées
            if (_selectedAllergies.isNotEmpty) ...[
              SizedBox(height: 16),
              _buildSelectedItemsList(
                title: 'Mes allergies',
                items: _selectedAllergies,
                onRemove: (item) => setState(() => _selectedAllergies.remove(item)),
              ),
            
            ],
            
            SizedBox(height: 30),
            _buildSectionTitle('Médicaments'),
            
            // Liste des médicaments communs
            _buildItemSelectionList(
              label: 'Sélectionnez vos médicaments',
              items: _commonMedications,
              selectedItems: _selectedMedications,
              onAdd: (item) => setState(() => _selectedMedications.add(item)),
            ),
            
            // Champ pour ajouter un médicament personnalisé
            _buildCustomItemField(
              label: 'Ajouter un médicament personnalisé',
              hintText: 'Entrez un nouveau médicament',
              value: _newMedication,
              onChanged: (value) => _newMedication = value,
              onAdd: () {
                if (_newMedication != null && _newMedication!.isNotEmpty) {
                  setState(() {
                    _selectedMedications.add(_newMedication!);
                    _newMedication = null;
                  });
                }
              },
            ),
            
            // Liste des médicaments sélectionnés
            if (_selectedMedications.isNotEmpty) ...[
              SizedBox(height: 16),
              _buildSelectedItemsList(
                title: 'Mes médicaments',
                items: _selectedMedications,
                onRemove: (item) => setState(() => _selectedMedications.remove(item)),
              ),
            ],
            
            SizedBox(height: 40),
            // Bouton de soumission
            Center(
              child: ElevatedButton(
                onPressed: _submitForm,
                child: Text('Enregistrer', style: TextStyle(fontSize: 18)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _buildDropdownFormField({
    required String label,
    required String? value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(fontWeight: FontWeight.w500)),
          SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                isExpanded: true,
                value: value,
                hint: Text('Sélectionnez'),
                items: items.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: onChanged,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItemSelectionList({
    required String label,
    required List<String> items,
    required List<String> selectedItems,
    required Function(String) onAdd,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontWeight: FontWeight.w500)),
        SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: items.map((item) {
            final isSelected = selectedItems.contains(item);
            return FilterChip(
              label: Text(item),
              selected: isSelected,
              onSelected: (selected) {
                if (selected) {
                  onAdd(item);
                } else {
                  setState(() => selectedItems.remove(item));
                }
              },
              selectedColor: Colors.blue[100],
              checkmarkColor: Colors.blue,
              labelStyle: TextStyle(
                color: isSelected ? Colors.blue : Colors.black87,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildCustomItemField({
    required String label,
    required String hintText,
    required String? value,
    required Function(String) onChanged,
    required Function() onAdd,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 16),
        Text(label, style: TextStyle(fontWeight: FontWeight.w500)),
        SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: hintText,
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                ),
                onChanged: onChanged,
                controller: value != null 
                    ? TextEditingController(text: value)
                    : null,
              ),
            ),
            SizedBox(width: 8),
            IconButton(
              icon: Icon(Icons.add_circle, color: Colors.blue, size: 36),
              onPressed: onAdd,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSelectedItemsList({
    required String title,
    required List<String> items,
    required Function(String) onRemove,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: items.map((item) => Chip(
            label: Text(item),
            backgroundColor: Colors.blue[50],
            deleteIcon: Icon(Icons.close, size: 18),
            onDeleted: () => onRemove(item),
          )).toList(),
        ),
      ],
    );
  }

  void _submitForm() {
    // Implémentez la logique de sauvegarde ici
    final formData = {
      'bloodGroup': _bloodGroup,
      'diet': _diet,
      'tobaccoUse': _tobaccoUse,
      'alcoholUse': _alcoholUse,
      'allergies': _selectedAllergies,
      'medications': _selectedMedications,
    };
    
    print('Données enregistrées: $formData');
    
    // Afficher un message de succès
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Dossier médical mis à jour avec succès'),
        backgroundColor: Colors.green,
      ),
    );
  }
}