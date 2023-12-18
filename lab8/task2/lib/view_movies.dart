import 'package:flutter/material.dart';
import 'package:lab8/util_http.dart';
import 'package:lab8/view_movie.dart';

class MovieList extends StatefulWidget {
  const MovieList({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MovieListState();
  }
}

class _MovieListState extends State<MovieList> {
  String? result;
  HttpHelper? helper;
  int? moviesCount;
  late List<dynamic> movies;
  final String iconBase = 'https://image.tmdb.org/t/p/w92/';
  final String defaultImage =
      'https://images.freeimages.com/images/large-previews/5eb/movie-clapboard-1184339.jpg';
  Icon visibleIcon = const Icon(Icons.search);
  Widget searchBar = const Text('Movies');

  @override
  void initState() {
    helper = HttpHelper();
    initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    NetworkImage image;
    return Scaffold(
      appBar: AppBar(
        title: searchBar,
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  if (visibleIcon.icon == Icons.search) {
                    visibleIcon = const Icon(Icons.cancel);
                    searchBar = TextField(
                      textInputAction: TextInputAction.search,
                      onSubmitted: (String text) {
                        search(text);
                      },
                    );
                  } else {
                    visibleIcon = const Icon(Icons.search);
                    searchBar = const Text('Movies');
                  }
                });
              },
              icon: visibleIcon),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: (moviesCount == null) ? 0 : moviesCount,
        itemBuilder: (context, index) {
          image = NetworkImage(
            (movies[index].posterPath == null)
                ? defaultImage
                : '$iconBase${movies[index].posterPath}',
          );
          return Card(
            elevation: 2,
            child: ListTile(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => MovieDetail(movies[index])),
              ),
              leading: CircleAvatar(backgroundImage: image),
              title: Text(movies[index].title),
              subtitle: Text(
                  'Released: ${movies[index].releaseDate} - Vote: ${movies[index].voteAvg.toString()}'),
            ),
          );
        },
      ),
    );
  }

  Future search(text) async {
    movies = (await helper!.findMovies(text))!;
    setState(() {
      moviesCount = movies.length;
      movies = movies;
    });
  }

  Future initialize() async {
    movies = List<dynamic>.empty();
    movies = (await helper!.getUpcoming())!;
    setState(() {
      moviesCount = movies.length;
      movies = movies;
    });
    print('# DEBUG : movie count = $moviesCount');
  }
}
