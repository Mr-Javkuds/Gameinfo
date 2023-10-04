final String tableFavorite = 'favTable  ';

class Favorite {
  static final List<String> values = [id, image, name, slug, released, rating, idDetail];

  static final String id = 'id';
  static final String image = 'image_background';
  static final String name = 'name';
  static final String slug = 'slug';
  static final String released = 'released';
  static final String rating = 'rating'; // Tambahkan rating
  static final String idDetail = 'id_detail'; // Tambahkan id_detail
}

class FavoriteModel {
  final int? id;
  final String image;
  final String name;
  final String slug;
  final String released;
  final String rating;
  final String? idDetail; // Tambahkan idDetail dengan tipe data int
  FavoriteModel({
    this.id,
    required this.image,
    required this.name,
    required this.slug,
    required this.released,
    required this.rating,
    required this.idDetail, // Tambahkan idDetail
  });

  static FavoriteModel fromJson(Map<String, Object?> json) => FavoriteModel(
    id: json[Favorite.id] as int?,
    image: json[Favorite.image] as String,
    name: json[Favorite.name] as String,
    slug: json[Favorite.slug] as String,
    released: json[Favorite.released] as String,
    rating: json[Favorite.rating] as String,
    idDetail: json[Favorite.idDetail] as String?, // Tambahkan idDetail
  );

  Map<String, Object?> toJson() => {
    Favorite.id: id,
    Favorite.image: image,
    Favorite.rating: rating,
    Favorite.name: name,
    Favorite.slug: slug,
    Favorite.released: released,
    Favorite.idDetail: idDetail, // Tambahkan idDetail
  };

  FavoriteModel copy({
    int? id,
    String? imageUrl,
    String? author,
    String? slug,
    String? released,
    String? rating,
    String? idDetail, // Tambahkan idDetail
  }) =>
      FavoriteModel(
        id: id ?? this.id,
        image: imageUrl ?? this.image,
        name: author ?? this.name,
        slug: slug ?? this.slug,
        released: released ?? this.released,
        rating: rating ?? this.rating,
        idDetail: idDetail ?? this.idDetail, // Tambahkan idDetail
      );
}
