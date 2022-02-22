class Movie {
  final int totalCountMovies;
  final int idMovie;
  final String imgMovie;
  final String directorMovie;
  final String titleMovie;
  final DateTime releaseDate;
  final int totalCountReviews;
  final String titleReview;
  final int idUserReview;
  final String nameUserReview;
  final int rating;
  final String bodytReview;
  final int idReview;

  Movie(
    this.totalCountMovies,
    this.idMovie,
    this.imgMovie,
    this.directorMovie,
    this.titleMovie,
    this.releaseDate,
    this.totalCountReviews,
    this.titleReview,
    this.idUserReview,
    this.nameUserReview,
    this.rating,
    this.bodytReview,
    this.idReview,
  );

  factory Movie.fromJson(Map json) {
    return Movie(
      json['total_count_movies'],
      json['id_movie'],
      json['img_movie'],
      json['director_movie'],
      json['title_movie'],
      DateTime.parse(json['release_date']),
      json['total_count_reviews'],
      json['title_review'],
      json['id_user_review'],
      json['name_user_review'],
      json['rating'],
      json['body_review'],
      json['id_review'],
    );
  }

  @override
  String toString() {
    return "id: $idMovie";
  }
}
