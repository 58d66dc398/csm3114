import 'package:flutter/material.dart';

import 'model_movie.dart';

class MovieDetail extends StatelessWidget {
  final Movie movie;
  final String imgPath = 'https://image.tmdb.org/t/p/w500/';

  const MovieDetail(this.movie, {super.key});

  @override
  Widget build(BuildContext context) {
    // double height = MediaQuery.of(context).size.height;
    String path = ('' != movie.posterPath)
        ? imgPath + movie.posterPath
        : 'https://images.freeimages.com/images/large-previews/5eb/movie-clapboard-1184339.jpg';
    return Scaffold(
      appBar: AppBar(title: Text(movie.title), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Flexible(flex: 3, child: Image.network(path)),
            const SizedBox(height: 16),
            Flexible(
                flex: 2,
                child: SingleChildScrollView(child: Text(movie.overview))),
          ],
        ),
      ),
    );
  }
}
