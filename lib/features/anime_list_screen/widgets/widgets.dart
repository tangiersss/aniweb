import 'package:flutter/material.dart';

import '../../../models/anime.dart';

class AnimeCard extends StatelessWidget {
  final Anime anime;

  const AnimeCard({required this.anime, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(
            anime.imageUrl,
            width: 80,
            height: 120,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(
          anime.title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: 'WorkSans',
            fontSize: 18,
            color: Colors.black87,
          ),
        ),
        subtitle: Text(
          ('Rating: ${anime.rating}'),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(color: Colors.black54, fontFamily: 'WorkSans'),
        ),
        onTap: () {
          if (context.mounted) {
            Navigator.of(context).pushNamed('/review', arguments: anime);
          }
        },
      ),
    );
  }
}
