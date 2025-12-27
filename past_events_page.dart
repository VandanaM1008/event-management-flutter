import 'package:flutter/material.dart';

class PastEventsPage extends StatelessWidget {
  const PastEventsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Past Events & Rules'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFFDF2FF),
              Color(0xFFE0F2FE),
            ],
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Highlighted past event
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(20)),
                    child: Container(
                      height: 180,
                      width: double.infinity,
                      color: const Color(0xFF667EEA),
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.celebration_outlined,
                        color: Colors.white,
                        size: 60,
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Cultural Night 2024',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Music, dance and drama performances by RV University clubs.',
                          style: TextStyle(fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            const Text(
              'Photo Gallery',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 110,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: const [
                  _GalleryCard(
                    icon: Icons.computer_outlined,
                    label: 'Tech Fest 2024',
                    color: Color(0xFF3B82F6),
                  ),
                  _GalleryCard(
                    icon: Icons.sports_soccer_outlined,
                    label: 'Sports Day',
                    color: Color(0xFF10B981),
                  ),
                  _GalleryCard(
                    icon: Icons.fastfood_outlined,
                    label: 'Food Fest',
                    color: Color(0xFFF59E0B),
                  ),
                  _GalleryCard(
                    icon: Icons.brush_outlined,
                    label: 'Art Expo',
                    color: Color(0xFFEC4899),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            const Text(
              'General Event Rules',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            const _RuleTile(
              icon: Icons.badge_outlined,
              title: 'Carry your RV ID card',
              text:
                  'All participants and audience must carry a valid RV University ID card for entry.',
            ),
            const _RuleTile(
              icon: Icons.schedule_outlined,
              title: 'Be on time',
              text:
                  'Reach the venue at least 15 minutes before your event or performance reporting time.',
            ),
            const _RuleTile(
              icon: Icons.volume_off_outlined,
              title: 'Respect academic zones',
              text:
                  'Avoid loud noise near classrooms, library and exam halls when sessions are in progress.',
            ),
            const _RuleTile(
              icon: Icons.clean_hands_outlined,
              title: 'Keep the campus clean',
              text:
                  'Use dustbins at venues and food stalls; plastics and littering are strictly discouraged.',
            ),
            const _RuleTile(
              icon: Icons.security_outlined,
              title: 'Follow safety & discipline',
              text:
                  'Prohibited items, harassment or misconduct of any kind can lead to disciplinary action.',
            ),
          ],
        ),
      ),
    );
  }
}

class _GalleryCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _GalleryCard({
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      margin: const EdgeInsets.only(right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 70,
            width: 130,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              gradient: LinearGradient(
                colors: [
                  color.withOpacity(0.15),
                  color.withOpacity(0.35),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            alignment: Alignment.center,
            child: Icon(icon, color: color, size: 32),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _RuleTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String text;

  const _RuleTile({
    required this.icon,
    required this.title,
    required this.text,
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
          text,
          style: const TextStyle(fontSize: 12),
        ),
      ),
    );
  }
}
