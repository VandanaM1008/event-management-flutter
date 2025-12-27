import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'firebase_options.dart';
import 'auth_gate.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // TEMP: uncomment once to insert sample events, then comment again
  // await seedEvents();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: const Color(0xFF667EEA),
      brightness: Brightness.light,
    );

    return MaterialApp(
      title: 'Campus Events',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: colorScheme,
        scaffoldBackgroundColor: const Color(0xFFF5F5FF),
        textTheme: ThemeData.light().textTheme.apply(
              bodyColor: const Color(0xFF1F2933),
              displayColor: const Color(0xFF1F2933),
            ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: colorScheme.primary,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(color: colorScheme.outlineVariant),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(color: colorScheme.primary, width: 2),
          ),
        ),
      ),
      home: const AuthGate(),
    );
  }
}

// Optional: call seedEvents() once from main() to insert sample events.
Future<void> seedEvents() async {
  final events = [
    {
      'title': 'Dance Night',
      'description':
          'Inter-college dance competition with solo and group performances.',
      'date': DateTime(2025, 12, 10, 18, 0),
      'location': 'Auditorium',
      'category': 'Dance',
      'createdBy': 'seed-admin',
    },
    {
      'title': 'Tech Talk: Flutter & Firebase',
      'description': 'Live demo of building a campus events app with Flutter.',
      'date': DateTime(2025, 12, 12, 14, 0),
      'location': 'Lab A-201',
      'category': 'Tech',
      'createdBy': 'seed-admin',
    },
    {
      'title': 'Food Fest',
      'description': 'Food stalls from different clubs and departments.',
      'date': DateTime(2025, 12, 15, 11, 0),
      'location': 'Main Ground',
      'category': 'Food',
      'createdBy': 'seed-admin',
    },
    {
      'title': 'Art Exhibition',
      'description': 'Painting, photography and sculpture by students.',
      'date': DateTime(2025, 12, 18, 10, 0),
      'location': 'Art Gallery',
      'category': 'Art',
      'createdBy': 'seed-admin',
    },
    {
      'title': 'Stand-up Comedy Night',
      'description': 'Open-mic stand-up comedy evening.',
      'date': DateTime(2025, 12, 20, 19, 0),
      'location': 'Seminar Hall 2',
      'category': 'Comedy',
      'createdBy': 'seed-admin',
    },
    {
      'title': 'Sports Carnival',
      'description': 'Cricket, football and relay races throughout the day.',
      'date': DateTime(2025, 12, 22, 9, 0),
      'location': 'Sports Ground',
      'category': 'Sports',
      'createdBy': 'seed-admin',
    },
  ];

  final col = FirebaseFirestore.instance.collection('events');
  for (final e in events) {
    await col.add({
      ...e,
      'date': Timestamp.fromDate(e['date'] as DateTime),
    });
  }
}
