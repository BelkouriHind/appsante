import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PatientInscriptionPage extends StatelessWidget {
  const PatientInscriptionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const PatientRegistrationScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class PatientRegistrationScreen extends StatefulWidget {
  const PatientRegistrationScreen({super.key});

  @override
  State<PatientRegistrationScreen> createState() => _PatientRegistrationScreenState();
}

class _PatientRegistrationScreenState extends State<PatientRegistrationScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nomController = TextEditingController();
  final _prenomController = TextEditingController();
  final _emailController = TextEditingController();
  final _telController = TextEditingController();
  final _poidsController = TextEditingController();
  final _tailleController = TextEditingController();
  final _passwordController = TextEditingController();

  DateTime? _dateNaissance;
  String? _sexe;
  bool _obscure = true;

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _dateNaissance = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Inscription Patient'),
        backgroundColor: Colors.teal,
        centerTitle: true,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // 1ère ligne : Nom et Prénom
              Row(
                children: [
                  Expanded(child: _buildField(_nomController, "Nom", Icons.person)),
                  const SizedBox(width: 10),
                  Expanded(child: _buildField(_prenomController, "Prénom", Icons.person_outline)),
                ],
              ),

              const SizedBox(height: 10),

              // 2e ligne : Email et Téléphone
              Row(
                children: [
                  Expanded(child: _buildField(_emailController, "Email", Icons.email)),
                  const SizedBox(width: 10),
                  Expanded(child: _buildField(_telController, "Téléphone", Icons.phone)),
                ],
              ),

              const SizedBox(height: 10),

              // 3e ligne : Poids et Taille
              Row(
                children: [
                  Expanded(child: _buildField(_poidsController, "Poids (kg)", Icons.fitness_center)),
                  const SizedBox(width: 10),
                  Expanded(child: _buildField(_tailleController, "Taille (cm)", Icons.height)),
                ],
              ),

              const SizedBox(height: 10),

              // 4e ligne : Sexe et Date de naissance
              Row(
                children: [
                  Expanded(child: _buildDropdownSexe()),
                  const SizedBox(width: 10),
                  Expanded(child: _buildDateField()),
                ],
              ),

              const SizedBox(height: 10),

              // 5e ligne : Mot de passe
              _buildPassword(),

              const SizedBox(height: 20),

              // Bouton
            SizedBox(
  width: double.infinity,
  child: ElevatedButton(
    onPressed: () {
      if (_formKey.currentState!.validate()) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Inscription réussie")),
        );
      }
    },
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.teal,
      foregroundColor: Colors.white, // texte en blanc
      padding: const EdgeInsets.symmetric(vertical: 14),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
    child: const Text("S'inscrire"),
  ),
),

            ],
          ),
        ),
      ),
    );
  }

  Widget _buildField(TextEditingController controller, String label, IconData icon) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.teal),
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
      ),
      validator: (value) => value == null || value.isEmpty ? 'Obligatoire' : null,
    );
  }

  Widget _buildDropdownSexe() {
    return DropdownButtonFormField<String>(
      value: _sexe,
      decoration: InputDecoration(
        labelText: 'Sexe',
        prefixIcon: const Icon(Icons.wc, color: Colors.teal),
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
      ),
      items: const ['Homme', 'Femme'].map((e) {
        return DropdownMenuItem(value: e, child: Text(e));
      }).toList(),
      onChanged: (val) => setState(() => _sexe = val),
      validator: (value) => value == null ? 'Choisir un sexe' : null,
    );
  }

  Widget _buildDateField() {
    return GestureDetector(
      onTap: _pickDate,
      child: AbsorbPointer(
        child: TextFormField(
          decoration: InputDecoration(
            labelText: "Naissance",
            hintText: _dateNaissance == null
                ? 'Sélectionner une date'
                : DateFormat('dd/MM/yyyy').format(_dateNaissance!),
            prefixIcon: const Icon(Icons.calendar_today, color: Colors.teal),
            filled: true,
            fillColor: Colors.grey[100],
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
          ),
          validator: (_) => _dateNaissance == null ? 'Date requise' : null,
        ),
      ),
    );
  }

  Widget _buildPassword() {
    return TextFormField(
      controller: _passwordController,
      obscureText: _obscure,
      decoration: InputDecoration(
        labelText: 'Mot de passe',
        prefixIcon: const Icon(Icons.lock, color: Colors.teal),
        suffixIcon: IconButton(
          icon: Icon(_obscure ? Icons.visibility : Icons.visibility_off),
          onPressed: () => setState(() => _obscure = !_obscure),
        ),
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
      ),
      validator: (val) =>
          val == null || val.length < 6 ? 'Minimum 6 caractères' : null,
    );
  }
}
