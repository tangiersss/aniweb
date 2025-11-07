import 'package:flutter/material.dart';

import 'router/router.dart';
import 'theme/theme.dart';

void main() {
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
