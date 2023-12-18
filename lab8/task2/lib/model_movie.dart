class Movie {
  late int id;
  late String title, releaseDate, overview, posterPath;
  late double voteAvg;

  Movie({
    required this.id,
    required this.title,
    required this.voteAvg,
    required this.releaseDate,
    required this.overview,
    required this.posterPath,
  });

  Movie.fromJson(Map<String, dynamic> parsedJson) {
    id = parsedJson['id'];
    title = parsedJson['title'];
    voteAvg = parsedJson['vote_average'] * 1.0;
    releaseDate = parsedJson['release_date'];
    overview = parsedJson['overview'];
    posterPath = parsedJson['poster_path'];
  }
}
