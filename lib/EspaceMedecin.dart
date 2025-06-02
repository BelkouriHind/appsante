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

  // Données du formulaire
  String? _nom;
  String? _prenom;
  String? _specialite;
  String? _adresse;
  String? _telephone;
  String? _email;
  String? _motPasse;
  Gender? _gender;

  // Liste réduite des spécialités médicales
  final List<String> _specialites = [
    'Cardiologie',
    'Dermatologie',
    'Gynécologie',
    'Médecine générale',
    'Pédiatrie',
    'Psychiatrie',
    'Radiologie',
    'Chirurgie'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              const SizedBox(height: 40),
              // Logo ou image à la place du titre
              
              const SizedBox(height: 24),
            
              const SizedBox(height: 32),
              _buildFormContent(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFormContent() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 3,
            blurRadius: 10,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Informations Personnelles'),
            _buildNameFields(),
            const SizedBox(height: 16),
            _buildGenderField(),
            const SizedBox(height: 16),
            _buildDateOfBirthField(),
            const SizedBox(height: 16),
            _buildAddressField(),
            const SizedBox(height: 16),
            _buildContactFields(),
            const SizedBox(height: 24),
            _buildSectionTitle('Informations Professionnelles'),
            _buildSpecialtyDropdown(),
            const SizedBox(height: 24),
            _buildSectionTitle('Sécurité'),
            _buildPasswordFields(),
            const SizedBox(height: 32),
            _buildSubmitButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.blue[800],
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildNameFields() {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            decoration: InputDecoration(
              labelText: 'Nom *',
              prefixIcon: const Icon(Icons.person),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 12),
            ),
            validator: (value) => value!.isEmpty ? 'Champ obligatoire' : null,
            onSaved: (value) => _nom = value,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: TextFormField(
            decoration: InputDecoration(
              labelText: 'Prénom ',
              prefixIcon: const Icon(Icons.person_outline),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 12),
            ),
            validator: (value) => value!.isEmpty ? 'Champ obligatoire' : null,
            onSaved: (value) => _prenom = value,
          ),
        ),
      ],
    );
  }

  Widget _buildGenderField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Sexe ',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[700],
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: Gender.values.map((gender) {
            return Expanded(
              child: InkWell(
                onTap: () => setState(() => _gender = gender),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: _gender == gender 
                        ? Colors.blue[50] 
                        : Colors.grey[100],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: _gender == gender 
                          ? Theme.of(context).primaryColor 
                          : Colors.transparent,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      _genderToString(gender),
                      style: TextStyle(
                        color: _gender == gender 
                            ? Theme.of(context).primaryColor 
                            : Colors.grey[700],
                        fontWeight: _gender == gender 
                            ? FontWeight.bold 
                            : FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        if (_gender == null)
          Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Text(
              'Veuillez sélectionner votre sexe',
              style: TextStyle(color: const Color.fromARGB(255, 58, 112, 212), fontSize: 12),
            ),
          ),
      ],
    );
  }

  Widget _buildDateOfBirthField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Date de naissance ',
        prefixIcon: const Icon(Icons.calendar_today),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 12),
      ),
      readOnly: true,
      controller: TextEditingController(
        text: _dateOfBirth != null
            ? '${_dateOfBirth!.day}/${_dateOfBirth!.month}/${_dateOfBirth!.year}'
            : '',
      ),
      validator: (value) => _dateOfBirth == null ? 'Champ obligatoire' : null,
      onTap: () async {
        final date = await showDatePicker(
          context: context,
          initialDate: DateTime(1980),
          firstDate: DateTime(1900),
          lastDate: DateTime.now(),
          builder: (context, child) {
            return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: ColorScheme.light(
                  primary: Theme.of(context).primaryColor,
                ),
              ),
              child: child!,
            );
          },
        );
        if (date != null) {
          setState(() => _dateOfBirth = date);
        }
      },
    );
  }

  Widget _buildAddressField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Adresse du cabinet ',
        prefixIcon: const Icon(Icons.location_on),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 16),
      ),
      maxLines: 2,
      validator: (value) => value!.isEmpty ? 'Champ obligatoire' : null,
      onSaved: (value) => _adresse = value,
    );
  }

  Widget _buildContactFields() {
    return Column(
      children: [
        TextFormField(
          decoration: InputDecoration(
            labelText: 'Téléphone ',
            prefixIcon: const Icon(Icons.phone),
            prefixText: '+212 ',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 12),
          ),
          keyboardType: TextInputType.phone,
          validator: (value) {
            if (value!.isEmpty) return 'Champ obligatoire';
            if (!RegExp(r'^[0-9]{9}$').hasMatch(value)) {
              return 'Numéro invalide (9 chiffres)';
            }
            return null;
          },
          onSaved: (value) => _telephone = value,
        ),
        const SizedBox(height: 16),
        TextFormField(
          decoration: InputDecoration(
            labelText: 'Email ',
            prefixIcon: const Icon(Icons.email),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 12),
          ),
          keyboardType: TextInputType.emailAddress,
          validator: (value) {
            if (value!.isEmpty) return 'Champ obligatoire';
            if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                .hasMatch(value)) {
              return 'Email invalide';
            }
            return null;
          },
          onSaved: (value) => _email = value,
        ),
      ],
    );
  }

  Widget _buildSpecialtyDropdown() {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: 'Spécialité médicale ',
        prefixIcon: const Icon(Icons.medical_services),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 0),
      ),
      value: _specialite,
      isExpanded: true,
      icon: const Icon(Icons.arrow_drop_down),
      items: _specialites.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (newValue) => setState(() => _specialite = newValue),
      validator: (value) => value == null ? 'Veuillez sélectionner une spécialité' : null,
    );
  }

  Widget _buildPasswordFields() {
    return TextFormField(
      controller: _passwordController,
      decoration: InputDecoration(
        labelText: 'Mot de passe ',
        prefixIcon: const Icon(Icons.lock),
        hintText: '8 caractères minimum',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 12),
      ),
      obscureText: true,
      validator: (value) {
        if (value!.isEmpty) return 'Champ obligatoire';
        if (value.length < 8) return '8 caractères minimum';
        return null;
      },
      onSaved: (value) => _motPasse = value,
    );
  }

  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
           backgroundColor: const Color(0xFF1976D2), // Bleu professionnel
    foregroundColor: Colors.white, // Couleur du texte
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8), // Coins arrondis
    ),
          elevation: 0,
        ),
        onPressed: _isSubmitting ? null : _submitForm,
        child: _isSubmitting
            ? const CircularProgressIndicator(color: Colors.white)
            : const Text(
                'S\'INSCRIRE',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
      ),
    );
  }

  String _genderToString(Gender gender) {
    switch (gender) {
      case Gender.female:
        return 'Femme';
      case Gender.male:
        return 'Homme';
      
    }
  }

  void _submitForm() async {
    if (_gender == null || _dateOfBirth == null || _specialite == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Veuillez compléter tous les champs obligatoires'),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      );
      return;
    }

    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() => _isSubmitting = true);

      // Simuler une requête réseau
      await Future.delayed(const Duration(seconds: 2));

      final doctorData = {
        'idM': 'MED-${DateTime.now().millisecondsSinceEpoch}',
        'nom': _nom,
        'prenom': _prenom,
        'sexe': _genderToString(_gender!),
        'dateNaissance': _dateOfBirth!.toIso8601String(),
        'specialite': _specialite,
        'adresse': _adresse,
        'telephone': '+212$_telephone',
        'email': _email,
        'motPasse': _motPasse,
        'createdAt': DateTime.now().toIso8601String(),
      };

      debugPrint('Données du médecin: $doctorData');

      if (mounted) {
        setState(() => _isSubmitting = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Inscription réussie!'),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        );
        // Navigator.pop(context); // Retour à l'écran précédent après succès
      }
    }
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }
}