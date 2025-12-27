import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    const primary = Color(0xFF667EEA);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact & Help'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFE0ECFF),
              Color(0xFFFDF2FF),
            ],
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 6,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'RV University\nEvent Management Cell',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Ground Floor, Admin Block\nRV University, Bengaluru, Karnataka',
                      style: TextStyle(fontSize: 13),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            const Text(
              'Reach us',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            _ContactTile(
              icon: Icons.phone_outlined,
              title: 'Office Phone',
              value: '+91 80 1234 5678',
              onTap: () async =>
                  _launchUri(Uri.parse('tel:+918012345678')),
            ),
            _ContactTile(
              icon: Icons.email_outlined,
              title: 'Email',
              value: 'events@rvu.edu.in',
              onTap: () async =>
                  _launchUri(Uri.parse('mailto:events@rvu.edu.in')),
            ),
            _ContactTile(
              icon: Icons.language_outlined,
              title: 'Website',
              value: 'www.rvu.edu.in/events',
              onTap: () async =>
                  _launchUri(Uri.parse('https://www.rvu.edu.in')),
            ),
            _ContactTile(
              icon: Icons.location_on_outlined,
              title: 'Google Maps',
              value: 'View campus location',
              onTap: () async => _launchUri(Uri.parse(
                  'https://www.google.com/maps/search/?api=1&query=RV+University+Bengaluru')),
            ),

            const SizedBox(height: 20),
            const Text(
              'Support during events',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            const _InfoChipRow(
              icon: Icons.help_outline,
              text:
                  'For technical issues with the app, visit the help desk near the registration counter.',
            ),
            const _InfoChipRow(
              icon: Icons.health_and_safety_outlined,
              text:
                  'For medical or safety emergencies, contact the campus security help line immediately.',
            ),
            const _InfoChipRow(
              icon: Icons.feedback_outlined,
              text:
                  'Share suggestions about events and the app with the Event Management Cell.',
            ),

            const SizedBox(height: 20),
            Center(
              child: ElevatedButton.icon(
                onPressed: () async => _launchUri(
                  Uri.parse('mailto:events@rvu.edu.in?subject=Event%20feedback'),
                ),
                icon: const Icon(Icons.feedback_outlined),
                label: const Text('Send quick feedback'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: primary,
                  foregroundColor: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ContactTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final VoidCallback onTap;

  const _ContactTile({
    required this.icon,
    required this.title,
    required this.value,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: ListTile(
        leading: Icon(icon, color: const Color(0xFF667EEA)),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
        ),
        subtitle: Text(
          value,
          style: const TextStyle(fontSize: 13),
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}

class _InfoChipRow extends StatelessWidget {
  final IconData icon;
  final String text;
  const _InfoChipRow({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: const Color(0xFF667EEA)),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}

Future<void> _launchUri(Uri uri) async {
  if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
    debugPrint('Could not launch $uri');
  }
}
