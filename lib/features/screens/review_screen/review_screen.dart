import 'package:anime_tracker/models/anime.dart';
import 'package:flutter/material.dart';

class ReviewScreen extends StatefulWidget {
  final Anime anime;
  const ReviewScreen({required this.anime, super.key});

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  late final Anime anime;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    anime = widget.anime;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/images/spider.png',
              height: 40,
            ),
            const SizedBox(width: 8),
            const Text('ANIWEB'),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Text(
                anime.title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 30,
                  color: Colors.blueGrey,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(16),
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(anime.imageUrl, fit: BoxFit.cover),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Text(anime.description),
            ),
          ],
        ),
      ),
    );
  }
}
