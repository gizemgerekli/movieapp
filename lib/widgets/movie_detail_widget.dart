import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:movie_app/providers/movieandseries_provider.dart';

class MovieDetailWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var movie = Provider.of<MovieAndSeriesProvider>(context).selectedMovie;

    // Eğer seçili bir film yoksa, bir yükleniyor göstergesi gösterir
    if (movie == null) {
      return Center(child: CircularProgressIndicator());
    }
    
    return Scaffold(
      appBar: AppBar(
        title: Text(movie.name),
      ),
      body: Column(
        children: [
          Image.network(movie.imageUrl),
          Text(movie.name),
          Text(movie.type),
          Text('${movie.duration} dakika'),
          Text('${movie.rating} puan'),
          Text(movie.description),
        ],
      ),
    );
  }
}
