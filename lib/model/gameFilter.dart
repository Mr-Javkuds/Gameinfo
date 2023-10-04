// To parse this JSON data, do
//
//     final gameFilter = gameFilterFromJson(jsonString);

import 'dart:convert';

GameFilter gameFilterFromJson(String str) => GameFilter.fromJson(json.decode(str));

String gameFilterToJson(GameFilter data) => json.encode(data.toJson());

class GameFilter {
  int count;
  String next;
  dynamic previous;
  List<Result> results;
  bool userPlatforms;

  GameFilter({
    required this.count,
    required this.next,
    required this.previous,
    required this.results,
    required this.userPlatforms,
  });

  factory GameFilter.fromJson(Map<String, dynamic> json) => GameFilter(
    count: json["count"],
    next: json["next"],
    previous: json["previous"],
    results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
    userPlatforms: json["user_platforms"],
  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "next": next,
    "previous": previous,
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
    "user_platforms": userPlatforms,
  };
}

class Result {
  String slug;
  String name;
  int playtime;
  List<Platform>? platforms;
  List<Store>? stores;
  DateTime released;
  bool tba;
  String backgroundImage;
  double rating;
  int ratingTop;
  List<Rating> ratings;
  int ratingsCount;
  int reviewsTextCount;
  int added;
  AddedByStatus? addedByStatus;
  int? metacritic;
  int suggestionsCount;
  DateTime updated;
  int id;
  String score;
  dynamic clip;
  List<Tag> tags;
  EsrbRating? esrbRating;
  dynamic userGame;
  int reviewsCount;
  int? communityRating;
  Color saturatedColor;
  Color dominantColor;
  List<ShortScreenshot> shortScreenshots;
  List<Platform>? parentPlatforms;
  List<Genre> genres;

