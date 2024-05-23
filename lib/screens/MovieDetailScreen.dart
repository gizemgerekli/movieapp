import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:movie_app/providers/movieandseries_provider.dart';
import 'package:movie_app/widgets/movie_detail_widget.dart';

class MovieDetailScreen extends StatelessWidget {
  final String movieId;

  MovieDetailScreen(this.movieId);

  @override
  Widget build(BuildContext context) {
    var movieProvider = Provider.of<MovieAndSeriesProvider>(context, listen: false);
    movieProvider.fetchMovie(movieId);

    return Scaffold(
      appBar: AppBar(
        title: Text('Film Detayları'),
      ),
      body: Consumer<MovieAndSeriesProvider>(
        builder: (ctx, movieProvider, _) => movieProvider.selectedMovie == null
            ? Center(child: CircularProgressIndicator())
            : MovieDetailWidget(),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          // Burada filmi izleme listesine ekleme işlemlerini yapmam gerekiyor
        },
      ),
    );
  }
}
