// To parse this JSON data, do
//
//     final gameGenre = gameGenreFromJson(jsonString);

import 'dart:convert';

GameGenre gameGenreFromJson(String str) => GameGenre.fromJson(json.decode(str));

String gameGenreToJson(GameGenre data) => json.encode(data.toJson());

class GameGenre {
  int count;
  dynamic next;
  dynamic previous;
  List<Result> results;

  GameGenre({
    required this.count,
    required this.next,
    required this.previous,
    required this.results,
  });

  factory GameGenre.fromJson(Map<String, dynamic> json) => GameGenre(
    count: json["count"],
    next: json["next"],
    previous: json["previous"],
    results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "next": next,
    "previous": previous,
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
  };
}

class Result {
  int id;
  String name;
  String slug;
  int gamesCount;
  String imageBackground;
  List<Game> games;

  Result({
    required this.id,
    required this.name,
    required this.slug,
    required this.gamesCount,
    required this.imageBackground,
    required this.games,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    name: json["name"],
    slug: json["slug"],
    gamesCount: json["games_count"],
    imageBackground: json["image_background"],
    games: List<Game>.from(json["games"].map((x) => Game.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "slug": slug,
    "games_count": gamesCount,
    "image_background": imageBackground,
    "games": List<dynamic>.from(games.map((x) => x.toJson())),
  };
}

class Game {
  int id;
  String slug;
  String name;
  int added;

  Game({
    required this.id,
    required this.slug,
    required this.name,
    required this.added,
  });

  factory Game.fromJson(Map<String, dynamic> json) => Game(
    id: json["id"],
    slug: json["slug"],
    name: json["name"],
    added: json["added"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "slug": slug,
    "name": name,
    "added": added,
  };
}
