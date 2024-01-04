// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

enum TypeEvent { Games, Sports, Music, Movie }

extension TypeEventExtension on TypeEvent {
  IconData get icon {
    switch (this) {
      case TypeEvent.Games:
        return Icons.games_rounded;
      case TypeEvent.Sports:
        return Icons.sports_basketball;
      case TypeEvent.Music:
        return Icons.music_note_rounded;
      case TypeEvent.Movie:
        return Icons.movie_creation_outlined;
    }
  }
}

class CategoryEvent {
  TypeEvent type;
  IconData get icon => type.icon;

  CategoryEvent({
    required this.type,
  });
}

List<CategoryEvent> categoryEvents = List.generate(TypeEvent.values.length,
    (index) => CategoryEvent(type: TypeEvent.values[index]));
