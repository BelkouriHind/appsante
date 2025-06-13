import 'package:flutter/material.dart';

class FormMedicalSimple extends StatelessWidget {
  const FormMedicalSimple({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulaire Médical'),
        backgroundColor: const Color.fromARGB(255, 15, 167, 146),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _fieldLabel('Groupe sanguin'),
            _fieldValue('B+'),
            const SizedBox(height: 15),

            _fieldLabel('Régime alimentaire'),
            _fieldValue('Sans gluten'),
            const SizedBox(height: 15),

            _fieldLabel('Tabac'),
            _fieldValue('Occasionnel'),
            const SizedBox(height: 15),

            _fieldLabel('Alcool'),
            _fieldValue('Jamais'),
            const SizedBox(height: 15),

            _fieldLabel('Allergies'),
            _fieldValue('Pollen, Poissons'),
            const SizedBox(height: 15),

            _fieldLabel('Médicaments'),
            _fieldValue('Paracétamol, Aspirine'),
          ],
        ),
      ),
    );
  }

  Widget _fieldLabel(String label) {
    return Text(
      label,
      style: const TextStyle(
          fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black87),
    );
  }

  Widget _fieldValue(String value) {
    return Text(
      value,
      style: const TextStyle(fontSize: 16, color: Colors.black54),
    );
  }
}
