import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:movie_app/providers/movieandseries_provider.dart';

class MovieDetailWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var movie = Provider.of<MovieAndSeriesProvider>(context).selectedMovie;

    if (movie == null) {
      return Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(movie.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Image.network(movie.imageUrl),
                Positioned(
                  left: 16,
                  top: 16,
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(movie.imageUrl),
                    radius: 24,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Tür: ${movie.type}'),
                  Text('Yıl: ${movie.year}'),
                  Text('Süre: ${movie.duration} dakika'),
                  Text('IMDb Puanı: ${movie.rating}'),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () async {
                      // Trailer linkini aç
                      final url = movie.trailer;
                      if (await canLaunch(url)) {
                        await launch(url);
                      } else {
                        throw Exception('Trailer linkini açamıyorum: $url');
                      }
                    },
                    child: Text('Play Trailer'),
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          // Beğen butonuna basıldığında
                        },
                        icon: Icon(Icons.thumb_up),
                        color: Colors.green,
                      ),
                      IconButton(
                        onPressed: () {
                          // Beğenme butonuna basıldığında
                        },
                        icon: Icon(Icons.thumb_down),
                        color: Colors.red,
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Text(movie.description),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // My List'e ekle
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
