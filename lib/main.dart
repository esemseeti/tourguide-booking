import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:wanderwise/welcome.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: FirebaseOptions(
    apiKey: 'AIzaSyDKFnmPLXlZUiqKTQnXcsgoyLjXQ52iqPc', 
    appId: '1:580036832035:android:16517c71b9f076015e3a96', 
    messagingSenderId: '580036832035', 
    projectId: 'wanderwise-f3166'));
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WelcomeScreen(),
      
    );
  }
}
