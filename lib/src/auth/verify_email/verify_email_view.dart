import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _VerifyEmailViewState createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  late NavigatorState navigator;

  @override
  void initState() {
    super.initState();
    navigator = Navigator.of(context); // Store the Navigator instance
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Verify Email"),
        backgroundColor: Colors.amber,
      ),
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.userChanges(),
        builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
          if (snapshot.hasData) {
            snapshot.data!.reload(); // Reload the user
            if (snapshot.data!.emailVerified) {
              // If the email is verified, navigate to the login page
              WidgetsBinding.instance.addPostFrameCallback((_) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Successfully Verified'),
                  ),
                );
                navigator.pushNamedAndRemoveUntil('/login/', (route) => false);
              });
            }
          }
          return Column(children: [
            const Text("Please verify your email"),
            TextButton(
              onPressed: () async {
                final user = FirebaseAuth.instance.currentUser;
                await user?.sendEmailVerification();
              },
              child: const Text("Send email verification"),
            )
          ]);
        },
      ),
    );
  }
}
