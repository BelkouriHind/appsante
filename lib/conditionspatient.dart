import 'package:flutter/material.dart';

// --- Page de Confidentialité et Sécurité ---
class PrivacySecurityPage extends StatelessWidget {
  const PrivacySecurityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Confidentialité et Sécurité'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Votre Confidentialité, Notre Priorité',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            const SizedBox(height: 15),
            Text(
              'Chez [Nom de votre Application], nous prenons très au sérieux la protection de vos données personnelles et de santé. Cette section détaille nos engagements et les mesures que nous mettons en œuvre pour garantir la confidentialité et la sécurité de vos informations.',
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 30),

            // --- Section : Collecte des Informations ---
            _buildSectionHeader(context, '1. Collecte des Informations'),
            _buildInfoText(
              context,
              'Nous collectons uniquement les informations nécessaires pour vous fournir nos services et améliorer votre expérience. Cela peut inclure : Nom, Prénom, Date de naissance, Sexe, Poids, Taille, Adresse, Email, Numéro de téléphone, et les données de santé que vous choisissez de partager (ex: historique médical, traitements).',
            ),
            _buildInfoText(
              context,
              'Toutes les données sont collectées avec votre consentement explicite.',
            ),
            const SizedBox(height: 20),

            // --- Section : Utilisation des Informations ---
            _buildSectionHeader(context, '2. Utilisation des Informations'),
            _buildInfoText(
              context,
              'Vos informations sont utilisées pour :',
            ),
            _buildBulletPoint(context, 'Vous fournir et gérer les services de l\'application.'),
            _buildBulletPoint(context, 'Personnaliser votre expérience et afficher des informations pertinentes.'),
            _buildBulletPoint(context, 'Améliorer nos services et développer de nouvelles fonctionnalités.'),
            _buildBulletPoint(context, 'Communiquer avec vous (notifications, rappels de rendez-vous, informations importantes).'),
            _buildBulletPoint(context, 'Assurer la sécurité de l\'application et prévenir la fraude.'),
            _buildInfoText(
              context,
              'Vos données de santé ne sont jamais utilisées à des fins commerciales sans votre consentement formel et spécifique.',
            ),
            const SizedBox(height: 20),

            // --- Section : Partage et Divulgation des Informations ---
            _buildSectionHeader(context, '3. Partage et Divulgation des Informations'),
            _buildInfoText(
              context,
              'Vos données personnelles et de santé ne sont **JAMAIS vendues ou louées à des tiers**.',
            ),
            _buildInfoText(
              context,
              'Elles peuvent être partagées dans les cas suivants, et uniquement si nécessaire :',
            ),
            _buildBulletPoint(context, 'Avec votre consentement explicite, par exemple pour partager des données avec votre professionnel de santé.'),
            _buildBulletPoint(context, 'Avec des partenaires techniques et de service tiers qui nous aident à exploiter l\'application (hébergement de données sécurisé, services d\'analyse), sous des accords de confidentialité stricts.'),
            _buildBulletPoint(context, 'Pour se conformer à une obligation légale ou une ordonnance judiciaire.'),
            const SizedBox(height: 20),

            // --- Section : Sécurité des Données ---
            _buildSectionHeader(context, '4. Sécurité des Données'),
            _buildInfoText(
              context,
              'Nous mettons en œuvre des mesures de sécurité techniques et organisationnelles robustes pour protéger vos données contre l\'accès non autorisé, l\'altération, la divulgation ou la destruction. Cela inclut :',
            ),
            _buildBulletPoint(context, '**Chiffrement des données :** Toutes vos données sont chiffrées (encryptées) à la fois pendant le transfert (via HTTPS/SSL) et au repos (sur les serveurs).'),
            _buildBulletPoint(context, '**Accès Restreint :** L\'accès à vos données est strictement limité au personnel autorisé et uniquement si nécessaire pour les opérations de l\'application.'),
            _buildBulletPoint(context, '**Pare-feu et Systèmes de Détection d\'Intrusion :** Nos serveurs sont protégés par des pare-feu avancés et des systèmes de surveillance en temps réel pour détecter et prévenir les tentatives d\'accès non autorisé.'),
            _buildBulletPoint(context, '**Sauvegardes Régulières :** Des sauvegardes régulières sont effectuées et stockées en toute sécurité pour assurer la résilience des données.'),
            _buildBulletPoint(context, '**Authentification Forte :** Nous utilisons des protocoles d\'authentification sécurisés pour l\'accès à l\'application.'),
            _buildBulletPoint(context, '**Tests de Sécurité :** Des audits de sécurité réguliers et des tests d\'intrusion sont menés pour identifier et corriger les vulnérabilités.'),
            const SizedBox(height: 20),

            // --- Section : Vos Droits ---
            _buildSectionHeader(context, '5. Vos Droits'),
            _buildInfoText(
              context,
              'Conformément aux réglementations en vigueur, vous disposez des droits suivants concernant vos données :',
            ),
            _buildBulletPoint(context, '**Droit d\'accès :** Vous pouvez demander une copie des données que nous détenons sur vous.'),
            _buildBulletPoint(context, '**Droit de rectification :** Vous pouvez demander la correction de vos données si elles sont inexactes ou incomplètes.'),
            _buildBulletPoint(context, '**Droit à l\'effacement :** Vous pouvez demander la suppression de vos données (droit à l\'oubli).'),
            _buildBulletPoint(context, '**Droit à la limitation du traitement :** Vous pouvez demander la limitation du traitement de vos données dans certaines circonstances.'),
            _buildBulletPoint(context, '**Droit à la portabilité des données :** Vous pouvez recevoir vos données dans un format structuré et transmissible.'),
            _buildBulletPoint(context, '**Droit d\'opposition :** Vous pouvez vous opposer au traitement de vos données pour certaines raisons.'),
            _buildInfoText(
              context,
              'Pour exercer ces droits, veuillez nous contacter à [Votre Email de Contact] ou via la section "Support" de l\'application.',
            ),
            const SizedBox(height: 20),

            // --- Section : Modifications de cette Politique ---
            _buildSectionHeader(context, '6. Modifications de cette Politique'),
            _buildInfoText(
              context,
              'Nous nous réservons le droit de modifier cette politique de confidentialité et de sécurité à tout moment. Toute modification significative sera portée à votre connaissance via l\'application ou par email.',
            ),
            const SizedBox(height: 20),

            // --- Section : Contact ---
            _buildSectionHeader(context, '7. Contact'),
            _buildInfoText(
              context,
              'Pour toute question concernant notre politique de confidentialité et de sécurité, n\'hésitez pas à nous contacter :',
            ),
            _buildInfoText(context, 'Email : [Votre Email de Support]'),
            _buildInfoText(context, 'Adresse : [Votre Adresse (optionnel)]'),
            const SizedBox(height: 30),

            const Text(
              'Dernière mise à jour : 04 juin 2025', // N'oubliez pas de mettre à jour cette date !
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- Widgets utilitaires pour un affichage propre ---

  // En-tête de section
  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.bold,
          color: Colors.blue.shade800,
        ),
      ),
    );
  }

  // Texte d'information général
  Widget _buildInfoText(BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodyMedium,
        textAlign: TextAlign.justify,
      ),
    );
  }

  // Puces de liste
  Widget _buildBulletPoint(BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, bottom: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('• ', style: TextStyle(fontSize: 16, color: Colors.black87)),
          Expanded(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.justify,
            ),
          ),
        ],
      ),
    );
  }
}