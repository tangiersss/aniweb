import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'router/router.dart';
import 'theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const AnimeTrackerApp());
}

class AnimeTrackerApp extends StatelessWidget {
  const AnimeTrackerApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aniweb',
      theme: customTheme,
      onGenerateRoute: generateRoute,
      initialRoute: '/',
    );
  }
}
