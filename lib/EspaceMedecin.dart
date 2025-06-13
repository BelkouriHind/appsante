import 'package:flutter/material.dart';

enum Gender { female, male }

class DoctorForm extends StatefulWidget {
  const DoctorForm({super.key});

  @override
  State<DoctorForm> createState() => _DoctorRegistrationFormState();
}

class _DoctorRegistrationFormState extends State<DoctorForm> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  bool _isSubmitting = false;
  DateTime? _dateOfBirth;

  String? _nom, _prenom, _specialite, _adresse, _telephone, _email, _motPasse;
  Gender? _gender;

  final List<String> _specialites = [
    'Cardiologie', 'Dermatologie', 'Gynécologie', 'Médecine générale',
    'Pédiatrie', 'Psychiatrie', 'Radiologie', 'Chirurgie'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
       appBar: AppBar(
        title: const Text('Inscription Medecin'),
        backgroundColor: Colors.teal,
        centerTitle: true,
        foregroundColor: Colors.white,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 500),
                child: _buildFormContent(),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildFormContent() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          
          const SizedBox(height: 12),

          _buildNameFields(),
          const SizedBox(height: 12),

          _buildGenderField(),
          const SizedBox(height: 12),

          _buildDateOfBirthField(),
          const SizedBox(height: 12),

          _buildContactFields(),
          const SizedBox(height: 12),

          _buildSpecialtyDropdown(),
          const SizedBox(height: 12),

          _buildAddressField(),
          const SizedBox(height: 12),

          _buildPasswordFields(),
          const SizedBox(height: 24),

          _buildSubmitButton(),
        ],
      ),
    );
  }

 

  Widget _buildNameFields() => Row(
        children: [
          Expanded(
            child: _buildTextField('Nom ', Icons.person, (value) => _nom = value),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: _buildTextField('Prénom', Icons.person_outline, (v) => _prenom = v),
          ),
        ],
      );

  Widget _buildTextField(String label, IconData icon, Function(String?) onSave) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
      ),
      validator: (v) => (v == null || v.isEmpty) ? 'Obligatoire' : null,
      onSaved: onSave,
    );
  }

  Widget _buildGenderField() => Row(
        children: Gender.values.map((g) {
          return Expanded(
            child: RadioListTile<Gender>(
              dense: true,
              value: g,
              groupValue: _gender,
              onChanged: (val) => setState(() => _gender = val),
              title: Text(_genderToString(g), style: const TextStyle(fontSize: 14)),
              contentPadding: EdgeInsets.zero,
              // Pour que les radios prennent moins de place verticale
            ),
          );
        }).toList(),
      );

  Widget _buildDateOfBirthField() {
    return TextFormField(
      readOnly: true,
      controller: TextEditingController(
        text: _dateOfBirth == null
            ? ''
            : '${_dateOfBirth!.day}/${_dateOfBirth!.month}/${_dateOfBirth!.year}',
      ),
      onTap: () async {
        final date = await showDatePicker(
          context: context,
          initialDate: DateTime(1980),
          firstDate: DateTime(1900),
          lastDate: DateTime.now(),
        );
        if (date != null) setState(() => _dateOfBirth = date);
      },
      decoration: InputDecoration(
        labelText: 'Date de naissance',
        prefixIcon: const Icon(Icons.calendar_today),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
      ),
      validator: (_) => _dateOfBirth == null ? 'Obligatoire' : null,
    );
  }

  Widget _buildContactFields() => Column(
        children: [
          _buildTextField('Téléphone', Icons.phone, (v) => _telephone = v),
          const SizedBox(height: 12),
          _buildTextField('Email', Icons.email, (v) => _email = v),
        ],
      );

  Widget _buildSpecialtyDropdown() {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: 'Spécialité',
        prefixIcon: const Icon(Icons.medical_services),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
      ),
      items: _specialites
          .map((s) => DropdownMenuItem(value: s, child: Text(s)))
          .toList(),
      onChanged: (v) => setState(() => _specialite = v),
      validator: (v) => v == null ? 'Choix requis' : null,
    );
  }

  Widget _buildAddressField() => TextFormField(
        maxLines: 2,
        decoration: InputDecoration(
          labelText: 'Adresse du cabinet',
          prefixIcon: const Icon(Icons.location_on),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
        ),
        validator: (v) => (v == null || v.isEmpty) ? 'Obligatoire' : null,
        onSaved: (v) => _adresse = v,
      );

  Widget _buildPasswordFields() => TextFormField(
        controller: _passwordController,
        obscureText: true,
        decoration: InputDecoration(
          labelText: 'Mot de passe',
          prefixIcon: const Icon(Icons.lock),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
        ),
        validator: (v) => (v != null && v.length < 8) ? 'Min 8 caractères' : null,
        onSaved: (v) => _motPasse = v,
      );

  Widget _buildSubmitButton() => SizedBox(
        width: double.infinity,
        height: 44,
        child: ElevatedButton(
          onPressed: _isSubmitting ? null : _submitForm,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.teal,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: _isSubmitting
              ? const CircularProgressIndicator(color: Colors.white)
              : const Text('S\'INSCRIRE'),
        ),
      );

  String _genderToString(Gender g) => g == Gender.female ? 'Femme' : 'Homme';

  void _submitForm() async {
    if (!_formKey.currentState!.validate() ||
        _gender == null ||
        _dateOfBirth == null ||
        _specialite == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Veuillez compléter tous les champs.')),
      );
      return;
    }

    _formKey.currentState!.save();
    setState(() => _isSubmitting = true);
    await Future.delayed(const Duration(seconds: 2));

    debugPrint('Formulaire soumis');
    setState(() => _isSubmitting = false);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Inscription réussie!')),
    );
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }
}
