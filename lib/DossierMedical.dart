import 'package:flutter/material.dart';

class MedicalFormPage extends StatefulWidget {
  const MedicalFormPage({Key? key}) : super(key: key);

  @override
  _MedicalFormPageState createState() => _MedicalFormPageState();
}

class _MedicalFormPageState extends State<MedicalFormPage> {
  final List<String> _bloodGroups = ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'];
  final List<String> _diets = ['Omnivore', 'Végétarien', 'Végétalien', 'Sans gluten', 'Autre'];
  final List<String> _habits = ['Jamais', 'Occasionnel', 'Régulier', 'Ancien'];
  final List<String> _commonAllergies = ['Pollen', 'Arachides', 'Lactose', 'Latex'];
  final List<String> _commonMedications = ['Paracétamol', 'Ibuprofène', 'Insuline'];

  String? _bloodGroup, _diet, _tobaccoUse, _alcoholUse;
  List<String> _selectedAllergies = [], _selectedMedications = [];
  final TextEditingController _newAllergyController = TextEditingController();
  final TextEditingController _newMedicationController = TextEditingController();

  @override
  void dispose() {
    _newAllergyController.dispose();
    _newMedicationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  _smallDropdown(
                    label: 'Groupe sanguin',
                    value: _bloodGroup,
                    items: _bloodGroups,
                    onChanged: (v) => setState(() => _bloodGroup = v),
                  ),
                  _smallDropdown(
                    label: 'Régime alimentaire',
                    value: _diet,
                    items: _diets,
                    onChanged: (v) => setState(() => _diet = v),
                  ),
                  _smallDropdown(
                    label: 'Tabac',
                    value: _tobaccoUse,
                    items: _habits,
                    onChanged: (v) => setState(() => _tobaccoUse = v),
                  ),
                  _smallDropdown(
                    label: 'Alcool',
                    value: _alcoholUse,
                    items: _habits,
                    onChanged: (v) => setState(() => _alcoholUse = v),
                  ),
                  ExpansionTile(
                    title: const Text('Allergies', style: TextStyle(fontSize: 14)),
                    childrenPadding: const EdgeInsets.symmetric(horizontal: 8),
                    children: [
                      _smallDropdown(
                        label: 'Ajouter une allergie',
                        value: null,
                        items: _commonAllergies.where((a) => !_selectedAllergies.contains(a)).toList(),
                        onChanged: (v) {
                          if (v != null && !_selectedAllergies.contains(v)) {
                            setState(() => _selectedAllergies.add(v));
                          }
                        },
                      ),
                      _inputWithAddButton(
                        label: 'Autre allergie',
                        controller: _newAllergyController,
                        onAdd: () {
                          final text = _newAllergyController.text.trim();
                          if (text.isNotEmpty && !_selectedAllergies.contains(text)) {
                            setState(() {
                              _selectedAllergies.add(text);
                              _newAllergyController.clear();
                            });
                          }
                        },
                      ),
                      Wrap(
                        spacing: 6,
                        children: _selectedAllergies
                            .map((e) => Chip(
                                  label: Text(e, style: const TextStyle(fontSize: 12)),
                                  deleteIcon: const Icon(Icons.close, size: 16),
                                  onDeleted: () => setState(() => _selectedAllergies.remove(e)),
                                ))
                            .toList(),
                      ),
                    ],
                  ),
                  ExpansionTile(
                    title: const Text('Médicaments', style: TextStyle(fontSize: 14)),
                    childrenPadding: const EdgeInsets.symmetric(horizontal: 8),
                    children: [
                      _smallDropdown(
                        label: 'Ajouter un médicament',
                        value: null,
                        items: _commonMedications.where((m) => !_selectedMedications.contains(m)).toList(),
                        onChanged: (v) {
                          if (v != null && !_selectedMedications.contains(v)) {
                            setState(() => _selectedMedications.add(v));
                          }
                        },
                      ),
                      _inputWithAddButton(
                        label: 'Autre médicament',
                        controller: _newMedicationController,
                        onAdd: () {
                          final text = _newMedicationController.text.trim();
                          if (text.isNotEmpty && !_selectedMedications.contains(text)) {
                            setState(() {
                              _selectedMedications.add(text);
                              _newMedicationController.clear();
                            });
                          }
                        },
                      ),
                      Wrap(
                        spacing: 6,
                        children: _selectedMedications
                            .map((e) => Chip(
                                  label: Text(e, style: const TextStyle(fontSize: 12)),
                                  deleteIcon: const Icon(Icons.close, size: 16),
                                  onDeleted: () => setState(() => _selectedMedications.remove(e)),
                                ))
                            .toList(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text('Enregistrer', style: TextStyle(fontSize: 16,color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _smallDropdown({
    required String label,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 13)),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(6),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                isExpanded: true,
                value: value,
                icon: const Icon(Icons.arrow_drop_down),
                hint: const Text('Choisir', style: TextStyle(fontSize: 13)),
                style: const TextStyle(fontSize: 13, color: Colors.black87),
                items: items
                    .map((e) => DropdownMenuItem<String>(
                          value: e,
                          child: Text(e, style: const TextStyle(fontSize: 13)),
                        ))
                    .toList(),
                onChanged: onChanged,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _inputWithAddButton({
    required String label,
    required TextEditingController controller,
    required VoidCallback onAdd,
  }) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 6),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              style: const TextStyle(fontSize: 13),
              decoration: InputDecoration(
                labelText: label,
                labelStyle: const TextStyle(fontSize: 13),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
                contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.add_circle, color: Colors.teal, size: 28),
            onPressed: onAdd,
          ),
        ],
      ),
    );
  }

void _submitForm() {
  final data = {
    'bloodGroup': _bloodGroup,
    'diet': _diet,
    'tobaccoUse': _tobaccoUse,
    'alcoholUse': _alcoholUse,
    'allergies': _selectedAllergies,
    'medications': _selectedMedications,
  };
  print("Formulaire soumis : $data");

  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text("Dossier médical enregistré avec succès"),
      backgroundColor: Colors.green,
    ),
  );
}
}