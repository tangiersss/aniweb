class Anime {
  final String id;
  final String title;
  final String rating;
  final String imageUrl;
  final String description;

  Anime({
    required this.id,
    required this.title,
    required this.rating,
    required this.imageUrl,
    required this.description,
  });

  factory Anime.fromJson(Map<String, dynamic> json) {
    return Anime(
      id: json['id'],
      title: json['attributes']['canonicalTitle'],
      rating: json['attributes']['averageRating'] ?? 'No rating available',
      imageUrl: json['attributes']['posterImage']['medium'],
      description: json['attributes']['synopsis'] ?? 'No decription available',
    );
  }
}
