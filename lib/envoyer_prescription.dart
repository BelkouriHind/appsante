import 'package:flutter/material.dart';

class PrescriptionPage extends StatefulWidget {
  @override
  _PrescriptionPageState createState() => _PrescriptionPageState();
}

class _PrescriptionPageState extends State<PrescriptionPage> {
  final _formKey = GlobalKey<FormState>();
  final _patientIdController = TextEditingController();
  final _prescriptionController = TextEditingController();

  void _envoyer() {
    if (_formKey.currentState!.validate()) {
      final id = _patientIdController.text;
      final contenu = _prescriptionController.text;
      print("Prescription envoyée à $id : $contenu");

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Prescription envoyée à $id')),
      );

      _patientIdController.clear();
      _prescriptionController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Envoyer une prescription')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _patientIdController,
                decoration: InputDecoration(labelText: 'ID du patient'),
                validator: (value) => value!.isEmpty ? 'Champ obligatoire' : null,
              ),
              TextFormField(
                controller: _prescriptionController,
                decoration: InputDecoration(labelText: 'Contenu de la prescription'),
                maxLines: 5,
                validator: (value) => value!.isEmpty ? 'Champ obligatoire' : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _envoyer,
                child: Text('Envoyer'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
