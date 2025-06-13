import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class HomeMedecin extends StatefulWidget {
  @override
  _HomeMedecinState createState() => _HomeMedecinState();
}

class _HomeMedecinState extends State<HomeMedecin> {
  File? _profileImage;
  final picker = ImagePicker();

  Future<void> _getImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color(0xFFF2F4F6),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              // Profil
              Center(
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    GestureDetector(
                      onTap: _getImageFromGallery,
                      child: CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.white,
                        backgroundImage:
                            _profileImage != null ? FileImage(_profileImage!) : null,
                        child: _profileImage == null
                            ? Icon(Icons.camera_alt,
                                size: 28, color: Color(0xFF10BAC0))
                            : null,
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      'Dr. Nom Complet',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    Text(
                      'Spécialité médicale',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),

              // Informations professionnelles
              Align(
                alignment: Alignment.centerLeft,
               
              ),
              SizedBox(height: 12),
             Column(
  crossAxisAlignment: CrossAxisAlignment.stretch,
  children: [
    _buildInfoCard('Adresse cabinet', '', Icons.location_on),
    SizedBox(height: 12),
    _buildInfoCard('Téléphone', '', Icons.phone),
    SizedBox(height: 12),
    _buildInfoCard('Email', '', Icons.email),
  ],
),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard(String title, String value, IconData icon) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.08),
            blurRadius: 8,
            offset: Offset(0, 2),
          )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 28, color: Color(0xFF10BAC0)),
          SizedBox(height: 10),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 13, color: Colors.grey[700]),
          ),
          SizedBox(height: 5),
          Text(
            value,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
