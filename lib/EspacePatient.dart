import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
 // For date formatting

// Removed PatientInscriptionPage as it's not strictly necessary for the main app entry
// and MaterialApp should be at the root.
// Instead, we'll put MaterialApp directly in main().



class PatientInscriptionPage extends StatelessWidget {
  const PatientInscriptionPage({super.key}); // Add const constructor

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Inscription Patient',
      debugShowCheckedModeBanner: false, // <-- REMOVED DEBUG BANNER
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blueAccent,
          foregroundColor: Colors.white,
          elevation: 4.0,
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.grey[100],
          contentPadding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
          hintStyle: TextStyle(color: Colors.grey[600]),
          labelStyle: const TextStyle(color: Colors.blueAccent),
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(color: Colors.grey[300]!),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(color: Colors.blueAccent, width: 2.0),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(color: Colors.red, width: 1.0),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(color: Colors.red, width: 2.0),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueAccent,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            elevation: 5.0,
          ),
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: PatientRegistrationScreen(),
    );
  }
}

class PatientRegistrationScreen extends StatefulWidget {
  const PatientRegistrationScreen({super.key}); // Add const constructor

  @override
  _PatientRegistrationScreenState createState() => _PatientRegistrationScreenState();
}

class _PatientRegistrationScreenState extends State<PatientRegistrationScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();

  String? _selectedSex;
  DateTime? _selectedDateOfBirth;

  // Add a focus node to dismiss the keyboard when tapping outside text fields
  final FocusNode _nameFocus = FocusNode();
  final FocusNode _surnameFocus = FocusNode();
  final FocusNode _addressFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _phoneFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _confirmPasswordFocus = FocusNode();
  final FocusNode _weightFocus = FocusNode();
  final FocusNode _heightFocus = FocusNode();


  @override
  void dispose() {
    _nameController.dispose();
    _surnameController.dispose();
    _addressController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _weightController.dispose();
    _heightController.dispose();

    // Dispose focus nodes
    _nameFocus.dispose();
    _surnameFocus.dispose();
    _addressFocus.dispose();
    _emailFocus.dispose();
    _phoneFocus.dispose();
    _passwordFocus.dispose();
    _confirmPasswordFocus.dispose();
    _weightFocus.dispose();
    _heightFocus.dispose();

    super.dispose();
  }

  Future<void> _selectDateOfBirth(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDateOfBirth ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.blueAccent,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.blueAccent,
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDateOfBirth) {
      setState(() {
        _selectedDateOfBirth = picked;
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Inscription en cours...', style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.blueAccent,
          duration: Duration(seconds: 2),
        ),
      );

      print('Nom: ${_nameController.text}');
      print('Prénom: ${_surnameController.text}');
      print('Sexe: $_selectedSex');
      print('Adresse: ${_addressController.text}');
      print('Email: ${_emailController.text}');
      print('Date de Naissance: ${_selectedDateOfBirth != null ? DateFormat('dd/MM/yyyy').format(_selectedDateOfBirth!) : 'Non sélectionnée'}');
      print('Poids: ${_weightController.text} kg');
      print('Taille: ${_heightController.text} cm');
      print('Téléphone: ${_phoneController.text}');
      print('Mot de Passe: ${_passwordController.text}');

      // Navigate or clear form
      _formKey.currentState!.reset(); // Clears text fields
      setState(() {
        _selectedSex = null;
        _selectedDateOfBirth = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // This allows you to tap anywhere outside a text field to dismiss the keyboard.
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Inscription Patient'),
          centerTitle: true,
        ),
        // Using a ListView instead of SingleChildScrollView for fixed height items
        // but ensuring no scrolling if content fits the screen.
        // If content is too long for the screen, ListView will provide scrolling.
        body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
            return SingleChildScrollView( // Kept SingleChildScrollView to ensure all fields are accessible on smaller screens
              padding: const EdgeInsets.all(20.0),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: viewportConstraints.maxHeight, // Ensure content fills height
                ),
                child: IntrinsicHeight( // Adjusts height of children to fit
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        TextFormField(
                          controller: _nameController,
                          focusNode: _nameFocus,
                          decoration: const InputDecoration(
                            labelText: 'Nom',
                            hintText: 'Entrez votre nom',
                            prefixIcon: Icon(Icons.person),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Veuillez entrer votre nom';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16), // Reduced spacing slightly for more fields

                        TextFormField(
                          controller: _surnameController,
                          focusNode: _surnameFocus,
                          decoration: const InputDecoration(
                            labelText: 'Prénom',
                            hintText: 'Entrez votre prénom',
                            prefixIcon: Icon(Icons.person_outline),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Veuillez entrer votre prénom';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),

                        DropdownButtonFormField<String>(
                          value: _selectedSex,
                          decoration: const InputDecoration(
                            labelText: 'Sexe',
                            hintText: 'Sélectionnez votre sexe',
                            prefixIcon: Icon(Icons.wc),
                          ),
                          items: <String>['Homme', 'Femme'] // Added "Autre" option back
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedSex = newValue;
                            });
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Veuillez sélectionner votre sexe';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),

                        GestureDetector(
                          onTap: () => _selectDateOfBirth(context),
                          child: AbsorbPointer(
                            child: TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Date de Naissance',
                                hintText: _selectedDateOfBirth == null
                                    ? 'Sélectionnez votre date de naissance'
                                    : DateFormat('dd/MM/yyyy').format(_selectedDateOfBirth!),
                                prefixIcon: const Icon(Icons.calendar_today),
                                suffixIcon: const Icon(Icons.arrow_drop_down),
                              ),
                              validator: (value) {
                                if (_selectedDateOfBirth == null) {
                                  return 'Veuillez sélectionner votre date de naissance';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),

                        TextFormField(
                          controller: _weightController,
                          focusNode: _weightFocus,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'Poids (kg)',
                            hintText: 'Entrez votre poids en kg',
                            prefixIcon: Icon(Icons.line_weight),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Veuillez entrer votre poids';
                            }
                            if (double.tryParse(value) == null || double.parse(value) <= 0) {
                              return 'Veuillez entrer un poids valide';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),

                        TextFormField(
                          controller: _heightController,
                          focusNode: _heightFocus,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'Taille (cm)',
                            hintText: 'Entrez votre taille en cm',
                            prefixIcon: Icon(Icons.height),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Veuillez entrer votre taille';
                            }
                            if (double.tryParse(value) == null || double.parse(value) <= 0) {
                              return 'Veuillez entrer une taille valide';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),

                        TextFormField(
                          controller: _addressController,
                          focusNode: _addressFocus,
                          decoration: const InputDecoration(
                            labelText: 'Adresse',
                            hintText: 'Entrez votre adresse complète',
                            prefixIcon: Icon(Icons.home),
                          ),
                          maxLines: 2,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Veuillez entrer votre adresse';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),

                        TextFormField(
                          controller: _emailController,
                          focusNode: _emailFocus,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            labelText: 'Email',
                            hintText: 'exemple@domaine.com',
                            prefixIcon: Icon(Icons.email),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Veuillez entrer votre email';
                            }
                            if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                              return 'Veuillez entrer un email valide';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),

                        TextFormField(
                          controller: _phoneController,
                          focusNode: _phoneFocus,
                          keyboardType: TextInputType.phone,
                          decoration: const InputDecoration(
                            labelText: 'Téléphone',
                            hintText: 'Ex: 0612345678',
                            prefixIcon: Icon(Icons.phone),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Veuillez entrer votre numéro de téléphone';
                            }
                            if (!RegExp(r'^\+?[0-9]{8,15}$').hasMatch(value)) {
                              return 'Veuillez entrer un numéro de téléphone valide';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),

                        TextFormField(
                          controller: _passwordController,
                          focusNode: _passwordFocus,
                          obscureText: true,
                          decoration: const InputDecoration(
                            labelText: 'Mot de Passe',
                            hintText: 'Créez un mot de passe sécurisé',
                            prefixIcon: Icon(Icons.lock),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Veuillez entrer un mot de passe';
                            }
                            if (value.length < 6) {
                              return 'Le mot de passe doit contenir au moins 6 caractères';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),

                        TextFormField(
                          controller: _confirmPasswordController,
                          focusNode: _confirmPasswordFocus,
                          obscureText: true,
                          decoration: const InputDecoration(
                            labelText: 'Confirmer le Mot de Passe',
                            hintText: 'Retapez votre mot de passe',
                            prefixIcon: Icon(Icons.lock_outline),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Veuillez confirmer votre mot de passe';
                            }
                            if (value != _passwordController.text) {
                              return 'Les mots de passe ne correspondent pas';
                            }
                            return null;
                          },
                        ),
                        // Using Spacer to push the button to the bottom if there's extra space
                        const Spacer(), 
                        const SizedBox(height: 20), // Spacing before the button

                        Center(
                          child: ElevatedButton(
                            onPressed: _submitForm,
                            child: const Text('S\'inscrire'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}