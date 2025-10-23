import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';     

import 'package:firebase_auth/firebase_auth.dart';

import 'firebase_options.dart';                       

import 'home_page.dart';

import 'login_page.dart';



Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();          

  await Firebase.initializeApp(                      

    options: DefaultFirebaseOptions.currentPlatform,

  );

  runApp(const MyApp());

}



class MyApp extends StatelessWidget {

  const MyApp({super.key});



  @override

  Widget build(BuildContext context) {

    return MaterialApp(

      debugShowCheckedModeBanner: false,

      title: 'Flutter Demo',

      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),

        useMaterial3: true,

      ),

      home: const AuthGate(),

    );

  }

}



class AuthGate extends StatelessWidget {

  const AuthGate({super.key});



  @override

  Widget build(BuildContext context) {

    return StreamBuilder<User?>(

      stream: FirebaseAuth.instance.authStateChanges(),

      builder: (context, snap) {

        if (snap.connectionState == ConnectionState.waiting) {

          return const Scaffold(

            body: Center(child: CircularProgressIndicator()),

          );

        }

        final user = snap.data;

        if (user != null) return const HomePage();

        return const LoginPage();

      },

    );

  }

}