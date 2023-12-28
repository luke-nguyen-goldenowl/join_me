// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

enum TypeEvent { Games, Sports, Music, Movie }

class CategoryEvent {
  TypeEvent type;
  IconData icon;
  CategoryEvent({
    required this.type,
    required this.icon,
  });
}

List<CategoryEvent> categoryEvents = [
  CategoryEvent(type: TypeEvent.Sports, icon: Icons.sports_basketball),
  CategoryEvent(type: TypeEvent.Games, icon: Icons.games_rounded),
  CategoryEvent(type: TypeEvent.Music, icon: Icons.music_note_rounded),
  CategoryEvent(type: TypeEvent.Movie, icon: Icons.movie_creation_outlined),
];
