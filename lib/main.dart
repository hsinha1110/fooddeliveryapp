import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fooddeliveryapp/bottom_nav.dart';
import 'package:fooddeliveryapp/firebase_options.dart';
import 'package:fooddeliveryapp/login.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // Stripe Publishable Key
  Stripe.publishableKey =
      "pk_test_51NDfCkSHz5kWzFj1Fqv3F5MkqBOj4xYgHm0wMzsQ6T19VmAsqkSGLteJDmO9UzuJqX89nF0ebyJTKP2unerThwxj00SusRTxc6";
  await Stripe.instance.applySettings();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          if (snapshot.hasData) {
            return const BottomNav();
          }

          return const Login();
        },
      ),
    );
  }
}
