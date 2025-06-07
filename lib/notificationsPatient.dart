import 'package:flutter/material.dart';

// --- Page de Notifications ---
class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        centerTitle: true,
        // Optionnel : un bouton d'action pour "tout marquer comme lu"
        actions: [
          IconButton(
            icon: const Icon(Icons.mark_email_read_outlined),
            tooltip: 'Marquer tout comme lu',
            onPressed: () {
              // Logique pour marquer toutes les notifications comme lues
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Toutes les notifications sont marquées comme lues')),
              );
              // Dans une vraie application, vous mettiez à jour un état ou appeliez une API ici.
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        children: const [
          // Exemple de notifications
          NotificationItem(
            title: 'Rendez-vous confirmé',
            subtitle: 'Votre rendez-vous avec le Dr. Dupont est confirmé pour le 5 juin à 10h00.',
            time: 'Il y a 5 min',
            isRead: false, // Non lu
            icon: Icons.calendar_today,
            iconColor: Colors.green,
          ),
          NotificationItem(
            title: 'Nouvel article de blog',
            subtitle: 'Découvrez notre dernier article sur la santé cardiovasculaire.',
            time: 'Il y a 30 min',
            isRead: false, // Non lu
            icon: Icons.article,
            iconColor: Colors.blue,
          ),
          NotificationItem(
            title: 'Mise à jour de l\'application',
            subtitle: 'Une nouvelle version de l\'application est disponible. Mettez à jour pour profiter des dernières fonctionnalités.',
            time: 'Il y a 1 heure',
            isRead: true, // Lu
            icon: Icons.system_update,
            iconColor: Colors.orange,
          ),
          NotificationItem(
            title: 'Offre Spéciale',
            subtitle: 'Profitez de 20% de réduction sur votre prochaine consultation!',
            time: 'Hier',
            isRead: true, // Lu
            icon: Icons.local_offer,
            iconColor: Colors.purple,
          ),
          NotificationItem(
            title: 'Rappel de Médicament',
            subtitle: 'N\'oubliez pas de prendre votre médicament à 18h00.',
            time: 'Il y a 2 jours',
            isRead: true, // Lu
            icon: Icons.medical_services,
            iconColor: Colors.red,
          ),
          // Ajoutez d'autres NotificationItem ici pour plus de notifications
        ],
      ),
    );
  }
}

// --- Widget Individuel pour chaque Notification ---
class NotificationItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final String time;
  final bool isRead;
  final IconData icon;
  final Color iconColor;

  const NotificationItem({
    super.key,
    required this.title,
    required this.subtitle,
    required this.time,
    this.isRead = false, // Par défaut, une notification est non lue
    required this.icon,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      // La couleur de la carte change si la notification est lue ou non
      color: isRead ? Colors.white : Colors.blue.shade50, // Légèrement bleuté pour non-lu
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
        // Une bordure plus visible si non lue
        side: isRead ? BorderSide.none : const BorderSide(color: Colors.blueAccent, width: 1.0),
      ),
      child: InkWell( // Rend la carte cliquable
        onTap: () {
          // Logique à exécuter quand la notification est tapée
          // Par exemple, ouvrir une page de détails ou marquer comme lue
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Notification "${title}" tapée')),
          );
          // Dans une vraie application, vous naviguerez ou mettriez à jour l'état de la notification.
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icône de la notification
              Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: iconColor.withOpacity(0.15), // Couleur de fond légèrement transparente
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: iconColor, size: 28),
              ),
              const SizedBox(width: 16.0),
              // Contenu du texte de la notification
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontWeight: isRead ? FontWeight.normal : FontWeight.bold, // Gras si non lu
                        fontSize: 16.0,
                        color: Colors.black87,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 14.0,
                        color: isRead ? Colors.grey[700] : Colors.black54, // Couleur plus foncée si non lu
                      ),
                      maxLines: 2, // Limite à deux lignes pour la description
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8.0),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Text(
                        time,
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Indicateur de non-lu (point bleu)
              if (!isRead)
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 4.0),
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: const BoxDecoration(
                      color: Colors.blueAccent,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}