  Result({
    required this.slug,
    required this.name,
    required this.playtime,
    required this.platforms,
    required this.stores,
    required this.released,
    required this.tba,
    required this.backgroundImage,
    required this.rating,
    required this.ratingTop,
    required this.ratings,
    required this.ratingsCount,
    required this.reviewsTextCount,
    required this.added,
    required this.addedByStatus,
    required this.metacritic,
    required this.suggestionsCount,
    required this.updated,
    required this.id,
    required this.score,
    required this.clip,
    required this.tags,
    required this.esrbRating,
    required this.userGame,
    required this.reviewsCount,
    this.communityRating,
    required this.saturatedColor,
    required this.dominantColor,
    required this.shortScreenshots,
    this.parentPlatforms,
    required this.genres,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    slug: json["slug"],
    name: json["name"],
    playtime: json["playtime"],
    platforms: json["platforms"] == null ? [] : List<Platform>.from(json["platforms"]!.map((x) => Platform.fromJson(x))),
    stores: json["stores"] == null ? [] : List<Store>.from(json["stores"]!.map((x) => Store.fromJson(x))),
    released: DateTime.parse(json["released"]),
    tba: json["tba"],
    backgroundImage: json["background_image"],
    rating: json["rating"]?.toDouble(),
    ratingTop: json["rating_top"],
    ratings: List<Rating>.from(json["ratings"].map((x) => Rating.fromJson(x))),
    ratingsCount: json["ratings_count"],
    reviewsTextCount: json["reviews_text_count"],
    added: json["added"],
    addedByStatus: json["added_by_status"] == null ? null : AddedByStatus.fromJson(json["added_by_status"]),
    metacritic: json["metacritic"],
    suggestionsCount: json["suggestions_count"],
    updated: DateTime.parse(json["updated"]),
    id: json["id"],
    score: json["score"],
    clip: json["clip"],
    tags: List<Tag>.from(json["tags"].map((x) => Tag.fromJson(x))),
    esrbRating: json["esrb_rating"] == null ? null : EsrbRating.fromJson(json["esrb_rating"]),
    userGame: json["user_game"],
    reviewsCount: json["reviews_count"],
    communityRating: json["community_rating"],
    saturatedColor: colorValues.map[json["saturated_color"]]!,
    dominantColor: colorValues.map[json["dominant_color"]]!,
    shortScreenshots: List<ShortScreenshot>.from(json["short_screenshots"].map((x) => ShortScreenshot.fromJson(x))),
    parentPlatforms: json["parent_platforms"] == null ? [] : List<Platform>.from(json["parent_platforms"]!.map((x) => Platform.fromJson(x))),
    genres: List<Genre>.from(json["genres"].map((x) => Genre.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "slug": slug,
    "name": name,
    "playtime": playtime,
    "platforms": platforms == null ? [] : List<dynamic>.from(platforms!.map((x) => x.toJson())),
    "stores": stores == null ? [] : List<dynamic>.from(stores!.map((x) => x.toJson())),
    "released": "${released.year.toString().padLeft(4, '0')}-${released.month.toString().padLeft(2, '0')}-${released.day.toString().padLeft(2, '0')}",
    "tba": tba,
    "background_image": backgroundImage,
    "rating": rating,
    "rating_top": ratingTop,
    "ratings": List<dynamic>.from(ratings.map((x) => x.toJson())),
    "ratings_count": ratingsCount,
    "reviews_text_count": reviewsTextCount,
    "added": added,
    "added_by_status": addedByStatus?.toJson(),
    "metacritic": metacritic,
    "suggestions_count": suggestionsCount,
    "updated": updated.toIso8601String(),
    "id": id,
    "score": score,
    "clip": clip,
    "tags": List<dynamic>.from(tags.map((x) => x.toJson())),
    "esrb_rating": esrbRating?.toJson(),
    "user_game": userGame,
    "reviews_count": reviewsCount,
    "community_rating": communityRating,
    "saturated_color": colorValues.reverse[saturatedColor],
    "dominant_color": colorValues.reverse[dominantColor],
    "short_screenshots": List<dynamic>.from(shortScreenshots.map((x) => x.toJson())),
    "parent_platforms": parentPlatforms == null ? [] : List<dynamic>.from(parentPlatforms!.map((x) => x.toJson())),
    "genres": List<dynamic>.from(genres.map((x) => x.toJson())),
  };
}

class AddedByStatus {
  int owned;
  int? yet;
  int? beaten;
  int? toplay;
  int? dropped;
  int? playing;

  AddedByStatus({
    required this.owned,
    this.yet,
    this.beaten,
    this.toplay,
    this.dropped,
    this.playing,
  });

  factory AddedByStatus.fromJson(Map<String, dynamic> json) => AddedByStatus(
    owned: json["owned"],
    yet: json["yet"],
    beaten: json["beaten"],
    toplay: json["toplay"],
    dropped: json["dropped"],
    playing: json["playing"],
  );

  Map<String, dynamic> toJson() => {
    "owned": owned,
    "yet": yet,
    "beaten": beaten,
    "toplay": toplay,
    "dropped": dropped,
    "playing": playing,
  };
}

enum Color {
  THE_0_F0_F0_F
}

final colorValues = EnumValues({
  "0f0f0f": Color.THE_0_F0_F0_F
});

class EsrbRating {
  int id;
  String name;
  String slug;
  String nameEn;
  String nameRu;

  EsrbRating({
    required this.id,
    required this.name,
    required this.slug,
    required this.nameEn,
    required this.nameRu,
  });

  factory EsrbRating.fromJson(Map<String, dynamic> json) => EsrbRating(
    id: json["id"],
    name: json["name"],
    slug: json["slug"],
    nameEn: json["name_en"],
    nameRu: json["name_ru"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "slug": slug,
    "name_en": nameEn,
    "name_ru": nameRu,
  };
}

class Genre {
  int id;
  String name;
  String slug;

  Genre({
    required this.id,
    required this.name,
    required this.slug,
  });

  factory Genre.fromJson(Map<String, dynamic> json) => Genre(
    id: json["id"],
    name: json["name"],
    slug: json["slug"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "slug": slug,
  };
}

class Platform {
  Genre platform;

  Platform({
    required this.platform,
  });

  factory Platform.fromJson(Map<String, dynamic> json) => Platform(
    platform: Genre.fromJson(json["platform"]),
  );

  Map<String, dynamic> toJson() => {
    "platform": platform.toJson(),
  };
}

class Rating {
  int id;
  Title title;
  int count;
  double percent;

  Rating({
    required this.id,
    required this.title,
    required this.count,
    required this.percent,
  });

  factory Rating.fromJson(Map<String, dynamic> json) => Rating(
    id: json["id"],
    title: titleValues.map[json["title"]]!,
    count: json["count"],
    percent: json["percent"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": titleValues.reverse[title],
    "count": count,
    "percent": percent,
  };
}

enum Title {
  EXCEPTIONAL,
  MEH,
  RECOMMENDED,
  SKIP
}

final titleValues = EnumValues({
  "exceptional": Title.EXCEPTIONAL,
  "meh": Title.MEH,
  "recommended": Title.RECOMMENDED,
  "skip": Title.SKIP
});

class ShortScreenshot {
  int id;
  String image;

  ShortScreenshot({
    required this.id,
    required this.image,
  });

  factory ShortScreenshot.fromJson(Map<String, dynamic> json) => ShortScreenshot(
    id: json["id"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "image": image,
  };
}

class Store {
  Genre store;

  Store({
    required this.store,
  });

  factory Store.fromJson(Map<String, dynamic> json) => Store(
    store: Genre.fromJson(json["store"]),
  );

  Map<String, dynamic> toJson() => {
    "store": store.toJson(),
  };
}

class Tag {
  int id;
  String name;
  String slug;
  Language language;
  int gamesCount;
  String imageBackground;

  Tag({
    required this.id,
    required this.name,
    required this.slug,
    required this.language,
    required this.gamesCount,
    required this.imageBackground,
  });

  factory Tag.fromJson(Map<String, dynamic> json) => Tag(
    id: json["id"],
    name: json["name"],
    slug: json["slug"],
    language: languageValues.map[json["language"]]!,
    gamesCount: json["games_count"],
    imageBackground: json["image_background"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "slug": slug,
    "language": languageValues.reverse[language],
    "games_count": gamesCount,
    "image_background": imageBackground,
  };
}

enum Language {
  ENG,
  RUS
}

final languageValues = EnumValues({
  "eng": Language.ENG,
  "rus": Language.RUS
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
