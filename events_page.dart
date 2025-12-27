import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'past_events_page.dart' as past;
import 'contact_page.dart' as contact;
import 'event_form_page.dart';

class EventsPage extends StatelessWidget {
  final String role; // 'admin' or 'student'
  const EventsPage({super.key, required this.role});

  bool get isAdmin => role == 'admin';

  @override
  Widget build(BuildContext context) {
    // print('EventsPage role = $role');

    final eventsQuery =
        FirebaseFirestore.instance.collection('events').orderBy('date');

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Campus Events'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF667EEA),
                Color(0xFF764BA2),
              ],
            ),
          ),
        ),
        actions: [
          // Past events page
          IconButton(
            icon: const Icon(Icons.photo_library_outlined),
            tooltip: 'Past events',
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => past.PastEventsPage()),
              );
            },
          ),
          // Contact & help page
          IconButton(
            icon: const Icon(Icons.support_agent_outlined),
            tooltip: 'Contact & help',
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => contact.ContactPage()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => FirebaseAuth.instance.signOut(),
          ),
          if (isAdmin)
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const EventFormPage()),
                );
              },
            ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFF5F5FF),
              Color(0xFFE0E7FF),
            ],
          ),
        ),
        child: StreamBuilder<QuerySnapshot>(
          stream: eventsQuery.snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(child: Text('Error loading events'));
            }
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            final docs = snapshot.data!.docs;
            if (docs.isEmpty) {
              return const Center(child: Text('No events yet'));
            }
            return ListView.builder(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              itemCount: docs.length,
              itemBuilder: (context, index) {
                final doc = docs[index];
                final data = doc.data() as Map<String, dynamic>;
                final ts = data['date'] as Timestamp?;
                final date = ts?.toDate();

                final category = (data['category'] ?? '') as String;
                final title = (data['title'] ?? '') as String;
                final location = (data['location'] ?? '') as String;

                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFFFFFFFF),
                        Color(0xFFF1F5FF),
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 12,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Material(
                    type: MaterialType.transparency,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: () => _showDetails(context, doc.id, data),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 14),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 22,
                              backgroundColor: const Color(0xFF667EEA),
                              child: Text(
                                title.isNotEmpty ? title[0].toUpperCase() : '?',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    title,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xFF111827),
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '$location • ${date != null ? date.toLocal().toString().substring(0, 16) : ''}',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Color(0xFF4B5563),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      _CategoryChip(label: category),
                                      const SizedBox(width: 8),
                                      const Icon(
                                        Icons.event_available,
                                        size: 16,
                                        color: Color(0xFF6B7280),
                                      ),
                                      const SizedBox(width: 4),
                                      const Text(
                                        'Tap for details',
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: Color(0xFF6B7280),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  void _showDetails(
      BuildContext context, String eventId, Map<String, dynamic> data) {
    final ts = data['date'] as Timestamp?;
    final date = ts?.toDate();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        final user = FirebaseAuth.instance.currentUser!;
        final regRef = FirebaseFirestore.instance
            .collection('events')
            .doc(eventId)
            .collection('registrations')
            .doc(user.uid);

        // Stream of all registrations for this event
        final allRegsStream = FirebaseFirestore.instance
            .collection('events')
            .doc(eventId)
            .collection('registrations')
            .orderBy('createdAt', descending: true)
            .snapshots();

        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: StreamBuilder<DocumentSnapshot>(
            stream: regRef.snapshots(),
            builder: (context, regSnap) {
              final alreadyRegistered =
                  regSnap.hasData && regSnap.data!.exists;

              return Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data['title'] ?? '',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '${data['location'] ?? ''} • '
                      '${date != null ? date.toLocal().toString().substring(0, 16) : ''}',
                      style: const TextStyle(
                        fontSize: 13,
                        color: Color(0xFF6B7280),
                      ),
                    ),
                    const SizedBox(height: 10),
                    _CategoryChip(label: (data['category'] ?? '') as String),
                    const SizedBox(height: 16),
                    Text(
                      data['description'] ?? '',
                      style: const TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 24),

                    // Register + reminder buttons
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: alreadyRegistered
                                ? null
                                : () async {
                                    await regRef.set({
                                      'userId': user.uid,
                                      'email': user.email,
                                      'createdAt':
                                          FieldValue.serverTimestamp(),
                                    });
                                    if (context.mounted) {
                                      Navigator.pop(context);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content:
                                              Text('Registered for event'),
                                        ),
                                      );
                                    }
                                  },
                            icon: const Icon(Icons.event_available),
                            label: Text(
                              alreadyRegistered
                                  ? 'Already registered'
                                  : 'Register',
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () {
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Reminder: add this event to your calendar app.',
                                  ),
                                ),
                              );
                            },
                            icon: const Icon(Icons.alarm),
                            label: const Text('Reminder'),
                          ),
                        ),
                      ],
                    ),

                    // Admin-only delete button
                    if (isAdmin) ...[
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        child: TextButton.icon(
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.red,
                          ),
                          onPressed: () async {
                            final confirm = await showDialog<bool>(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                title: const Text('Delete event?'),
                                content: const Text(
                                  'This will permanently delete the event and all registrations.',
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(ctx, false),
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(ctx, true),
                                    child: const Text(
                                      'Delete',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ),
                                ],
                              ),
                            );
                            if (confirm != true) return;

                            await FirebaseFirestore.instance
                                .collection('events')
                                .doc(eventId)
                                .delete();

                            if (context.mounted) {
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Event deleted'),
                                ),
                              );
                            }
                          },
                          icon: const Icon(Icons.delete_outline),
                          label: const Text('Delete event'),
                        ),
                      ),
                    ],

                    const SizedBox(height: 20),

                    // Registrations list – only for admins
                    if (isAdmin) ...[
                      const Divider(),
                      const SizedBox(height: 8),
                      const Text(
                        'Registrations',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        height: 180,
                        child: StreamBuilder<QuerySnapshot>(
                          stream: allRegsStream,
                          builder: (context, snap) {
                            if (snap.hasError) {
                              return const Text(
                                  'Error loading registrations');
                            }
                            if (!snap.hasData) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }
                            final regs = snap.data!.docs;
                            if (regs.isEmpty) {
                              return const Text(
                                'No one has registered yet.',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Color(0xFF6B7280),
                                ),
                              );
                            }
                            return ListView.builder(
                              itemCount: regs.length,
                              itemBuilder: (context, index) {
                                final r = regs[index].data()
                                    as Map<String, dynamic>;
                                final email = r['email'] as String? ?? '';
                                final createdAt =
                                    r['createdAt'] as Timestamp?;
                                final registeredAt =
                                    createdAt?.toDate().toLocal().toString()
                                            .substring(0, 16) ??
                                        '';
                                return _RegistrationTile(
                                  email: email,
                                  registeredAt: registeredAt,
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class _CategoryChip extends StatelessWidget {
  final String label;
  const _CategoryChip({required this.label});

  Color _colorForLabel() {
    switch (label.toLowerCase()) {
      case 'dance':
        return const Color(0xFFF97373);
      case 'tech':
        return const Color(0xFF3B82F6);
      case 'food':
        return const Color(0xFFF59E0B);
      case 'art':
        return const Color(0xFFEC4899);
      case 'sports':
        return const Color(0xFF10B981);
      case 'comedy':
        return const Color(0xFFA855F7);
      default:
        return const Color(0xFF6B7280);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (label.isEmpty) return const SizedBox.shrink();
    final color = _colorForLabel();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: color.withOpacity(0.4)),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }
}

class _RegistrationTile extends StatelessWidget {
  final String email;
  final String registeredAt;

  const _RegistrationTile({
    required this.email,
    required this.registeredAt,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        radius: 16,
        backgroundColor: const Color(0xFF667EEA).withOpacity(0.15),
        child: Text(
          email.isNotEmpty ? email[0].toUpperCase() : '?',
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: Color(0xFF4338CA),
          ),
        ),
      ),
      title: Text(
        email,
        style: const TextStyle(fontSize: 13),
      ),
      subtitle: Text(
        registeredAt,
        style: const TextStyle(
          fontSize: 11,
          color: Color(0xFF6B7280),
        ),
      ),
    );
  }
}
