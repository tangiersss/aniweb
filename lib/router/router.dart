import 'package:anime_tracker/features/user_screen/user_screen.dart';
import 'package:flutter/material.dart';
import '../features/anime_list_screen/anime_list_screen.dart';
import '../features/review_screen/review_screen.dart';
import '../models/anime.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      return MaterialPageRoute(
        builder: (context) => const AnimeListScreen(),
      );
    case '/user':
      return MaterialPageRoute(
        builder: (context) => const UserScreen(),
      );
    case '/review':
      final anime = settings.arguments as Anime;
      return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          return ReviewScreen(anime: anime);
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.easeInOut;

          var tween = Tween<Offset>(begin: begin, end: end)
              .chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);

          return SlideTransition(position: offsetAnimation, child: child);
        },
      );
    default:
      return MaterialPageRoute(builder: (context) => const AnimeListScreen());
  }
}
