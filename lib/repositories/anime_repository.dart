import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../models/anime.dart';

class AnimeRepository {
  final Dio _dio = Dio();

  Future<List<Anime>> getAnimeList(String genre) async {
    if (genre == 'all') {
      try {
        final response = await _dio.get(
          'https://kitsu.io/api/edge/anime',
        );
        debugPrint(response.toString());
        if (response.statusCode == 200) {
          final data = response.data['data'] as List;
          return data.map((animeJson) {
            return Anime.fromJson(animeJson);
          }).toList();
        } else {
          throw Exception('Failed to load anime');
        }
      } catch (e) {
        throw Exception('Error: $e');
      }
    } else {
      try {
        final response = await _dio.get(
          'https://kitsu.io/api/edge/anime?filter[categories]=$genre',
        );
        debugPrint(response.toString());
        if (response.statusCode == 200) {
          final data = response.data['data'] as List;
          return data.map((animeJson) {
            return Anime.fromJson(animeJson);
          }).toList();
        } else {
          throw Exception('Failed to load anime');
        }
      } catch (e) {
        throw Exception('Error: $e');
      }
    }
  }
}
