import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'events_page.dart';
import 'login_page.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (!snapshot.hasData) return const LoginPage();

        final user = snapshot.data!;

        return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .snapshots(),
          builder: (context, userSnap) {
            if (userSnap.connectionState == ConnectionState.waiting) {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }

            if (!userSnap.hasData || !userSnap.data!.exists) {
              FirebaseFirestore.instance
                  .collection('users')
                  .doc(user.uid)
                  .set({
                'email': user.email,
                'role':
                    user.email == 'admin@college.com' ? 'admin' : 'student',
                'createdAt': FieldValue.serverTimestamp(),
              }, SetOptions(merge: true));

              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }

            final data = userSnap.data!.data()!;
            final role = (data['role'] as String?) ?? 'student';
            print('AuthGate role from Firestore = $role'); // debug
            return EventsPage(role: role);
          },
        );
      },
    );
  }
}