import 'package:flutter/material.dart';
import 'package:anime_tracker/models/anime.dart';
import 'package:anime_tracker/repositories/anime_repository.dart';

import 'widgets/widgets.dart';

class AnimeListScreen extends StatefulWidget {
  const AnimeListScreen({super.key});

  @override
  _AnimeListScreenState createState() => _AnimeListScreenState();
}

class _AnimeListScreenState extends State<AnimeListScreen>
    with SingleTickerProviderStateMixin {
  late Future<List<Anime>> _animeList;
  final AnimeRepository _animeRepository = AnimeRepository();
  String _selectedGenre = 'all';

  @override
  void initState() {
    super.initState();
    _animeList = _animeRepository.getAnimeList(_selectedGenre);
  }

  void _changeGenre(String genre) {
    setState(() {
      _selectedGenre = genre;
      _animeList = _animeRepository.getAnimeList(genre);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset('assets/images/spider.png', height: 40),
            const SizedBox(width: 8),
            const Text('ANIWEB'),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: IconButton(
                onPressed: () {
                  if (context.mounted) {
                    Navigator.of(context).pushNamed('/user');
                  }
                },
                icon: const Icon(Icons.person)),
          )
        ],
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        transitionBuilder: (child, animation) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
        child: FutureBuilder<List<Anime>>(
          key: ValueKey<String>(_selectedGenre),
          future: _animeList,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Error: ${snapshot.error}',
                  style: const TextStyle(color: Colors.red),
                ),
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(
                child: Text(
                  'No anime found.',
                  style: TextStyle(color: Colors.grey),
                ),
              );
            } else {
              final animeList = snapshot.data!;
              return ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: animeList.length,
                itemBuilder: (context, index) {
                  final anime = animeList[index];
                  return TweenAnimationBuilder<double>(
                    duration: const Duration(milliseconds: 500),
                    tween: Tween<double>(begin: 0, end: 1),
                    builder: (context, value, child) {
                      return Opacity(
                        opacity: value,
                        child: Transform.translate(
                          offset: Offset(0, (1 - value) * 20),
                          child: child,
                        ),
                      );
                    },
                    child: AnimeCard(anime: anime),
                  );
                },
              );
            }
          },
        ),
      ),
      drawer: FilterDrawer(
        onGenreSelected: _changeGenre,
      ),
    );
  }
}

class FilterDrawer extends StatelessWidget {
  final Function(String) onGenreSelected;

  const FilterDrawer({super.key, required this.onGenreSelected});

  final List<String> genres = const [
    'All',
    'Adventure',
    'Romance',
    'Comedy',
    'Music',
    'Horror',
    'Drama',
    'Action',
  ];

  final Map<String, String> genreImages = const {
    'All': 'assets/images/all.jpg',
    'Adventure': 'assets/images/adventure.jpg',
    'Romance': 'assets/images/romance.jpg',
    'Comedy': 'assets/images/comedy.jpg',
    'Music': 'assets/images/music.jpg',
    'Horror': 'assets/images/horror.jpg',
    'Drama': 'assets/images/drama.jpg',
    'Action': 'assets/images/action.jpg',
  };

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const SizedBox(height: 50),
          ...genres.map((genre) {
            return Container(
              margin: const EdgeInsets.only(bottom: 12, left: 5, right: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: AssetImage(genreImages[genre]!),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.5),
                    BlendMode.darken,
                  ),
                ),
              ),
              child: ListTile(
                title: Center(
                  child: Text(
                    genre,
                    style: const TextStyle(
                        letterSpacing: 5,
                        fontSize: 22,
                        fontFamily: 'WorkSans',
                        color: Colors.white),
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  onGenreSelected(genre.toLowerCase());
                },
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}
